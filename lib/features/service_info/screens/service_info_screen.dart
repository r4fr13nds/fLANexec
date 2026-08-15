import 'package:flanexec/features/discovery/providers/discovery_session.dart';
import 'package:flanexec/features/service_info/providers/service_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ServiceInfoScreen extends HookConsumerWidget {
  const ServiceInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(discoverySessionProvider);
    final serviceState = ref.watch(serviceInfoProvider);
    final notifier = ref.read(serviceInfoProvider.notifier);

    final hostController = useTextEditingController();
    final portController = useTextEditingController(text: '80');

    // Filter hosts that have open ports
    final hostsWithPorts = session.hosts.where((h) => h.ports.isNotEmpty).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Info'),
        actions: [
          if (serviceState.result != null) ...[
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: _formatNmapOutput(serviceState.result!)));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
              },
            ),
          ]
        ],
      ),
      body: Column(
        children: [
          _buildSelectionHeader(context, hostsWithPorts, notifier, hostController, portController),
          if (serviceState.isLoading) const LinearProgressIndicator(),
          if (serviceState.error != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Error: ${serviceState.error}', style: const TextStyle(color: Colors.red)),
            ),
          if (serviceState.result != null)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _formatNmapOutput(serviceState.result!),
                        style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Raw Output / Banner:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(serviceState.result!.rawOutput),
                  ],
                ),
              ),
            )
          else if (!serviceState.isLoading)
            const Expanded(
              child: Center(child: Text('Select a host and port to probe')),
            ),
        ],
      ),
    );
  }

  Widget _buildSelectionHeader(
    BuildContext context,
    List<dynamic> hosts,
    ServiceInfoNotifier notifier,
    TextEditingController hostController,
    TextEditingController portController,
  ) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Manual Probe', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: hostController,
                    decoration: const InputDecoration(hintText: '192.168.1.1', labelText: 'Host'),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: portController,
                    decoration: const InputDecoration(hintText: '80', labelText: 'Port'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final host = hostController.text.trim();
                    final port = int.tryParse(portController.text.trim());
                    if (host.isNotEmpty && port != null) {
                      notifier.probeService(host, port);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a valid host and port')),
                      );
                    }
                  },
                ),
              ],
            ),
            if (hosts.isNotEmpty) ...[
              const Divider(height: 32),
              ExpansionTile(
                title: const Text('From Discovery Results', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: const Text('Tap to auto-fill host and port', style: TextStyle(fontSize: 12)),
                childrenPadding: const EdgeInsets.only(bottom: 16),
                tilePadding: EdgeInsets.zero,
                initiallyExpanded: false,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: hosts.expand((h) => h.ports.map((p) => ActionChip(
                      label: Text('${h.ip}:${p.port}', style: const TextStyle(fontSize: 11)),
                      onPressed: () {
                        hostController.text = h.ip;
                        portController.text = p.port.toString();
                        notifier.probeService(h.ip, p.port);
                      },
                    ))).cast<Widget>().toList().take(30).toList(),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatNmapOutput(dynamic info) {
    final buffer = StringBuffer();
    buffer.writeln('PORT     STATE SERVICE  VERSION');
    final portLine = '${info.port}/tcp'.padRight(9);
    final state = 'open'.padRight(6);
    final service = info.service.padRight(9);
    final version = [info.product, info.version].whereType<String>().join(' ');
    buffer.writeln('$portLine $state $service $version');
    
    if (info.extraInfo != null) {
      buffer.writeln('|_extra-info: ${info.extraInfo}');
    }

    if (info.scripts.isNotEmpty) {
      info.scripts.forEach((name, output) {
        buffer.writeln('|_$name: $output');
      });
    }
    
    if (info.osGuess != null) {
      buffer.writeln('\nOS details: ${info.osGuess}');
    }
    
    return buffer.toString();
  }
}
