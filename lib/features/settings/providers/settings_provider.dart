import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsState {
  final bool autoDiscover;
  final int defaultConcurrency;
  final int defaultTimeout;

  SettingsState({
    this.autoDiscover = false,
    this.defaultConcurrency = 50,
    this.defaultTimeout = 2,
  });

  SettingsState copyWith({
    bool? autoDiscover,
    int? defaultConcurrency,
    int? defaultTimeout,
  }) {
    return SettingsState(
      autoDiscover: autoDiscover ?? this.autoDiscover,
      defaultConcurrency: defaultConcurrency ?? this.defaultConcurrency,
      defaultTimeout: defaultTimeout ?? this.defaultTimeout,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState());

  void setAutoDiscover(bool value) => state = state.copyWith(autoDiscover: value);
  void setConcurrency(int value) => state = state.copyWith(defaultConcurrency: value);
  void setTimeout(int value) => state = state.copyWith(defaultTimeout: value);
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
