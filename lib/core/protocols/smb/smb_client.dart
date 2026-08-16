import 'package:flutter/services.dart';
import 'package:flanexec/core/protocols/smb/models/smb_models.dart';

abstract class SmbClient {
  Future<SmbAuthResult> authenticate(
    String host, {
    required String username,
    required String password,
    String? domain,
    String? hash,
    int port = 445,
  });

  Future<List<SmbShare>> enumerateShares(
    String host, {
    required String username,
    required String password,
    String? domain,
  });

  Future<List<SmbDirEntry>> listShare(
    String host, {
    required String username,
    required String password,
    required String shareName,
    String? domain,
    String path = r'\',
  });

  Future<SmbAccessResult> checkWriteAccess(
    String host, {
    required String username,
    required String password,
    required String shareName,
    String? domain,
  });
}

class PlatformSmbClient implements SmbClient {
  static const MethodChannel _channel = MethodChannel('com.r4fr13nds.flanexec/smb');

  @override
  Future<SmbAuthResult> authenticate(
    String host, {
    required String username,
    required String password,
    String? domain,
    String? hash,
    int port = 445,
  }) async {
    try {
      final result = await _channel.invokeMethod('authenticate', {
        'host': host,
        'username': username,
        'password': password,
        'domain': domain,
        'hash': hash,
        'port': port,
      });
      return SmbAuthResult.fromJson(Map<String, dynamic>.from(result));
    } on PlatformException catch (e) {
      return SmbAuthResult(success: false, error: e.message);
    } catch (e) {
      return SmbAuthResult(success: false, error: e.toString());
    }
  }

  @override
  Future<List<SmbShare>> enumerateShares(
    String host, {
    required String username,
    required String password,
    String? domain,
  }) async {
    try {
      final List result = await _channel.invokeMethod('enumerateShares', {
        'host': host,
        'username': username,
        'password': password,
        'domain': domain,
      });
      return result.map((e) => SmbShare.fromJson(Map<String, dynamic>.from(e))).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<SmbDirEntry>> listShare(
    String host, {
    required String username,
    required String password,
    required String shareName,
    String? domain,
    String path = r'\',
  }) async {
    try {
      final List result = await _channel.invokeMethod('listShare', {
        'host': host,
        'username': username,
        'password': password,
        'shareName': shareName,
        'domain': domain,
        'path': path,
      });
      return result.map((e) => SmbDirEntry.fromJson(Map<String, dynamic>.from(e))).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<SmbAccessResult> checkWriteAccess(
    String host, {
    required String username,
    required String password,
    required String shareName,
    String? domain,
  }) async {
    try {
      final result = await _channel.invokeMethod('checkWriteAccess', {
        'host': host,
        'username': username,
        'password': password,
        'shareName': shareName,
        'domain': domain,
      });
      return SmbAccessResult.fromJson(Map<String, dynamic>.from(result));
    } catch (e) {
      return const SmbAccessResult(readable: false, writable: false);
    }
  }
}
