import 'package:flanexec/features/credentials/models/credential_set.dart';
import 'package:flanexec/features/credentials/providers/auth_session_provider.dart';
import 'package:flanexec/features/credentials/providers/credential_provider.dart';
import 'package:flanexec/features/discovery/providers/discovery_session.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class CredentialsScreen extends HookConsumerWidget {
  const CredentialsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credentials = ref.watch(credentialProvider);
    final session = ref.watch(discoverySessionProvider);
    final selectedHosts = ref.watch(selectedHostsProvider);
    final authResults = ref.watch(authSessionProvider);
    final activeCredId = ref.watch(activeCredentialProvider);
    final selectedProtocol = ref.watch(selectedProtocolProvider);

    final activeCred = credentials.where((c) => c.id == activeCredId).firstOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
        actions: [
          IconButton(
            icon: const Icon(Icons.manage_accounts),
            onPressed: () => _showCredentialManager(context, ref, credentials),
            tooltip: 'Manage Saved Credentials',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            _buildHostCard(context, session, ref),
            _buildActionCard(context, credentials, selectedProtocol, activeCred, ref),
            if (activeCred != null && selectedHosts.isNotEmpty)
              _buildResultsList(context, selectedHosts, activeCred, authResults),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (activeCred != null && selectedHosts.isNotEmpty)
            ? () {
                ref.read(authSessionProvider.notifier).checkAccess(
                      selectedHosts.toList(),
                      activeCred,
                      selectedProtocol,
                    );
              }
            : null,
        label: const Text('Run Auth Check'),
        icon: const Icon(Icons.play_arrow),
        backgroundColor: (activeCred != null && selectedHosts.isNotEmpty) ? null : Colors.grey,
      ),
    );
  }

  Widget _buildHostCard(BuildContext context, DiscoveryState session, WidgetRef ref) {
    final selected = ref.watch(selectedHostsProvider);
    return Card(
      margin: const EdgeInsets.all(12),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text('1. Select Targets (${selected.length})', style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(selected.isEmpty ? 'Pick hosts discovered on network' : selected.join(', ')),
          children: [
            if (session.hosts.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No hosts discovered yet. Run a discovery scan first.'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: session.hosts.length,
                itemBuilder: (context, index) {
                  final host = session.hosts[index];
                  return CheckboxListTile(
                    title: Text(host.ip),
                    subtitle: Text(host.hostname ?? 'Unknown'),
                    value: selected.contains(host.ip),
                    onChanged: (val) {
                      final newSet = Set<String>.from(selected);
                      if (val == true) {
                        newSet.add(host.ip);
                      } else {
                        newSet.remove(host.ip);
                      }
                      ref.read(selectedHostsProvider.notifier).state = newSet;
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    List<CredentialSet> allCreds,
    CredentialType selectedProtocol,
    CredentialSet? activeCred,
    WidgetRef ref,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('2. Select Protocol & Credential', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            DropdownButtonFormField<CredentialType>(
              value: selectedProtocol,
              decoration: const InputDecoration(
                labelText: 'Protocol',
                prefixIcon: Icon(Icons.lan_outlined),
              ),
              items: CredentialType.values.map((t) {
                return DropdownMenuItem(
                  value: t,
                  child: Text(t.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (v) {
                ref.read(selectedProtocolProvider.notifier).state = v!;
                // We keep the active cred if possible, but the user might need to pick a new one
              },
            ),
            const SizedBox(height: 12),
            if (allCreds.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: OutlinedButton.icon(
                  onPressed: () => _showAddCredentialDialog(context, ref),
                  icon: const Icon(Icons.add),
                  label: const Text('Add your first credential'),
                ),
              )
            else
              DropdownButtonFormField<String>(
                value: activeCred?.id,
                decoration: const InputDecoration(
                  labelText: 'Credential',
                  prefixIcon: Icon(Icons.vpn_key_outlined),
                ),
                items: allCreds.map((c) {
                  return DropdownMenuItem(
                    value: c.id,
                    child: Text('${c.name} (${c.username})'),
                  );
                }).toList(),
                onChanged: (v) => ref.read(activeCredentialProvider.notifier).state = v,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList(
    BuildContext context,
    Set<String> hosts,
    CredentialSet activeCred,
    Map<String, Map<String, AuthResultMatrix>> results,
  ) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 24, bottom: 8),
          child: Text('3. Results', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        ...hosts.map((h) {
          final res = results[h]?[activeCred.id];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: ExpansionTile(
              leading: _buildResultIcon(res),
              title: Text(h, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              subtitle: Text(
                res?.info ?? 'Awaiting execution...',
                style: TextStyle(
                  fontSize: 12, 
                  color: res?.success == true ? Colors.green : (res?.success == false ? Colors.red : null),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: res?.success == true 
                ? const Icon(Icons.check, color: Colors.green) 
                : (res?.success == false ? const Icon(Icons.close, color: Colors.red) : null),
              children: [
                if (res?.info != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SelectableText(
                        res!.info!,
                        style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildResultIcon(AuthResultMatrix? res) {
    if (res == null) return const Icon(Icons.circle_outlined, color: Colors.grey);
    if (res.success == null) {
      return const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2));
    }
    return Icon(
      res.success == true ? Icons.security : Icons.security_update_warning,
      color: res.success == true ? Colors.green : Colors.red,
    );
  }

  void _showCredentialManager(BuildContext context, WidgetRef ref, List<CredentialSet> credentials) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            AppBar(
              title: const Text('Manage Credentials'),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(icon: const Icon(Icons.add), onPressed: () => _showAddCredentialDialog(context, ref)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: credentials.length,
                itemBuilder: (context, index) {
                  final cred = credentials[index];
                  return ListTile(
                    leading: const Icon(Icons.vpn_key, color: Colors.blue),
                    title: Text(cred.name),
                    subtitle: Text(cred.username),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => ref.read(credentialProvider.notifier).delete(cred.id),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCredentialDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final userController = TextEditingController();
    final passController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Universal Credential'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name (e.g. Domain Admin)'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: userController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              ref.read(credentialProvider.notifier).add(CredentialSet(
                id: const Uuid().v4(),
                name: nameController.text,
                username: userController.text,
                password: passController.text,
              ));
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
