import 'package:flutter/foundation.dart';
import 'package:flutter_base_template/core/errors/result.dart';

/// ✅ BaseProvider dùng chung cho mọi Provider (Auth, User, Product, ...)
class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  /// ✅ Hàm xử lý hành động chung (giống performAction ở GetX)
  /// [action] là hàm Future trả về `Result<T>` (có `fold`)
  /// [onSuccess] là callback khi thành công
  Future<void> executeUseCase<T>({
    required Future<Result<T>> Function() action,
    void Function(T data)? onSuccess,
    bool showLoading = true,
  }) async {
    try {
      if (showLoading) {
        _isLoading = true;
        _error = null;
        notifyListeners();
      }

      final result = await action();

      result.fold(
        onSuccess: (data) {
          _error = null;
          if (onSuccess != null) onSuccess(data);
        },
        onFailure: (error) {
          _error = error.toString();
        },
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      if (showLoading) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}

