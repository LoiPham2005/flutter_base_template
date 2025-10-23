import 'package:flutter_base_template/core/errors/result.dart';
import 'package:flutter_base_template/core/state_management/bloc/base_state.dart';
import 'package:flutter_base_template/core/state_management/bloc/bloc_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<T> extends Cubit<BaseState<T>> {
  BaseCubit([BaseState<T>? initialState])
      : super(initialState ?? BaseState<T>.initial());

  /// Emit an toàn (tránh lỗi khi Cubit đã đóng)
  void safeEmit(BaseState<T> newState) {
    if (!isClosed) emit(newState);
  }

  /// Helper thực thi hành động async theo Result pattern
  Future<T?> executeUseCase({
    required Future<Result<T>> Function() action,
    String? loadingMessage,
    String? successMessage,
    void Function(T data)? onSuccess,
  }) async {
    safeEmit(state.copyWith(
      status: BlocStatus.loading,
      message: loadingMessage ?? 'Đang xử lý...',
      error: null,
    ));

    try {
      final result = await action();

      return result.fold(
        onSuccess: (data) {
          safeEmit(state.copyWith(
            status: BlocStatus.success,
            data: data,
            message: successMessage ?? 'Thành công!',
          ));
          onSuccess?.call(data);
          return data;
        },
        onFailure: (failure) {
          safeEmit(state.copyWith(
            status: BlocStatus.failure,
            error: failure.message ?? failure.toString(),
          ));
          return null;
        },
      );
    } catch (_) {
      safeEmit(state.copyWith(
        status: BlocStatus.failure,
        error: 'Đã xảy ra lỗi không xác định',
      ));
      return null;
    }
  }
}
