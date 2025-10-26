import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:url_launcher/url_launcher.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal();

  StreamSubscription? _subscription;
  bool _isShown = false;

  // Thêm 2 static methods
  static Future<bool> hasConnection() async {
    return await NetworkService().checkConnection();
  }

  static Future<void> check(
    BuildContext context, {
    Function()? onConnected,
    Function()? onDisconnected,
    bool showMessage = true,
  }) async {
    return await NetworkService().monitorConnection(
      context,
      onConnected: onConnected,
      onDisconnected: onDisconnected,
      showMessage: showMessage,
    );
  }

  Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> monitorConnection(
    BuildContext context, {
    Function()? onConnected,
    Function()? onDisconnected,
    bool showMessage = true,
  }) async {
    final isConnected = await checkConnection();

    // Show initial state
    if (!isConnected) {
      _showDisconnectedMessage(context);
      onDisconnected?.call();
    }

    // Start monitoring
    await _subscription?.cancel();
    _subscription = InternetConnectionChecker.instance.onStatusChange.listen(
      (status) => _handleConnectivityChange(
        context,
        status,
        showMessage: showMessage,
        onConnected: onConnected,
        onDisconnected: onDisconnected,
      ),
    );
  }

  void _handleConnectivityChange(
    BuildContext context,
    InternetConnectionStatus status, {
    bool showMessage = true,
    Function()? onConnected,
    Function()? onDisconnected,
  }) {
    switch (status) {
      case InternetConnectionStatus.connected:
        if (_isShown && showMessage) {
          _hideSnackBar(context);
          _showConnectedMessage(context);
        }
        onConnected?.call();
        break;

      case InternetConnectionStatus.disconnected:
        if (!_isShown && showMessage) {
          _showDisconnectedMessage(context);
        }
        onDisconnected?.call();
        break;

      case InternetConnectionStatus.slow:
        if (showMessage) {
          _showSlowConnectionMessage(context);
        }
        break;
    }
  }

  void _showConnectedMessage(BuildContext context) {
    _isShown = false;
    _showSnackBar(
      context,
      message: 'Đã kết nối mạng',
      icon: Icons.wifi,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
    );
  }

  void _showDisconnectedMessage(BuildContext context) {
    _isShown = true;
    _showSnackBar(
      context,
      message: 'Mất kết nối mạng',
      icon: Icons.wifi_off,
      backgroundColor: Colors.red,
      duration: const Duration(days: 1),
      action: SnackBarAction(
        label: 'Thử lại',
        textColor: Colors.white,
        onPressed: () => monitorConnection(context),
      ),
    );
  }

  void _showSlowConnectionMessage(BuildContext context) {
    _showSnackBar(
      context,
      message: 'Kết nối mạng yếu',
      icon: Icons.signal_wifi_bad,
      backgroundColor: Colors.orange,
      duration: const Duration(seconds: 3),
    );
  }

  void _showSnackBar(
    BuildContext context, {
    required String message,
    required IconData icon,
    required Color backgroundColor,
    required Duration duration,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        action: action,
      ),
    );
  }

  void _hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  // URL Helper methods
  Map<String, String> parseQueryParams(String url) {
    final uri = Uri.parse(url);
    return uri.queryParameters;
  }

  String buildUrl(String baseUrl, Map<String, dynamic> params) {
    final uri = Uri.parse(baseUrl);
    final queryParams = params.map(
      (key, value) => MapEntry(key, value.toString()),
    );
    return uri.replace(queryParameters: queryParams).toString();
  }

  Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _isShown = false;
  }
}
