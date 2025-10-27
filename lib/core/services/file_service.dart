// ════════════════════════════════════════════════════════════════
// 📁 lib/core/services/file_service.dart 
// ════════════════════════════════════════════════════════════════
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:open_filex/open_filex.dart';

class FileService {
  FileService._internal();
  static final FileService _instance = FileService._internal();
  factory FileService() => _instance;

  final Dio _dio = Dio();

  // ═══════════════════════════════════════════════════════════════
  // FILE OPERATIONS (Download & Open)
  // ═══════════════════════════════════════════════════════════════

  /// Download file from URL
  Future<File?> downloadFile(
    String url, {
    String? fileName,
    String? folderName,
    void Function(int, int)? onProgress,
  }) async {
    try {
      final dir = await getDownloadsDirectory() ?? 
                   await getApplicationDocumentsDirectory();
      final folder = Directory('${dir.path}/${folderName ?? "MyAppFiles"}');
      if (!await folder.exists()) await folder.create(recursive: true);

      final filePath = '${folder.path}/${fileName ?? url.split('/').last}';

      await _dio.download(
        url, 
        filePath,
        onReceiveProgress: onProgress,
      );

      return File(filePath);
    } catch (e) {
      return null;
    }
  }

  /// Open file with system default app
  Future<bool> openFile(File file) async {
    try {
      if (!await file.exists()) return false;
      final result = await OpenFilex.open(file.path);
      return result.type == ResultType.done;
    } catch (e) {
      return false;
    }
  }

  /// Download and open immediately
  Future<bool> downloadAndOpen(
    String url, {
    String? fileName,
    String? folderName,
  }) async {
    final file = await downloadFile(url, fileName: fileName, folderName: folderName);
    return file != null ? await openFile(file) : false;
  }

  // ═══════════════════════════════════════════════════════════════
  // MEDIA OPERATIONS (Save to Gallery)
  // ═══════════════════════════════════════════════════════════════

  /// Save image to gallery
  Future<bool> saveImageToGallery(String filePath, {String? albumName}) async {
    try {
      final result = await GallerySaver.saveImage(
        filePath,
        albumName: albumName ?? 'MyApp',
        toDcim: true,
      );
      return result == true;
    } catch (e) {
      return false;
    }
  }

  /// Save video to gallery
  Future<bool> saveVideoToGallery(String filePath, {String? albumName}) async {
    try {
      final result = await GallerySaver.saveVideo(
        filePath,
        albumName: albumName ?? 'MyApp',
        toDcim: true,
      );
      return result == true;
    } catch (e) {
      return false;
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════

  /// Check if file exists
  Future<bool> fileExists(String path) async {
    try {
      return await File(path).exists();
    } catch (_) {
      return false;
    }
  }

  /// Get file size
  Future<int?> getFileSize(String path) async {
    try {
      return await File(path).length();
    } catch (_) {
      return null;
    }
  }

  /// Delete file
  Future<bool> deleteFile(String path) async {
    try {
      await File(path).delete();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Get file extension
  String getFileExtension(String path) {
    return path.split('.').last.toLowerCase();
  }

  /// Check if file is image
  bool isImageFile(String path) {
    final ext = getFileExtension(path);
    return ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'].contains(ext);
  }

  /// Check if file is video
  bool isVideoFile(String path) {
    final ext = getFileExtension(path);
    return ['mp4', 'avi', 'mov', 'mkv', 'flv', 'wmv'].contains(ext);
  }
}