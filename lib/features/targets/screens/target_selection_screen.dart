import 'package:flanexec/features/discovery/providers/discovery_session.dart';
import 'package:flanexec/features/shared/models/host.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TargetSelectionScreen extends HookConsumerWidget {
  const TargetSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(discoverySessionProvider);
    final selectedHosts = ref.watch(selectedHostsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AD/LDAP Selection'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            _buildHostCard(context, session, ref),
            if (selectedHosts.isNotEmpty) ...[
              _buildLdapActionCard(context, selectedHosts, ref),
              _buildLdapResults(context, session, selectedHosts, ref),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLdapActionCard(BuildContext context, Set<String> selectedHosts, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('LDAP Actions', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Probing LDAP for ${selectedHosts.length} hosts...')),
                );
                for (final ip in selectedHosts) {
                  ref.read(discoverySessionProvider.notifier).probeLdapForHost(ip);
                }
              },
              icon: const Icon(Icons.lan),
              label: Text('Gather LDAP Info for ${selectedHosts.length} Targets'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLdapResults(BuildContext context, DiscoveryState session, Set<String> selectedHosts, WidgetRef ref) {
    final hostsToShow = session.hosts.where((h) => selectedHosts.contains(h.ip) && (h.domainInfo != null || session.activeProbes.contains(h.ip))).toList();

    if (hostsToShow.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text('Domain Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        ...hostsToShow.map((host) => Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: ExpansionTile(
                shape: const Border(),
                collapsedShape: const Border(),
                title: Text(host.ip, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(host.domainInfo?.domain ?? (session.activeProbes.contains(host.ip) ? 'Probing...' : 'Unknown Domain')),
                leading: session.activeProbes.contains(host.ip)
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.account_tree, color: Colors.blue),
                children: [
                  if (host.domainInfo != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoRow('Domain', host.domainInfo?.domain),
                          _infoRow('Forest', host.domainInfo?.forest),
                          _infoRow('DC Hostname', host.domainInfo?.dnsHostName),
                          _infoRow('Functional Level', host.domainInfo?.functionalLevel?.toString()),
                          _infoRow('Global Catalog', host.domainInfo?.isGlobalCatalog == true ? 'Yes' : 'No'),
                          if (host.domainInfo?.supportedMechs.isNotEmpty == true)
                            _infoRow('SASL Mechs', host.domainInfo?.supportedMechs.join(', ')),
                        ],
                      ),
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Waiting for probe results...', style: TextStyle(fontSize: 12)),
                    )
                ],
              ),
            )),
      ],
    );
  }

  Widget _infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
          Expanded(child: Text(value ?? 'N/A', style: const TextStyle(fontFamily: 'monospace', fontSize: 11))),
        ],
      ),
    );
  }

  Widget _buildHostCard(BuildContext context, DiscoveryState session, WidgetRef ref) {
    final selected = ref.watch(selectedHostsProvider);
    final notifier = ref.read(selectedHostsProvider.notifier);

    return Card(
      margin: const EdgeInsets.all(12),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          initiallyExpanded: true,
          title: Text('Select Targets (${selected.length})', style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(selected.isEmpty ? 'Pick hosts discovered on network' : selected.join(', ')),
          trailing: Wrap(
            children: [
              TextButton(
                onPressed: () => notifier.selectAll(),
                child: const Text('ALL'),
              ),
              TextButton(
                onPressed: () => notifier.clearAll(),
                child: const Text('NONE'),
              ),
            ],
          ),
          children: [
            if (session.hosts.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No hosts discovered yet. Run a discovery scan first.'),
              )
            else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('HTTP (80)'),
                      onSelected: (_) => notifier.selectByPort(80),
                    ),
                    FilterChip(
                      label: const Text('SMB (445)'),
                      onSelected: (_) => notifier.selectByPort(445),
                    ),
                    FilterChip(
                      label: const Text('WinRM (5985)'),
                      onSelected: (_) => notifier.selectByPort(5985),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: session.hosts.length,
                itemBuilder: (context, index) {
                  final host = session.hosts[index];
                  return CheckboxListTile(
                    title: Text(host.ip, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: _buildHostSubtitle(host),
                    secondary: _getOsIcon(host.osType),
                    value: selected.contains(host.ip),
                    onChanged: (_) => notifier.toggle(host.ip),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHostSubtitle(Host host) {
    final parts = <String>[];
    
    // 1. Domain/Workgroup
    if (host.domain != null && host.domain!.isNotEmpty) {
      parts.add(host.domain!.toUpperCase());
    }

    // 2. Hostname or NetBIOS
    final name = host.hostname ?? host.netbiosName;
    if (name != null && name.isNotEmpty) {
      parts.add(name);
    }

    // 3. OS Summary
    if (host.osType != HostOs.unknown) {
      final osInfo = host.osVersion ?? host.osType.name;
      parts.add('($osInfo)');
    }

    if (parts.isEmpty) {
      return const Text('Unknown System', style: TextStyle(fontStyle: FontStyle.italic));
    }

    return Text(parts.join(' \\ '));
  }

  Widget _getOsIcon(HostOs os) {
    switch (os) {
      case HostOs.windows:
        return const Icon(Icons.grid_view, color: Colors.blue, size: 20);
      case HostOs.linux:
        return const Icon(Icons.terminal, color: Colors.orange, size: 20);
      case HostOs.macos:
      case HostOs.ios:
        return const Icon(Icons.apple, color: Colors.grey, size: 20);
      case HostOs.android:
        return const Icon(Icons.android, color: Colors.green, size: 20);
      default:
        return const Icon(Icons.devices_other, size: 20);
    }
  }
}
