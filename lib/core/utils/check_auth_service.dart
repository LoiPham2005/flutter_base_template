import 'package:flutter_base_template/core/network/dio_client.dart';
import 'package:flutter_base_template/core/storage/storage_service.dart';
import 'package:flutter_base_template/core/utils/logger.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckAuthService {
  CheckAuthService(this._storageService, this._dioClient);
  final StorageService _storageService;
  final DioClient _dioClient;

  bool _isRefreshing = false;

  Future<void> checkAndRefreshToken() async {
    if (_isRefreshing) return;

    final accessToken = _storageService.getToken();
    final refreshToken = _storageService
        .getRefreshToken(); // Giả sử bạn có phương thức này

    if (accessToken == null || refreshToken == null) {
      print('Tokens không tồn tại, không cần refresh.');
      return;
    }

    try {
      final bool isAccessTokenExpired = JwtDecoder.isExpired(accessToken);
      final bool isRefreshTokenExpired = JwtDecoder.isExpired(refreshToken);

      if (isRefreshTokenExpired) {
        print('Refresh token đã hết hạn. Đăng xuất...');
        await logout();
        return;
      }

      if (isAccessTokenExpired) {
        print('Access token đã hết hạn. Bắt đầu làm mới...');
        _isRefreshing = true;

        final response = await _dioClient.post(
          '/auth/refresh-token',
          data: {'refreshToken': refreshToken},
        );

        if (response.statusCode == 200 && response.data['success'] == true) {
          final newAccessToken = response.data['data']['accessToken'];
          final newRefreshToken = response.data['data']['refreshToken'];

          await _storageService.saveToken(newAccessToken);
          await _storageService.saveRefreshToken(
            newRefreshToken,
          ); // Giả sử bạn có phương thức này
          print('Refresh token thành công.');
        } else {
          print('Refresh token thất bại. Đăng xuất...');
          await logout();
        }
      }
    } catch (e) {
      print('Lỗi khi refresh token: $e. Đăng xuất...');
      await logout();
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> logout() async {
    await _storageService.clearAuthData();
    // Cân nhắc điều hướng người dùng về trang đăng nhập
    // Get.offAll(() => const LoginPage());
    Logger.info('User logged out and auth data cleared.');
  }
}
