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
    void Function(T data)? onSuccess,
    void Function(String error)? onError, // ✅ Callback khi lỗi
  }) async {
    safeEmit(state.copyWith(
      status: BlocStatus.loading,
      error: null,
    ));

    try {
      final result = await action();

      return result.fold(
        onSuccess: (data) {
          safeEmit(state.copyWith(
            status: BlocStatus.success,
            data: data,
          ));
          onSuccess?.call(data);
          return data;
        },
        onFailure: (failure) {
          final errorMsg = failure.message ?? 'Đã xảy ra lỗi';
          safeEmit(state.copyWith(
            status: BlocStatus.failure,
            error: errorMsg,
          ));
          onError?.call(errorMsg); // ✅ Gọi callback lỗi
          return null;
        },
      );
    } catch (e) {
      const errorMsg = 'Đã xảy ra lỗi không xác định';
      safeEmit(state.copyWith(
        status: BlocStatus.failure,
        error: errorMsg,
      ));
      onError?.call(errorMsg); // ✅ fallback callback lỗi
      return null;
    }
  }
}
