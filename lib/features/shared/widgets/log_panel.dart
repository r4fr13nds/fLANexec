import 'package:flanexec/app.dart';
import 'package:flanexec/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class LogPanel extends ConsumerWidget {
  const LogPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(loggerProvider);
    final isVisible = ref.watch(logPanelVisibleProvider);
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    if (!isVisible) return const SizedBox.shrink();

    final panel = Material(
      elevation: 8,
      child: Column(
        children: [
          AppBar(
            title: const Text('Network Logs'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.delete_sweep),
                onPressed: () => ref.read(loggerProvider.notifier).clear(),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => ref.read(logPanelVisibleProvider.notifier).state = false,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[logs.length - 1 - index]; // Show latest first
                return _LogEntryTile(log: log);
              },
            ),
          ),
        ],
      ),
    );

    if (isDesktop) {
      return Positioned(
        right: 0,
        top: 0,
        bottom: 0,
        width: 400,
        child: panel,
      );
    }

    return Positioned.fill(child: panel);
  }
}

class _LogEntryTile extends StatelessWidget {
  final LogEntry log;

  const _LogEntryTile({required this.log});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeStr = DateFormat('HH:mm:ss').format(log.timestamp);

    Color? color;
    switch (log.level) {
      case LogLevel.error:
        color = Colors.red;
        break;
      case LogLevel.warn:
        color = Colors.orange;
        break;
      default:
        color = null;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(timeStr, style: theme.textTheme.monoSmall.copyWith(color: Colors.grey)),
              const SizedBox(width: 8),
              Text(log.target, style: theme.textTheme.monoSmall.copyWith(fontWeight: FontWeight.bold)),
              if (log.duration != null) ...[
                const SizedBox(width: 8),
                Text('${log.duration!.inMilliseconds}ms', style: theme.textTheme.monoSmall.copyWith(color: Colors.blue)),
              ],
            ],
          ),
          Text(
            log.message,
            style: theme.textTheme.monoSmall.copyWith(color: color),
          ),
          const Divider(height: 8),
        ],
      ),
    );
  }
}
