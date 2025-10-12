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
}