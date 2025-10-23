import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_template/core/utils/logger.dart';

/// [AppBlocObserver] dùng để giám sát toàn bộ các Bloc trong app.
/// Giúp log event, state, transition và lỗi toàn cục.
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    Logger.info('Event: $event', tag: bloc.runtimeType.toString());
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    Logger.debug(
      'State changed: ${change.currentState} → ${change.nextState}',
      tag: bloc.runtimeType.toString(),
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Logger.success(
      'Transition: ${transition.event} | '
      '${transition.currentState} → ${transition.nextState}',
      tag: bloc.runtimeType.toString(),
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Logger.error(
      'Error: $error',
      tag: bloc.runtimeType.toString(),
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
