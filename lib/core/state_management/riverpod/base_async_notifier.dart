import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_base_template/core/errors/result.dart';

/// ✅ BaseAsyncNotifier dùng chung cho mọi AsyncNotifier (login, register, user, ...)
abstract class BaseAsyncNotifier<T> extends AsyncNotifier<T> {
  /// ✅ Thực thi usecase chung
  ///
  /// [action] là Future trả về `Result<T>` (thường từ repository)
  /// [onSuccess] callback khi thành công
  /// [showLoading] cho phép bật/tắt loading
  Future<void> executeUseCase({
    required Future<Result<T>> Function() action,
    void Function(T data)? onSuccess,
    bool showLoading = true,
  }) async {
    if (showLoading) {
      state = const AsyncLoading();
    }

    try {
      final result = await action();

      result.fold(
        onSuccess: (data) {
          // ✅ Cập nhật state với dữ liệu mới
          state = AsyncData(data);

          // ✅ Gọi callback nếu có
          onSuccess?.call(data);
        },
        onFailure: (failure) {
          // ✅ Đảm bảo failure có thể đọc được rõ ràng
          final message = failure.toString();
          state = AsyncError(message, StackTrace.current);
        },
      );
    } catch (error, stack) {
      // ✅ Nếu có lỗi runtime
      state = AsyncError(error, stack);
    }
  }

  /// ✅ Có thể thêm helper kiểm tra nhanh
  bool get isLoading => state is AsyncLoading;
  bool get hasError => state is AsyncError;
}
