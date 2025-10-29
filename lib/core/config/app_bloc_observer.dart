import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_template/core/utils/logger.dart';

// lib/core/bloc/app_bloc_observer.dart
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // if (event != null) {
    //   Logger.blocEvent(bloc.runtimeType.toString(), event);
    // }

    // ✅ CHỈ log nếu enabled
    if (event != null && LogConfig.enableBlocLogs) {
      Logger.blocEvent(bloc.runtimeType.toString(), event);
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // Logger.blocState(
    //   bloc.runtimeType.toString(),
    //   change.currentState,
    //   change.nextState,
    // );

    // ✅ CHỈ log nếu enabled
    if (LogConfig.enableBlocLogs) {
      Logger.blocState(
        bloc.runtimeType.toString(),
        change.currentState,
        change.nextState,
      );
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Logger.blocError(bloc.runtimeType.toString(), error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
