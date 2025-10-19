// lib/core/utils/helpers.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpers {
  Helpers._();
  
  // Hide keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
  
  // Show loading dialog
  static void showLoading(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
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
  
  // Hide loading dialog
  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
  
  // Copy to clipboard
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
  
  // Open URL (requires url_launcher package)
  static Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
  
  // Check if device is iOS
  static bool get isIOS => Platform.isIOS;
  
  // Check if device is Android
  static bool get isAndroid => Platform.isAndroid;
  
  // Debounce function
  static void Function() debounce(
    VoidCallback callback, {
    Duration delay = const Duration(milliseconds: 500),
  }) {
    DateTime? lastCallTime;
    
    return () {
      final now = DateTime.now();
      if (lastCallTime == null || 
          now.difference(lastCallTime!) > delay) {
        lastCallTime = now;
        callback();
      }
    };
  }
  
  // Throttle function
  static VoidCallback throttle(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    bool isThrottled = false;
    
    return () {
      if (!isThrottled) {
        callback();
        isThrottled = true;
        Future.delayed(duration, () => isThrottled = false);
      }
    };
  }
  
  // Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }
  
  // Generate random color
  static Color randomColor() {
    return Color.fromARGB(
      255,
      DateTime.now().millisecond % 256,
      DateTime.now().second % 256,
      DateTime.now().minute % 256,
    );
  }
}

