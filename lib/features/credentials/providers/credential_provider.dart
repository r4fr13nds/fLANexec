import 'dart:convert';
import 'package:flanexec/features/credentials/models/credential_set.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CredentialNotifier extends StateNotifier<List<CredentialSet>> {
  final _storage = const FlutterSecureStorage(
    mOptions: MacOsOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );
  static const _key = 'credentials_list';

  CredentialNotifier() : super([]) {
    load();
  }

  Future<void> load() async {
    final data = await _storage.read(key: _key);
    if (data != null) {
      final List decoded = json.decode(data);
      state = decoded.map((e) => CredentialSet.fromJson(e)).toList();
    }
  }

  Future<void> add(CredentialSet cred) async {
    state = [...state, cred];
    await _save();
  }

  Future<void> delete(String id) async {
    state = state.where((e) => e.id != id).toList();
    await _save();
  }

  Future<void> _save() async {
    final encoded = json.encode(state.map((e) => e.toJson()).toList());
    await _storage.write(key: _key, value: encoded);
  }
}

final credentialProvider = StateNotifierProvider<CredentialNotifier, List<CredentialSet>>((ref) {
  return CredentialNotifier();
});

final selectedHostsProvider = StateProvider<Set<String>>((ref) => {});
final selectedProtocolProvider = StateProvider<CredentialType>((ref) => CredentialType.smb);
final activeCredentialProvider = StateProvider<String?>((ref) => null);
