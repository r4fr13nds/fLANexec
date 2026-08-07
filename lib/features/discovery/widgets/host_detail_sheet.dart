import 'package:flanexec/core/protocols/ldap/models/domain_info.dart';
import 'package:flanexec/features/shared/models/host.dart';
import 'package:flutter/material.dart';

class HostDetailSheet extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Host Details: ${host.ip}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            if (host.domainInfo != null) ...[
              _buildDomainSection(context, host.domainInfo!),
              const Divider(),
            ],
            const Divider(),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: host.ports.length,
                itemBuilder: (context, index) {
                  final port = host.ports[index];
                  return ListTile(
                    title: Text('Port ${port.port} (${port.protocol.toUpperCase()})'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('State: ${port.state}'),
                        if (port.banner != null)
                          Text('Banner: ${port.banner}', style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic)),
                      ],
                    ),
                    isThreeLine: port.banner != null,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Service Info
                      Navigator.pop(context);
                    },
                    child: const Text('Probe Service'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add to targets
                      Navigator.pop(context);
                    },
                    child: const Text('Add to Targets'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
