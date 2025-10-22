import 'dart:async';
import 'package:flutter_base_template/core/errors/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ✅ BaseAsyncNotifier dùng chung cho mọi AsyncNotifier (login, register, user, ...)
abstract class BaseAsyncNotifier<T> extends AsyncNotifier<T> {
  /// Hàm thực thi usecase chung
  /// [action] là Future trả về `Result<T>` (hoặc tương đương có fold)
  /// [onSuccess] callback khi thành công
  Future<void> executeUseCase({
    required Future<Result<T>> Function() action,
    void Function(T data)? onSuccess,
  }) async {
    state = const AsyncLoading();

    try {
      final result = await action();

      result.fold(
        onSuccess: (data) {
          state = AsyncData(data);
          if (onSuccess != null) onSuccess(data);
        },
        onFailure: (error) {
          state = AsyncError(error.toString(), StackTrace.current);
        },
      );
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }
}

