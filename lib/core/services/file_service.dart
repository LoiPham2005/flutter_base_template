import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_base_template/core/utils/logger.dart';
import 'package:open_filex/open_filex.dart';
/// ✅ FileService: Dùng để tải, lưu và mở mọi loại file (ảnh, video, PDF, ZIP, v.v.)
class FileService {
  FileService._internal();
  static final FileService _instance = FileService._internal();
  factory FileService() => _instance;

  final Dio _dio = Dio();

  /// Tải file từ URL về máy
  /// [url] là link tải
  /// [fileName] là tên file muốn lưu (tùy chọn)
  /// [folderName] là tên thư mục lưu trong Downloads
  Future<File?> downloadFile(String url, {String? fileName, String? folderName}) async {
    try {
      Logger.info('⬇️ Bắt đầu tải file: $url');

      // Thư mục lưu trữ (Downloads hoặc Documents)
      final dir = await getDownloadsDirectory() ?? await getApplicationDocumentsDirectory();
      final folder = Directory('${dir.path}/${folderName ?? "MyAppFiles"}');
      if (!await folder.exists()) await folder.create(recursive: true);

      final filePath = '${folder.path}/${fileName ?? url.split('/').last}';

      // Tải file
      await _dio.download(url, filePath);
      Logger.success('✅ File đã được tải về: $filePath');

      return File(filePath);
    } catch (e, s) {
      Logger.error('❌ Lỗi khi tải file: $e', stackTrace: s);
      return null;
    }
  }

  /// Mở file sau khi tải
  /// Hỗ trợ tất cả định dạng mà hệ điều hành nhận diện được
  Future<void> openFile(File file) async {
    try {
      if (!await file.exists()) {
        Logger.warning('⚠️ File không tồn tại: ${file.path}');
        return;
      }
      Logger.info('📂 Đang mở file: ${file.path}');
      await OpenFilex.open(file.path);
    } catch (e, s) {
      Logger.error('❌ Không thể mở file: $e', stackTrace: s);
    }
  }

  /// Tải file và mở luôn
  Future<void> downloadAndOpen(String url, {String? fileName, String? folderName}) async {
    final file = await downloadFile(url, fileName: fileName, folderName: folderName);
    if (file != null) await openFile(file);
  }

  /// Kiểm tra file có tồn tại không
  Future<bool> fileExists(String path) async {
    try {
      return File(path).exists();
    } catch (_) {
      return false;
    }
  }
}
