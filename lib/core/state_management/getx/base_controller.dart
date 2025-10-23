import 'package:flutter_base_template/core/errors/result.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs; // ✅ Cho phép UI listen lỗi nếu cần

  void showLoading() => isLoading.value = true;
  void hideLoading() => isLoading.value = false;

  /// ✅ Hàm tái sử dụng cho tất cả các usecase (login, register, ...)
  /// [action] là một hàm Future trả về kiểu Result<T>
  /// [onSuccess] được gọi nếu action thành công
  /// [onError] được gọi nếu có lỗi xảy ra
  Future<void> executeUseCase<T>({
    required Future<Result<T>> Function() action,
    void Function(T data)? onSuccess,
    void Function(String error)? onError, // ✅ Callback khi lỗi
    bool shouldShowLoading = true, // 🔄 đổi tên tránh trùng hàm
  }) async {
    try {
      if (shouldShowLoading) showLoading();
      final result = await action();
      if (shouldShowLoading) hideLoading();

      result.fold(
        onSuccess: (data) {
          onSuccess?.call(data);
        },
        onFailure: (failure) {
          final msg = failure.message ?? 'Đã xảy ra lỗi';
          errorMessage.value = msg;
          onError?.call(msg); // ✅ callback cho UI xử lý lỗi
        },
      );
    } catch (e) {
      if (shouldShowLoading) hideLoading();
      const msg = 'Đã xảy ra lỗi không xác định';
      errorMessage.value = msg;
      onError?.call(msg);
    }
  }
}
