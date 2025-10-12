import 'package:flutter_bloc/flutter_bloc.dart';

/// Dùng để debug & quan sát mọi Bloc trong app
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('🌀 [${bloc.runtimeType}] ${change.currentState} → ${change.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('❌ [${bloc.runtimeType}] Error: $error');
    super.onError(bloc, error, stackTrace);
  }
}
