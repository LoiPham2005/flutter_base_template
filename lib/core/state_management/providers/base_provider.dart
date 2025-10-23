import 'package:flutter/foundation.dart';
import 'package:flutter_base_template/core/errors/result.dart';

/// ✅ BaseProvider dùng chung cho mọi Provider (Auth, User, Product, ...)
/// Có thể mở rộng thêm: retry, pagination, caching...
class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  /// ✅ Hàm xử lý hành động chung (giống executeUseCase ở Cubit/GetX)
  /// [action] là hàm Future trả về `Result<T>` (theo Result Pattern)
  /// [onSuccess] callback khi thành công
  /// [onError] callback khi lỗi (giúp UI tự xử lý)
  Future<void> executeUseCase<T>({
    required Future<Result<T>> Function() action,
    void Function(T data)? onSuccess,
    void Function(String error)? onError, // ✅ Callback khi lỗi
    bool shouldShowLoading = true, // ✅ tránh trùng hàm hoặc biến
  }) async {
    try {
      if (shouldShowLoading) {
        _isLoading = true;
        _error = null;
        notifyListeners();
      }

      final result = await action();

      result.fold(
        onSuccess: (data) {
          _error = null;
          onSuccess?.call(data);
        },
        onFailure: (failure) {
          final msg = failure.message ?? 'Đã xảy ra lỗi';
          _error = msg;
          onError?.call(msg); // ✅ Gọi callback để UI xử lý lỗi
        },
      );
    } catch (e) {
      const msg = 'Đã xảy ra lỗi không xác định';
      _error = msg;
      onError?.call(msg);
    } finally {
      if (shouldShowLoading) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}
