import 'package:flutter/material.dart';
import '../repository_helper/base_response.dart';

class BaseNotifier extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// action: hàm gọi repo, trả về BaseResponse<TData>
  /// targetList: danh sách muốn đồng bộ (tuỳ chọn)
  /// mergeList: cách trộn current + newData => list mới (tuỳ chọn)
  /// onSuccess: callback khi thành công (tuỳ chọn)
  Future<void> performAction<TData, TItem>({
    required Future<BaseResponse<TData>> Function() action,
    List<TItem>? targetList,
    List<TItem> Function(List<TItem> current, TData newData)? mergeList,
    void Function(TData data)? onSuccess,
    bool showLoading = true,
    BuildContext? context,
  }) async {
    try {
      if (showLoading) _setLoading(true);
      final res = await action();
      if (showLoading) _setLoading(false);

      if (res.isSuccess) {
        final data = res.data;

        // In message server trả về
        if (res.message != null) {
          debugPrint("Server message: ${res.message}");
        }

        // Đồng bộ list nếu có
        if (targetList != null && data != null) {
          if (mergeList != null) {
            final updated = mergeList(targetList, data);
            targetList
              ..clear()
              ..addAll(updated);
          } else if (data is List<TItem>) {
            targetList
              ..clear()
              ..addAll(data);
          }
        }

        if (onSuccess != null && data != null) onSuccess(data);
      } else {
        _setError(res.message ?? 'Có lỗi xảy ra');
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(res.message ?? 'Có lỗi xảy ra')),
          );
        }
      }

      debugPrint("BaseNotifier data: ${res.data}");
    } catch (e) {
      if (showLoading) _setLoading(false);
      _setError(e.toString());
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}
