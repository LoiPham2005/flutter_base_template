// lib/core/services/dialog_service.dart
import 'package:flutter/material.dart';
import 'navigation_service.dart';

class DialogService {
  static final DialogService _instance = DialogService._internal();
  factory DialogService() => _instance;
  DialogService._internal();
  
  final NavigationService _navigationService = NavigationService();
  
  BuildContext? get _context => _navigationService.context;
  
  
  // Show dialog
  Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
  }) {
    if (_context == null) throw Exception('Context is null');
    
    return showDialog<T>(
      context: _context!,
      barrierDismissible: barrierDismissible,
      builder: (_) => child,
    );
  }
  
  // Show alert dialog
  Future<bool?> showAlert({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
  }) {
    if (_context == null) return Future.value(false);
    
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
  
  // Show loading dialog
  void showLoading({String? message}) {
    if (_context == null) return;
    
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
  
  // Hide dialog
  void hideDialog() {
    _navigationService.pop();
  }


   // ===============================
  // Bottom Sheet
  // ===============================

  Future<T?> showCustomBottomSheet<T>({
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
  }) {
    assert(_context != null, 'Navigator context is not ready!');
    return showModalBottomSheet<T>(
      context: _context!,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      builder: (_) => child,
    );
  }

  // ===============================
  // SnackBars
  // ===============================

  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
    Color? backgroundColor,
  }) {
    assert(_context != null, 'Navigator context is not ready!');
    ScaffoldMessenger.of(_context!).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
      ),
    );
  }

  void showErrorSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    showSnackBar(message, duration: duration, backgroundColor: Colors.red);
  }

  void showSuccessSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    showSnackBar(message, duration: duration, backgroundColor: Colors.green);
  }
}