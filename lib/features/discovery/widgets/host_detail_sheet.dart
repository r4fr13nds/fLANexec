import 'package:flanexec/core/protocols/ldap/models/domain_info.dart';
import 'package:flanexec/features/discovery/providers/discovery_session.dart';
import 'package:flanexec/features/shared/models/host.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HostDetailSheet extends HookConsumerWidget {
  final Host host;

  const HostDetailSheet({super.key, required this.host});

  Widget _buildDomainSection(BuildContext context, DomainInfo info) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Domain Information', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildInfoRow('Domain:', info.domain ?? 'Unknown'),
          _buildInfoRow('Forest:', info.forest ?? 'Unknown'),
          _buildInfoRow('DNS Host:', info.dnsHostName ?? 'Unknown'),
          _buildInfoRow('Functional Level:', info.functionalLevel?.toString() ?? 'Unknown'),
          if (info.isGlobalCatalog)
            const Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text('• Global Catalog Ready', style: TextStyle(color: Colors.green, fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedHosts = ref.watch(selectedHostsProvider);
    final isTarget = selectedHosts.contains(host.ip);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Host Details: ${host.ip}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'OS: ${host.osVersion ?? host.osType.name.toUpperCase()}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  if (host.domainInfo != null) ...[
                    _buildDomainSection(context, host.domainInfo!),
                    const Divider(),
                  ],
                  const Divider(),
                  ...host.ports.map((port) => ListTile(
                        dense: true,
                        title: Text('Port ${port.port} (${port.protocol.toUpperCase()})'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('State: ${port.state}'),
                            if (port.banner != null)
                              Text('Banner: ${port.banner}',
                                  style: const TextStyle(fontSize: 10, fontStyle: FontStyle.italic)),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ref.read(selectedHostsProvider.notifier).toggle(host.ip);
                        },
                        icon: Icon(isTarget ? Icons.remove_circle_outline : Icons.add_circle_outline),
                        label: Text(isTarget ? 'Remove from Targets' : 'Add to Targets'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isTarget ? Colors.red.withValues(alpha: 0.1) : null,
                          foregroundColor: isTarget ? Colors.red : null,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
