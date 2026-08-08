import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

class NbnsResult {
  final String? netbiosName;
  final String? domain;
  final String? macAddress;
  final bool isDomainController;

  NbnsResult({
    this.netbiosName,
    this.domain,
    this.macAddress,
    this.isDomainController = false,
  });

  @override
  String toString() => 'NbnsResult(name: $netbiosName, domain: $domain, mac: $macAddress, dc: $isDomainController)';
}

class NbnsResolver {
  static Future<NbnsResult?> query(String ip, {Duration timeout = const Duration(milliseconds: 1500)}) async {
    RawDatagramSocket? socket;
    try {
      socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
      
      final transactionId = Random().nextInt(0xFFFF);
      final packet = _buildNbstatPacket(transactionId);
      
      socket.send(packet, InternetAddress(ip), 137);

      final completer = Completer<NbnsResult?>();
      
      socket.listen((event) {
        if (event == RawSocketEvent.read) {
          final datagram = socket!.receive();
          if (datagram != null) {
            final result = _parseNbstatResponse(datagram.data);
            if (result != null && !completer.isCompleted) {
              completer.complete(result);
            }
          }
        }
      });

      return await completer.future.timeout(timeout, onTimeout: () => null);
    } catch (_) {
      return null;
    } finally {
      socket?.close();
    }
  }

  static Uint8List _buildNbstatPacket(int transactionId) {
    final bytes = ByteData(50);
    bytes.setUint16(0, transactionId); // Transaction ID
    bytes.setUint16(2, 0x0010);        // Flags: Standard query
    bytes.setUint16(4, 0x0001);        // Questions: 1
    bytes.setUint16(6, 0x0000);        // Answer RRs: 0
    bytes.setUint16(8, 0x0000);        // Authority RRs: 0
    bytes.setUint16(10, 0x0000);       // Additional RRs: 0
    
    // Question Name: * (encoded as CKAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA)
    bytes.setUint8(12, 32); // Length 32
    final encodedName = 'CKAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'.codeUnits;
    for (var i = 0; i < encodedName.length; i++) {
      bytes.setUint8(13 + i, encodedName[i]);
    }
    bytes.setUint8(45, 0); // Terminator
    
    bytes.setUint16(46, 0x0021); // Type: NBSTAT
    bytes.setUint16(48, 0x0001); // Class: IN
    
    return bytes.buffer.asUint8List();
  }

  static NbnsResult? _parseNbstatResponse(Uint8List data) {
    if (data.length < 56) return null;
    
    final reader = ByteData.sublistView(data);
    // Skip header (12 bytes) + question (34 bytes) = 46 bytes
    // We expect an answer here.
    
    // The structure depends on the exact response, but usually:
    // 0-11: Header
    // 12-45: Question Name
    // 46-47: Question Type
    // 48-49: Question Class
    // 50-53: TTL (approx)
    // 54-55: Data Length
    
    final dataLen = reader.getUint16(54);
    if (data.length < 56 + dataLen) return null;
    
    int offset = 56;
    final numNames = data[offset];
    offset++;
    
    String? name;
    String? domain;
    bool isDc = false;
    
    for (int i = 0; i < numNames; i++) {
      if (offset + 18 > data.length) break;
      
      final nameBytes = data.sublist(offset, offset + 15);
      final suffix = data[offset + 15];
      // final flags = reader.getUint16(offset + 16);
      
      final cleanName = String.fromCharCodes(nameBytes).trim();
      
      if (suffix == 0x20 && name == null) {
        name = cleanName;
      } else if (suffix == 0x00 && domain == null) {
        // Could be computer name or domain name
        // Usually, the first 0x00 is the computer name, but we prefer 0x20 for server
        if (name == null) {
          name = cleanName;
        } else {
          domain = cleanName;
        }
      } else if (suffix == 0x1C) {
        isDc = true;
        domain = cleanName;
      }
      
      offset += 18;
    }
    
    String? mac;
    if (offset + 6 <= data.length) {
      final macBytes = data.sublist(offset, offset + 6);
      mac = macBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join(':').toUpperCase();
    }
    
    return NbnsResult(
      netbiosName: name,
      domain: domain,
      macAddress: mac,
      isDomainController: isDc,
    );
  }
}
