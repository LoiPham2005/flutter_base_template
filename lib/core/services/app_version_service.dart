
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class AppVersionService {
  // Thay đổi các thông tin sau cho phù hợp với app của bạn
  static const String androidPackageName = 'com.example.yourapp';
  static const String iosAppId = '123456789'; // App ID trên App Store
  
  /// Kiểm tra version hiện tại của app
  Future<String> getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  /// Lấy phiên bản mới nhất từ Google Play Store
  Future<String?> getLatestAndroidVersion() async {
    try {
      final url = 'https://play.google.com/store/apps/details?id=$androidPackageName&hl=vi';
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        // Parse HTML để tìm version
        final match = RegExp(r'\[\[\["([0-9.]+)"\]\]').firstMatch(response.body);
        if (match != null && match.groupCount >= 1) {
          return match.group(1);
        }
      }
    } catch (e) {
      debugPrint('Lỗi khi lấy version Android: $e');
    }
    return null;
  }

  /// Lấy phiên bản mới nhất từ Apple App Store
  Future<String?> getLatestIOSVersion() async {
    try {
      final url = 'https://itunes.apple.com/lookup?id=$iosAppId&country=vn';
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['resultCount'] > 0) {
          return data['results'][0]['version'];
        }
      }
    } catch (e) {
      debugPrint('Lỗi khi lấy version iOS: $e');
    }
    return null;
  }

  /// So sánh 2 version (trả về true nếu storeVersion mới hơn currentVersion)
  bool isUpdateAvailable(String currentVersion, String storeVersion) {
    List<int> currentParts = currentVersion.split('.').map(int.parse).toList();
    List<int> storeParts = storeVersion.split('.').map(int.parse).toList();
    
    int maxLength = currentParts.length > storeParts.length 
        ? currentParts.length 
        : storeParts.length;
    
    for (int i = 0; i < maxLength; i++) {
      int current = i < currentParts.length ? currentParts[i] : 0;
      int store = i < storeParts.length ? storeParts[i] : 0;
      
      if (store > current) return true;
      if (store < current) return false;
    }
    
    return false;
  }

  /// Kiểm tra có phiên bản mới và hiển thị dialog
  Future<void> checkForUpdate(BuildContext context, {bool forceCheck = false}) async {
    try {
      String currentVersion = await getCurrentVersion();
      String? storeVersion;
      
      if (Platform.isAndroid) {
        storeVersion = await getLatestAndroidVersion();
      } else if (Platform.isIOS) {
        storeVersion = await getLatestIOSVersion();
      }
      
      if (storeVersion != null && isUpdateAvailable(currentVersion, storeVersion)) {
        if (context.mounted) {
          _showUpdateDialog(context, currentVersion, storeVersion);
        }
      } else if (forceCheck && context.mounted) {
        _showNoUpdateDialog(context);
      }
    } catch (e) {
      debugPrint('Lỗi khi kiểm tra update: $e');
    }
  }

  /// Hiển thị dialog thông báo có phiên bản mới
  void _showUpdateDialog(BuildContext context, String currentVersion, String newVersion) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cập nhật ứng dụng'),
          content: Text(
            'Có phiên bản mới!\n\n'
            'Phiên bản hiện tại: $currentVersion\n'
            'Phiên bản mới: $newVersion\n\n'
            'Vui lòng cập nhật để có trải nghiệm tốt nhất.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Để sau'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _openStore();
              },
              child: const Text('Cập nhật ngay'),
            ),
          ],
        );
      },
    );
  }

  /// Hiển thị dialog không có update (khi check thủ công)
  void _showNoUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: const Text('Bạn đang sử dụng phiên bản mới nhất!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  /// Mở store để cập nhật
  Future<void> _openStore() async {
    final url = Platform.isAndroid
        ? 'https://play.google.com/store/apps/details?id=$androidPackageName'
        : 'https://apps.apple.com/app/id$iosAppId';
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}