import 'package:flanexec/features/discovery/widgets/host_detail_sheet.dart';
import 'package:flanexec/features/shared/models/host.dart';
import 'package:flutter/material.dart';

class HostListTile extends StatelessWidget {
  final Host host;

  const HostListTile({super.key, required this.host});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: host.status == 'alive' ? Colors.green : Colors.grey,
          radius: 8,
        ),
        title: Row(
          children: [
            Text(host.ip, style: const TextStyle(fontWeight: FontWeight.bold)),
            if (host.hostname != null) ...[
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '(${host.hostname})',
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
            if (host.isDomainController)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'DC',
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (host.rttMs != null)
              Text('RTT: ${host.rttMs!.toStringAsFixed(2)} ms', style: const TextStyle(fontSize: 12)),
            Wrap(
              spacing: 4,
              children: host.ports.take(6).map((p) {
                return Chip(
                  label: Text('${p.port}', style: const TextStyle(fontSize: 10)),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                );
              }).toList(),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => HostDetailSheet(host: host),
          );
        },
      ),
    );
  }
}
