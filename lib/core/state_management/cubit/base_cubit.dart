// lib/core/state_management/base_cubit.dart
import 'package:flutter_base_template/core/state_management/bloc/base_state.dart';
import 'package:flutter_base_template/core/state_management/bloc/bloc_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_template/core/errors/result.dart';
import 'package:flutter_base_template/core/errors/failures.dart';

/// BaseCubit dùng chung cho tất cả các Cubit
/// - Hỗ trợ quản lý vòng đời (init, dispose)
/// - Có helper `performAction` để xử lý logic async + Result<T>
/// - An toàn khi emit (safeEmit)
abstract class BaseCubit<T> extends Cubit<BaseState<T>> {
  BaseCubit([BaseState<T>? initialState])
      : super(initialState ?? BaseState<T>.initial()) {
    onInit();
  }

  /// Gọi khi Cubit được khởi tạo
  void onInit() {
    print('[CUBIT INIT] ${runtimeType}');
  }

  /// Gọi khi Cubit bị dispose
  void onDispose() {
    print('[CUBIT DISPOSED] ${runtimeType}');
  }

  /// Ghi log lỗi (có thể override để tích hợp Crashlytics, Sentry...)
  @override
  void onError(Object error, StackTrace stackTrace) {
    print('[CUBIT ERROR] $error');
    super.onError(error, stackTrace);
  }

  /// Hàm helper thực thi 1 hành động async (theo Result pattern)
  /// 
  /// Ví dụ:
  /// ```dart
  /// await performAction(
  ///   action: () => _loginUseCase(email, password),
  ///   loadingMessage: 'Đang đăng nhập...',
  ///   successMessage: 'Đăng nhập thành công!',
  /// );
  /// ```
  Future<T?> executeUseCase({
    required Future<Result<T>> Function() action,
    String? loadingMessage,
    String? successMessage,
  }) async {
    final loadingMsg = loadingMessage ?? 'Đang xử lý...';
    final successMsg = successMessage ?? 'Thành công!';

    // Loading
    safeEmit(state.copyWith(
      status: BlocStatus.loading,
      message: loadingMsg,
      error: null,
    ));

    try {
      final result = await action();

      // Dựa trên Result.fold
      return result.fold(
        onSuccess: (data) {
          safeEmit(state.copyWith(
            status: BlocStatus.success,
            data: data,
            message: successMsg,
          ));
          return data;
        },
        onFailure: (Failure failure) {
          safeEmit(state.copyWith(
            status: BlocStatus.failure,
            error: failure.message ?? failure.toString(),
          ));
          return null;
        },
      );
    } catch (e, stackTrace) {
      print('[CUBIT EXCEPTION] $e\n$stackTrace');
      safeEmit(state.copyWith(
        status: BlocStatus.failure,
        error: 'Đã xảy ra lỗi không xác định',
      ));
      return null;
    }
  }

  /// Emit an toàn (tránh lỗi khi Cubit đã đóng)
  void safeEmit(BaseState<T> newState) {
    if (!isClosed) emit(newState);
  }

  /// Dọn tài nguyên
  @override
  Future<void> close() {
    print('[CUBIT CLOSED] ${runtimeType}');
    onDispose();
    return super.close();
  }
}
