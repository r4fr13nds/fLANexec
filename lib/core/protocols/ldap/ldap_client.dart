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
  final StreamController<ASN1Sequence> _messageController = StreamController<ASN1Sequence>.broadcast();
  final List<int> _receiveBuffer = [];
  StreamSubscription? _socketSubscription;

  Future<void> connect(String host, {int port = 389, bool useSsl = false, Duration? timeout}) async {
    try {
      if (useSsl) {
        _socket = await SecureSocket.connect(host, port, timeout: timeout);
      } else {
        _socket = await Socket.connect(host, port, timeout: timeout);
      }
      _socketSubscription = _socket!.listen(_onData, onError: _onError, onDone: _onDone);
    } catch (e) {
      rethrow;
    }
  }

  void _onData(List<int> data) {
    _receiveBuffer.addAll(data);
    _parseBuffer();
  }

  void _parseBuffer() {
    try {
      while (_receiveBuffer.isNotEmpty) {
        final parser = ASN1Parser(Uint8List.fromList(_receiveBuffer));
        if (!parser.hasNext()) break;
        
        final obj = parser.nextObject();
        if (obj is ASN1Sequence) {
          _messageController.add(obj);
          _receiveBuffer.removeRange(0, obj.encodedBytes.length);
        } else {
          _receiveBuffer.clear(); // Safety clear
          break;
        }
      }
    } catch (e) {
      // Partial data or parse error, wait for more
    }
  }

  void _onError(Object error) {
    if (!_messageController.isClosed) {
      _messageController.addError(error);
    }
  }

  void _onDone() {
    close();
  }

  Future<void> bind({String? dn, String? password}) async {
    final seq = ASN1Sequence();
    seq.add(ASN1Integer(BigInt.from(_messageId++)));

    final bindRequest = ASN1Sequence(tag: 0x60); // BindRequest
    bindRequest.add(ASN1Integer(BigInt.from(3))); // version v3
    bindRequest.add(ASN1OctetString(dn ?? ''));
    
    if (password != null) {
      bindRequest.add(ASN1OctetString(password, tag: 0x80));
    } else {
      bindRequest.add(ASN1OctetString('', tag: 0x80));
    }
    
    seq.add(bindRequest);
    _socket!.add(seq.encodedBytes);

    final resp = await _messageController.stream
        .firstWhere((msg) => msg.elements[1].tag == 0x61)
        .timeout(const Duration(seconds: 5));
    
    final bindResponse = resp.elements[1] as ASN1Sequence;
    final resultCode = (bindResponse.elements[0] as ASN1Enumerated).intValue;
    if (resultCode != 0) {
      throw Exception('LDAP Bind failed with result code: $resultCode');
    }
  }

  Future<List<LdapEntry>> search(String baseDn, String filter, {
    List<String> attributes = const [],
    int scope = 2, // Default to wholeSubtree
    int sizeLimit = 1000,
  }) async {
    final seq = ASN1Sequence();
    final currentId = _messageId++;
    seq.add(ASN1Integer(BigInt.from(currentId)));

    final searchRequest = ASN1Sequence(tag: 0x63); // SearchRequest
    searchRequest.add(ASN1OctetString(baseDn));
    searchRequest.add(ASN1Enumerated(scope)); 
    searchRequest.add(ASN1Enumerated(0)); // neverDerefAliases
    searchRequest.add(ASN1Integer(BigInt.from(sizeLimit)));
    searchRequest.add(ASN1Integer(BigInt.from(0))); 
    searchRequest.add(ASN1Boolean(false));
    
    searchRequest.add(ASN1OctetString('objectClass', tag: 0x87)); 

    final attrSeq = ASN1Sequence();
    for (var attr in attributes) {
      attrSeq.add(ASN1OctetString(attr));
    }
    searchRequest.add(attrSeq);
    
    seq.add(searchRequest);
    _socket!.add(seq.encodedBytes);

    final List<LdapEntry> entries = [];
    final completer = Completer<List<LdapEntry>>();
    
    StreamSubscription? sub;
    sub = _messageController.stream.listen((msg) {
      final msgId = (msg.elements[0] as ASN1Integer).intValue;
      if (msgId != currentId) return;

      final protocolOp = msg.elements[1];
      if (protocolOp.tag == 0x64) { 
        entries.add(_parseEntry(protocolOp as ASN1Sequence));
      } else if (protocolOp.tag == 0x65) { 
        sub?.cancel();
        completer.complete(entries);
      }
    }, onError: (e) {
      sub?.cancel();
      completer.completeError(e);
    });

    return completer.future.timeout(const Duration(seconds: 10), onTimeout: () {
      sub?.cancel();
      return entries;
    });
  }

  Future<LdapEntry?> searchRootDse() async {
    final results = await search('', '(objectClass=*)', scope: 0, attributes: [
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
    _socketSubscription?.cancel();
    _socket?.destroy();
    if (!_messageController.isClosed) {
      _messageController.close();
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
