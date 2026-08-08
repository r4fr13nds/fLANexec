import 'package:hooks_riverpod/hooks_riverpod.dart';

enum LogLevel { info, warn, error }

class LogEntry {
  final DateTime timestamp;
  final String target;
  final LogLevel level;
  final String message;
  final Duration? duration;

  LogEntry({
    required this.timestamp,
    required this.target,
    required this.level,
    required this.message,
    this.duration,
  });

  @override
  String toString() {
    return '[${timestamp.toIso8601String()}] [$level] ($target) $message';
  }
}

class LoggerNotifier extends StateNotifier<List<LogEntry>> {
  LoggerNotifier() : super([]);

  void log(String target, String message, {LogLevel level = LogLevel.info, Duration? duration}) {
    final entry = LogEntry(
      timestamp: DateTime.now(),
      target: target,
      level: level,
      message: message,
      duration: duration,
    );
    state = [...state, entry].take(1000).toList(); // Keep last 1000 logs
  }

  void clear() {
    state = [];
  }
}

final loggerProvider = StateNotifierProvider<LoggerNotifier, List<LogEntry>>((ref) {
  return LoggerNotifier();
});

final logPanelVisibleProvider = StateProvider<bool>((ref) => false);
