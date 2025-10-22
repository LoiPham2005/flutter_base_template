import 'package:flutter_base_template/core/errors/result.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  final isLoading = false.obs;

  void showLoading() => isLoading.value = true;
  void hideLoading() => isLoading.value = false;

  void showError(String message) {
    Get.snackbar('Lỗi', message);
  }

  /// ✅ Hàm tái sử dụng cho tất cả các usecase (login, register, ...)
  /// [action] là một hàm Future trả về kiểu Result<T>
  /// [onSuccess] được gọi nếu action thành công
  Future<void> executeUseCase<T>({
    required Future<Result<T>> Function() action,
    void Function(T data)? onSuccess,
    bool showLoading = true,
  }) async {
    try {
      if (showLoading) this.showLoading();
      final result = await action();
      if (showLoading) this.hideLoading();

      result.fold(
        onSuccess: (data) {
          if (onSuccess != null) onSuccess(data);
        },
        onFailure: (error) {
          showError(error.toString());
        },
      );
    } catch (e) {
      if (showLoading) this.hideLoading();
      showError(e.toString());
    }
  }
}
