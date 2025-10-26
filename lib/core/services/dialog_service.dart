// lib/core/services/dialog_service.dart
import 'package:flutter/material.dart';
import 'navigation_service.dart';

class DialogService {
  static final DialogService _instance = DialogService._internal();
  factory DialogService() => _instance;
  DialogService._internal();

  final NavigationService _navigationService = NavigationService();
  BuildContext? get _context => _navigationService.context;

  // Dialog methods
  Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
  }) {
    assert(_context != null, 'Context is not ready');
    return showDialog<T>(
      context: _context!,
      barrierDismissible: barrierDismissible,
      builder: (_) => child,
    );
  }

  Future<bool?> showAlert({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
  }) {
    assert(_context != null, 'Context is not ready');
    return showDialog<bool>(
      context: _context!,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: () => Navigator.pop(_context!, false),
              child: Text(cancelText),
            ),
          TextButton(
            onPressed: () {
              Navigator.pop(_context!, true);
              onConfirm?.call();
            },
            child: Text(confirmText ?? 'OK'),
          ),
        ],
      ),
    );
  }

  void showLoading({String? message}) {
    assert(_context != null, 'Context is not ready');
    showDialog(
      context: _context!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  if (message != null) ...[
                    const SizedBox(height: 16),
                    Text(message),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void hideDialog() => _navigationService.pop();

  // Bottom Sheet
  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
  }) {
    assert(_context != null, 'Context is not ready');
    return showModalBottomSheet<T>(
      context: _context!,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      builder: (_) => child,
    );
  }

  // SnackBar methods with icons
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
    Color? backgroundColor,
    IconData? icon,
  }) {
    assert(_context != null, 'Context is not ready');
    ScaffoldMessenger.of(_context!).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white),
              const SizedBox(width: 12),
            ],
            Expanded(child: Text(message)),
          ],
        ),
        duration: duration,
        backgroundColor: backgroundColor,
      ),
    );
  }

  void showSuccess(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
      duration: const Duration(seconds: 2),
    );
  }

  void showError(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.red,
      icon: Icons.error_outline,
      duration: const Duration(seconds: 3),
    );
  }

  void showWarning(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.orange,
      icon: Icons.warning_amber,
      duration: const Duration(seconds: 3),
    );
  }

  void showInfo(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.blue,
      icon: Icons.info_outline,
      duration: const Duration(seconds: 2),
    );
  }
}
