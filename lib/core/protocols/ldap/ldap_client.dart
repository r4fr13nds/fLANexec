import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:asn1lib/asn1lib.dart';

class LdapEntry {
  final String dn;
  final Map<String, List<String>> attributes;

  LdapEntry(this.dn, this.attributes);

  @override
  String toString() => 'LdapEntry(dn: $dn, attributes: $attributes)';
}

class LdapClient {
  Socket? _socket;
  int _messageId = 1;

  Future<void> connect(String host, {int port = 389, bool useSsl = false, Duration? timeout}) async {
    if (useSsl) {
      _socket = await SecureSocket.connect(host, port, timeout: timeout);
    } else {
      _socket = await Socket.connect(host, port, timeout: timeout);
    }
  }

  Future<void> bind({String? dn, String? password}) async {
    final seq = ASN1Sequence();
    seq.add(ASN1Integer(BigInt.from(_messageId++)));

    final bindRequest = ASN1Sequence(tag: 0x60); // [APPLICATION 0] BindRequest
    bindRequest.add(ASN1Integer(BigInt.from(3))); // version v3
    bindRequest.add(ASN1OctetString(dn ?? ''));
    
    if (password != null) {
      bindRequest.add(ASN1OctetString(password, tag: 0x80)); // [0] Simple Authentication
    } else {
      bindRequest.add(ASN1OctetString('', tag: 0x80)); // Anonymous
    }
    
    seq.add(bindRequest);
    
    _socket!.add(seq.encodedBytes);
    await _socket!.flush();

    await _readMessage(); // Consume response
  }

  Future<List<LdapEntry>> search(String baseDn, String filter, {
    List<String> attributes = const [],
    int sizeLimit = 1000,
  }) async {
    final seq = ASN1Sequence();
    seq.add(ASN1Integer(BigInt.from(_messageId++)));

    final searchRequest = ASN1Sequence(tag: 0x63); // [APPLICATION 3] SearchRequest
    searchRequest.add(ASN1OctetString(baseDn));
    searchRequest.add(ASN1Enumerated(0)); // scope: baseObject(0)
    searchRequest.add(ASN1Enumerated(0)); // derefAliases: neverDerefAliases(0)
    searchRequest.add(ASN1Integer(BigInt.from(sizeLimit)));
    searchRequest.add(ASN1Integer(BigInt.from(0))); // timeLimit
    searchRequest.add(ASN1Boolean(false));
    
    // Minimal filter parser or just (objectClass=*)
    if (filter == '(objectClass=*)') {
      searchRequest.add(ASN1OctetString('objectClass', tag: 0x87)); // [7] present
    } else {
      searchRequest.add(ASN1OctetString('objectClass', tag: 0x87));
    }

    final attrSeq = ASN1Sequence();
    for (var attr in attributes) {
      attrSeq.add(ASN1OctetString(attr));
    }
    searchRequest.add(attrSeq);
    
    seq.add(searchRequest);
    
    _socket!.add(seq.encodedBytes);
    await _socket!.flush();

    final List<LdapEntry> entries = [];
    
    while (true) {
      final msg = await _readMessage();
      if (msg == null) break;
      
      final protocolOp = msg.elements[1];
      if (protocolOp.tag == 0x64) { // SearchResultEntry
        entries.add(_parseEntry(protocolOp as ASN1Sequence));
      } else if (protocolOp.tag == 0x65) { // SearchResultDone
        break;
      }
    }
    
    return entries;
  }

  Future<LdapEntry?> searchRootDse() async {
    final results = await search('', '(objectClass=*)', attributes: [
      'defaultNamingContext',
      'rootDomainNamingContext',
      'dnsHostName',
      'ldapServiceName',
      'serverName',
      'supportedLDAPVersion',
      'domainControllerFunctionality',
      'supportedSASLMechanisms',
      'isGlobalCatalogReady'
    ]);
    return results.isNotEmpty ? results.first : null;
  }

  void close() {
    _socket?.destroy();
  }

  Future<ASN1Sequence?> _readMessage() async {
    final completer = Completer<Uint8List>();
    final List<int> buffer = [];
    
    final sub = _socket!.listen((data) {
      buffer.addAll(data);
      try {
        final parser = ASN1Parser(Uint8List.fromList(buffer));
        if (parser.hasNext()) {
          completer.complete(Uint8List.fromList(buffer));
        }
      } catch (_) {}
    });

    try {
      final data = await completer.future.timeout(const Duration(seconds: 3));
      sub.cancel();
      return ASN1Parser(data).nextObject() as ASN1Sequence;
    } catch (_) {
      sub.cancel();
      return null;
    }
  }

  LdapEntry _parseEntry(ASN1Sequence seq) {
    final dn = (seq.elements[0] as ASN1OctetString).stringValue;
    final attrSeq = seq.elements[1] as ASN1Sequence;
    final Map<String, List<String>> attributes = {};
    
    for (var attr in attrSeq.elements) {
      final s = attr as ASN1Sequence;
      final name = (s.elements[0] as ASN1OctetString).stringValue;
      final valuesSeq = s.elements[1] as ASN1Set;
      final List<String> values = [];
      for (var v in valuesSeq.elements) {
        values.add((v as ASN1OctetString).stringValue);
      }
      attributes[name] = values;
    }
    
    return LdapEntry(dn, attributes);
  }
}
