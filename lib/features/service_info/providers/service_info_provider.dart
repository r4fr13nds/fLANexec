import 'package:flanexec/core/networking/models/service_info.dart';
import 'package:flanexec/core/networking/service_detector.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ServiceInfoState {
  final bool isLoading;
  final ServiceInfo? result;
  final String? error;

  ServiceInfoState({this.isLoading = false, this.result, this.error});

  ServiceInfoState copyWith({bool? isLoading, ServiceInfo? result, String? error}) {
    return ServiceInfoState(
      isLoading: isLoading ?? this.isLoading,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}

class ServiceInfoNotifier extends StateNotifier<ServiceInfoState> {
  ServiceInfoNotifier() : super(ServiceInfoState());

  Future<void> probeService(String host, int port) async {
    state = state.copyWith(isLoading: true, error: null, result: null);
    try {
      final info = await ServiceDetector.probe(host, port);
      state = state.copyWith(isLoading: false, result: info);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clear() {
    state = ServiceInfoState();
  }
}

final serviceInfoProvider = StateNotifierProvider<ServiceInfoNotifier, ServiceInfoState>((ref) {
  return ServiceInfoNotifier();
});
