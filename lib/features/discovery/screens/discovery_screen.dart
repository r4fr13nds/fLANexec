import 'package:flanexec/features/discovery/providers/discovery_session.dart';
import 'package:flanexec/features/discovery/providers/scan_config.dart';
import 'package:flanexec/features/discovery/widgets/host_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DiscoveryScreen extends HookConsumerWidget {
  const DiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(scanConfigProvider);
    final session = ref.watch(discoverySessionProvider);
    final configNotifier = ref.read(scanConfigProvider.notifier);
    final sessionNotifier = ref.read(discoverySessionProvider.notifier);

    // Using a controller to prevent keyboard from hiding on every keystroke
    final ipController = useTextEditingController(text: config.ip);
    
    // Update controller if provider changes (e.g. during init) 
    // but only if user isn't typing (don't overwrite their work)
    useEffect(() {
      if (ipController.text != config.ip && config.ip.isNotEmpty) {
        ipController.text = config.ip;
      }
      return null;
    }, [config.ip]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discovery'),
        actions: [
          if (session.status == DiscoveryStatus.done)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {},
            ),
        ],
      ),
      body: Column(
        children: [
          _buildConfigHeader(context, config, configNotifier, session, ipController),
          if (session.status == DiscoveryStatus.scanning || session.status == DiscoveryStatus.done) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: session.progress,
                    backgroundColor: Colors.grey.withValues(alpha: 0.1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          session.status == DiscoveryStatus.scanning 
                            ? 'Scanning: ${session.currentIp ?? ''}' 
                            : 'Scan Complete',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: session.status == DiscoveryStatus.done ? Colors.green : null,
                            fontWeight: session.status == DiscoveryStatus.done ? FontWeight.bold : null,
                          ),
                        ),
                        Text(
                          '${(session.progress * 100).toStringAsFixed(1)}%',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          Expanded(
            child: session.hosts.isEmpty && session.status == DiscoveryStatus.idle
                ? _buildEmptyState(context, sessionNotifier)
                : ListView.builder(
                    itemCount: session.hosts.length,
                    itemBuilder: (context, index) {
                      return HostListTile(host: session.hosts[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: session.status == DiscoveryStatus.scanning
            ? sessionNotifier.cancelScan
            : sessionNotifier.startScan,
        label: Text(session.status == DiscoveryStatus.scanning ? 'Cancel' : 'Start Scan'),
        icon: Icon(session.status == DiscoveryStatus.scanning ? Icons.stop : Icons.search),
        backgroundColor: session.status == DiscoveryStatus.scanning ? Colors.red : null,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, DiscoverySessionNotifier notifier) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.radar, size: 100, color: Colors.blue.withValues(alpha: 0.2)),
          const SizedBox(height: 16),
          Text(
            'Ready to Explore',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text('Scan your network to find alive hosts and services.'),
        ],
      ),
    );
  }

  Widget _buildConfigHeader(
    BuildContext context,
    ScanConfig config,
    ScanConfigNotifier notifier,
    DiscoveryState session,
    TextEditingController ipController,
  ) {
    final isScanning = session.status == DiscoveryStatus.scanning;

    return Card(
      margin: const EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: ipController,
                    decoration: const InputDecoration(
                      labelText: 'Base IP',
                      hintText: '192.168.1.0',
                    ),
                    onChanged: notifier.updateIp,
                    enabled: !isScanning,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<int>(
                    isExpanded: true,
                    initialValue: config.mask,
                    decoration: const InputDecoration(labelText: 'Mask'),
                    items: [8, 16, 23, 24, 25, 30, 32].map((m) {
                      return DropdownMenuItem(value: m, child: Text('/$m'));
                    }).toList(),
                    onChanged: isScanning ? null : (v) => notifier.updateMask(v!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<PortProfile>(
              initialValue: config.profile,
              decoration: const InputDecoration(labelText: 'Port Profile'),
              items: PortProfile.values.map((p) {
                return DropdownMenuItem(value: p, child: Text(p.label));
              }).toList(),
              onChanged: isScanning ? null : (v) => notifier.updateProfile(v!),
            ),
            if (config.profile == PortProfile.custom)
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Custom Ports',
                    hintText: '80,443,8080',
                  ),
                  onChanged: notifier.updateCustomPorts,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
