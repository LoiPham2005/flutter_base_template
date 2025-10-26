// ════════════════════════════════════════════════════════════════
// 📁 lib/core/utils/image_utils.dart
// ════════════════════════════════════════════════════════════════
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  ImageUtils._();

  static final _picker = ImagePicker();

  /// Pick image from gallery
  static Future<File?> pickFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  /// Pick image from camera
  static Future<File?> pickFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  /// Pick multiple images
  static Future<List<File>> pickMultiple({int maxCount = 10}) async {
    final pickedFiles = await _picker.pickMultiImage();
    return pickedFiles.take(maxCount).map((file) => File(file.path)).toList();
  }

  /// Show image picker dialog
  static Future<File?> showImageSourceDialog(BuildContext context) async {
    return showDialog<File>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chọn nguồn ảnh'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Thư viện'),
              onTap: () async {
                final file = await pickFromGallery();
                if (context.mounted) Navigator.pop(context, file);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                final file = await pickFromCamera();
                if (context.mounted) Navigator.pop(context, file);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Get file size in bytes
  static Future<int> getFileSize(File file) async {
    return await file.length();
  }

  /// Check if file is image
  static bool isImageFile(String path) {
    final ext = path.toLowerCase().split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'].contains(ext);
  }

  /// Generate placeholder color based on string
  static Color getPlaceholderColor(String text) {
    final hash = text.hashCode;
    return Color.fromARGB(
      255,
      (hash & 0xFF0000) >> 16,
      (hash & 0x00FF00) >> 8,
      hash & 0x0000FF,
    );
  }
}
