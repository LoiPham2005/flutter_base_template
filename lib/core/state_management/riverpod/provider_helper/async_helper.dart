
import 'package:flutter_base_template/core/network/repository_helper/base_response.dart';
import 'package:riverpod/riverpod.dart';

extension AsyncNotifierUtils<T> on AsyncNotifier<T> {
  void setError(String? message) {
    state = AsyncError(
      message ?? 'Đã xảy ra lỗi',
      StackTrace.current,
    );
  }

  void setLoading() {
    state = const AsyncLoading();
  }

  void setData(T value) {
    state = AsyncData(value);
  }

  void setEmpty() {
    if (T is List) {
      state = AsyncValue.data([] as T);
    } else {
      throw UnsupportedError('setEmpty() chỉ dùng được với kiểu T là List');
    }
  }

  // cách này sẽ có trả data khi gọi để xử lí
  Future<bool> handleMutation(
    Future<BaseResponse> Function() operation, {
    Future<void> Function(BaseResponse result)? onSuccess,
    bool autoSetData = false, // Mặc định không tự set
  }) async {
    setLoading();
    final result = await operation();
    if (result.isSuccess) {
      if (autoSetData) {
        setData(result.data as T); // ép kiểu cẩn thận
      }
      if (onSuccess != null) await onSuccess(result); // 👈 Truyền kết quả
      return true;
    } else {
      setError(result.message);
      return false;
    }
  }

  /// Tái sử dụng cho mọi mutation
  // Future<bool> handleMutation<R, U>(
  //   Future<BaseResponse<R>> Function() operation, {
  //   bool autoSetData = false, // Tự setData nếu newData là T
  //   List<U> Function(List<U> current, R newData)? mergeState, // Hỗ trợ List<U>
  //   Future<void> Function(BaseResponse<R> result)? onSuccess,
  // }) async {
  //   setLoading();
  //   final result = await operation();

  //   if (result.isSuccess) {
  //     final newData = result.data;

  //     // Nếu autoSetData và newData đúng kiểu
  //     if (autoSetData && newData is T) {
  //       setData(newData);
  //     }

  //     // Nếu có mergeState và state hiện tại là List<U>
  //     if (mergeState != null && newData != null && T is List<U>) {
  //       final currentList = (state.value ?? []) as List<U>;
  //       final updatedList = mergeState(currentList, newData);
  //       state = AsyncData(updatedList as T);
  //     }

  //     if (onSuccess != null) await onSuccess(result);
  //     return true;
  //   } else {
  //     setError(result.message);
  //     return false;
  //   }
  // }

  Future<void> refreshFromBuild(Future<T> Function() buildFn) async {
    setLoading();
    state = await AsyncValue.guard(buildFn);
  }
}
