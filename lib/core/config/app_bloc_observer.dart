import 'package:flutter_bloc/flutter_bloc.dart';

/// [AppBlocObserver] dùng để giám sát toàn bộ các Bloc trong app.
/// Có thể dùng để log, bắt lỗi, hoặc gửi event lên analytics.
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // Ghi log toàn bộ event khi debug
    print('🟩 [Event] ${bloc.runtimeType}: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // Log state thay đổi (chỉ Cubit & Bloc)
    print('🌀 [Change] ${bloc.runtimeType}: ${change.currentState} → ${change.nextState}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // Log transition chi tiết (Bloc)
    print('🔁 [Transition] ${bloc.runtimeType}: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // Ghi log lỗi toàn bộ Bloc/Cubit
    print('❌ [Error] ${bloc.runtimeType}: $error');
    super.onError(bloc, error, stackTrace);
  }
}
