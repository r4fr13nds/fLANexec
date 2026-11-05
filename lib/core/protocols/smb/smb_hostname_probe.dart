import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

class SmbIdentity {
  final String? netbiosName;
  final String? dnsName;
  final String? domain;
  final String? nativeOs;
  final bool isDomainController;

  SmbIdentity({
    this.netbiosName,
    this.dnsName,
    this.domain,
    this.nativeOs,
    this.isDomainController = false,
  });

  @override
  String toString() => 'SmbIdentity(name: $netbiosName, dns: $dnsName, domain: $domain, os: $nativeOs, dc: $isDomainController)';
}

class SmbHostnameProbe {
  static Future<SmbIdentity?> probe(String ip, {int port = 445, Duration timeout = const Duration(milliseconds: 1500)}) async {
    Socket? socket;
    try {
      socket = await Socket.connect(ip, port, timeout: timeout);
      
      // 1. Send SMB1 Negotiate Protocol Request (requesting NT LM 0.12)
      // This is often enough to trigger an NTLMSSP challenge in the response if GSSAPI is used.
      final negotiatePacket = _buildSmb1Negotiate();
      socket.add(negotiatePacket);
      await socket.flush();
      
      final completer = Completer<Uint8List>();
      final subscription = socket.listen(
        (data) {
          if (!completer.isCompleted) completer.complete(data);
        },
        onError: (e) {
          if (!completer.isCompleted) completer.completeError(e);
        },
        cancelOnError: true,
      );
      
      final response = await completer.future.timeout(timeout);
      subscription.cancel();
      
      return _parseNegotiateResponse(response);
    } catch (_) {
      return null;
    } finally {
      socket?.destroy();
    }
  }

  static Uint8List _buildSmb1Negotiate() {
    // Basic SMB1 Negotiate Protocol
    final dialects = [
      'PC NETWORK PROGRAM 1.0',
      'LANMAN1.0',
      'Windows for Workgroups 3.1a',
      'LM1.2X002',
      'LANMAN2.1',
      'NT LM 0.12',
    ];
    
    int dialectsLen = dialects.fold(0, (prev, element) => prev + element.length + 2);
    final body = Uint8List(dialectsLen);
    int offset = 0;
    for (var d in dialects) {
      body[offset++] = 0x02; // Dialect prefix
      final dBytes = d.codeUnits;
      body.setRange(offset, offset + dBytes.length, dBytes);
      offset += dBytes.length;
      body[offset++] = 0x00; // Null terminator
    }
    
    final header = Uint8List(32);
    header[0] = 0xff;
    header[1] = 0x53; // 'S'
    header[2] = 0x4d; // 'M'
    header[3] = 0x42; // 'B'
    header[4] = 0x72; // Command: Negotiate
    header[13] = 0x18; // Flags2: Extended Security
    header[14] = 0x01;
    
    final packet = Uint8List(4 + 32 + 3 + body.length);
    final bd = ByteData.view(packet.buffer);
    bd.setUint32(0, 32 + 3 + body.length); // NetBIOS length
    packet.setRange(4, 36, header);
    packet[36] = 0; // Word count
    bd.setUint16(37, body.length); // Byte count
    packet.setRange(39, packet.length, body);
    
    return packet;
  }

  static SmbIdentity? _parseNegotiateResponse(Uint8List data) {
    // Very basic parsing to find NTLMSSP blob
    final dataStr = String.fromCharCodes(data);
    if (!dataStr.contains('NTLMSSP')) return null;
    
    final ntlmIndex = data.indexOf(0x4e); // 'N'
    if (ntlmIndex == -1 || ntlmIndex + 7 > data.length) return null;
    
    final magic = String.fromCharCodes(data.sublist(ntlmIndex, ntlmIndex + 7));
    if (magic != 'NTLMSSP') return null;
    
    // Type 2 Challenge offset
    final offset = ntlmIndex;
    final reader = ByteData.sublistView(data, offset);
    
    if (data.length < offset + 40) return null;
    
    // Check if it's Type 2 (Challenge)
    final type = reader.getUint32(8, Endian.little);
    if (type != 2) return null;
    
    // Target Name (Domain)
    final targetNameLen = reader.getUint16(12, Endian.little);
    final targetNameOffset = reader.getUint32(16, Endian.little);
    
    String? domain;
    if (offset + targetNameOffset + targetNameLen <= data.length) {
      domain = _decodeUtf16(data.sublist(offset + targetNameOffset, offset + targetNameOffset + targetNameLen));
    }
    
    // Target Info
    final targetInfoLen = reader.getUint16(40, Endian.little);
    final targetInfoOffset = reader.getUint32(44, Endian.little);
    
    String? netbiosName;
    String? dnsName;
    String? dnsDomain;
    String? nativeOs;
    
    if (offset + targetInfoOffset + targetInfoLen <= data.length) {
      final info = data.sublist(offset + targetInfoOffset, offset + targetInfoOffset + targetInfoLen);
      var infoOffset = 0;
      while (infoOffset + 4 <= info.length) {
        final pairReader = ByteData.sublistView(info, infoOffset);
        final id = pairReader.getUint16(0, Endian.little);
        final len = pairReader.getUint16(2, Endian.little);
        if (id == 0) break; // End of pairs
        
        if (infoOffset + 4 + len <= info.length) {
          final value = _decodeUtf16(info.sublist(infoOffset + 4, infoOffset + 4 + len));
          if (id == 1) {
            netbiosName = value; // MsvAvNbComputerName
          } else if (id == 2) {
            domain ??= value; // MsvAvNbDomainName
          } else if (id == 3) {
            dnsName = value; // MsvAvDnsComputerName
          } else if (id == 4) {
            dnsDomain = value; // MsvAvDnsDomainName
          }
        }
        infoOffset += 4 + len;
      }
    }

    // Try to find the Native OS string in the response. 
    // It's usually after the security blob in SMB1.
    final remainingData = data.sublist(offset + targetInfoOffset + targetInfoLen);
    try {
      // Find strings separated by nulls
      final parts = _decodeUtf16(remainingData).split('\u0000');
      if (parts.isNotEmpty && parts[0].length > 3) {
        nativeOs = parts[0];
      }
    } catch (_) {}
    
    return SmbIdentity(
      netbiosName: netbiosName,
      dnsName: dnsName,
      domain: dnsDomain ?? domain,
      nativeOs: nativeOs,
    );
  }

  static String _decodeUtf16(Uint8List bytes) {
    try {
      final chars = <int>[];
      for (var i = 0; i < bytes.length; i += 2) {
        if (i + 1 < bytes.length) {
          chars.add(bytes[i] | (bytes[i+1] << 8));
        }
      }
      return String.fromCharCodes(chars);
    } catch (_) {
      return String.fromCharCodes(bytes).replaceAll('\u0000', '');
    }
  }
}
