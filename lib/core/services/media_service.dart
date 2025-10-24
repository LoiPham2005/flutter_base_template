import 'dart:io';
import 'package:flutter_base_template/core/utils/logger.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';

/// ✅ MediaService: Dùng để lưu ảnh hoặc video vào thư viện (Gallery / Photos)
class MediaService {
  MediaService._internal();
  static final MediaService _instance = MediaService._internal();
  factory MediaService() => _instance;

  /// Lưu ảnh
  /// [filePath] có thể là file local hoặc URL
  /// [albumName] tên thư mục trong thư viện (tùy chọn)
  Future<bool> saveImage(String filePath, {String? albumName}) async {
    try {
      Logger.info('📸 Đang lưu ảnh: $filePath');
      final result = await GallerySaver.saveImage(
        filePath,
        albumName: albumName ?? 'MyApp',
        toDcim: true,
      );
      if (result == true) {
        Logger.success('✅ Ảnh đã được lưu thành công!');
        return true;
      } else {
        Logger.warning('⚠️ Không thể lưu ảnh.');
        return false;
      }
    } catch (e, s) {
      Logger.error('❌ Lỗi khi lưu ảnh: $e', stackTrace: s);
      return false;
    }
  }

  /// Lưu video
  /// [filePath] có thể là file local hoặc URL
  /// [albumName] tên thư mục trong thư viện (tùy chọn)
  Future<bool> saveVideo(String filePath, {String? albumName}) async {
    try {
      Logger.info('🎬 Đang lưu video: $filePath');
      final result = await GallerySaver.saveVideo(
        filePath,
        albumName: albumName ?? 'MyApp',
        toDcim: true,
      );
      if (result == true) {
        Logger.success('✅ Video đã được lưu thành công!');
        return true;
      } else {
        Logger.warning('⚠️ Không thể lưu video.');
        return false;
      }
    } catch (e, s) {
      Logger.error('❌ Lỗi khi lưu video: $e', stackTrace: s);
      return false;
    }
  }

  /// Kiểm tra file có tồn tại trước khi lưu (tùy chọn)
  Future<bool> fileExists(String path) async {
    try {
      return File(path).exists();
    } catch (_) {
      return false;
    }
  }
}
