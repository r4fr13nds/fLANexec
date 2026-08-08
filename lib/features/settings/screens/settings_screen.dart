import 'package:flanexec/features/discovery/providers/discovery_session.dart';
import 'package:flanexec/features/settings/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSection(context, 'Scan Preferences'),
          ListTile(
            title: const Text('Auto-discover on start'),
            subtitle: const Text('Automatically start a network scan when the app opens'),
            trailing: Switch(
              value: settings.autoDiscover,
              onChanged: (v) => notifier.setAutoDiscover(v),
            ),
          ),
          ListTile(
            title: const Text('Default Concurrency'),
            subtitle: const Text('Number of simultaneous network operations'),
            trailing: Text('${settings.defaultConcurrency}'),
            onTap: () => _showIntPicker(context, 'Concurrency', settings.defaultConcurrency, (v) => notifier.setConcurrency(v)),
          ),
          ListTile(
            title: const Text('Default Timeout'),
            subtitle: const Text('Socket timeout in seconds'),
            trailing: Text('${settings.defaultTimeout}s'),
            onTap: () => _showIntPicker(context, 'Timeout', settings.defaultTimeout, (v) => notifier.setTimeout(v)),
          ),
          const Divider(),
          _buildSection(context, 'Data Management'),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Export History'),
            subtitle: const Text('Save all scan results to a JSON file'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('History export coming soon')));
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Clear All History', style: TextStyle(color: Colors.red)),
            onTap: () {
              ref.read(discoverySessionProvider.notifier).clearHistory();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('History cleared')));
            },
          ),
          const Divider(),
          _buildSection(context, 'About'),
          const AboutListTile(
            applicationName: 'fLANexec',
            applicationVersion: '1.0.0',
            applicationLegalese: '© 2026 fLANexec Contributors',
            aboutBoxChildren: [
              Text('fLANexec is a multi-platform security tool for network discovery and service enumeration.'),
            ],
          ),
        ],
      ),
    );
  }

  void _showIntPicker(BuildContext context, String title, int current, Function(int) onSelected) {
    showDialog(
      context: context,
      builder: (context) {
        int val = current;
        return AlertDialog(
          title: Text('Select $title'),
          content: StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Slider(
                  value: val.toDouble(),
                  min: 1,
                  max: 200,
                  onChanged: (v) => setState(() => val = v.round()),
                ),
                Text('$val'),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                onSelected(val);
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSection(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
