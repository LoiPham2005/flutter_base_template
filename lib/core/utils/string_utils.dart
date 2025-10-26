// ════════════════════════════════════════════════════════════════
// 📁 lib/core/utils/string_utils.dart
// ════════════════════════════════════════════════════════════════
class StringUtils {
  StringUtils._();

  /// Check if string is null or empty
  static bool isNullOrEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  /// Check if string is null, empty or whitespace
  static bool isBlank(String? value) {
    return value == null || value.trim().isEmpty;
  }

  /// Remove all whitespace
  static String removeWhitespace(String value) {
    return value.replaceAll(RegExp(r'\s+'), '');
  }

  /// Remove Vietnamese accents
  static String removeVietnameseAccent(String str) {
    str = str.replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), 'a');
    str = str.replaceAll(RegExp(r'[èéẹẻẽêềếệểễ]'), 'e');
    str = str.replaceAll(RegExp(r'[ìíịỉĩ]'), 'i');
    str = str.replaceAll(RegExp(r'[òóọỏõôồốộổỗơờớợởỡ]'), 'o');
    str = str.replaceAll(RegExp(r'[ùúụủũưừứựửữ]'), 'u');
    str = str.replaceAll(RegExp(r'[ỳýỵỷỹ]'), 'y');
    str = str.replaceAll(RegExp(r'[đ]'), 'd');
    str = str.replaceAll(RegExp(r'[ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴ]'), 'A');
    str = str.replaceAll(RegExp(r'[ÈÉẸẺẼÊỀẾỆỂỄ]'), 'E');
    str = str.replaceAll(RegExp(r'[ÌÍỊỈĨ]'), 'I');
    str = str.replaceAll(RegExp(r'[ÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ]'), 'O');
    str = str.replaceAll(RegExp(r'[ÙÚỤỦŨƯỪỨỰỬỮ]'), 'U');
    str = str.replaceAll(RegExp(r'[ỲÝỴỶỸ]'), 'Y');
    str = str.replaceAll(RegExp(r'[Đ]'), 'D');
    return str;
  }

  /// Create slug from string (for URL-friendly names)
  static String slugify(String text) {
    String slug = removeVietnameseAccent(text.toLowerCase());
    slug = slug.replaceAll(RegExp(r'[^a-z0-9\s-]'), '');
    slug = slug.replaceAll(RegExp(r'\s+'), '-');
    slug = slug.replaceAll(RegExp(r'-+'), '-');
    return slug.trim();
  }

  /// Generate random string
  static String random(int length, {bool numbersOnly = false}) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const numbers = '0123456789';
    final pool = numbersOnly ? numbers : chars;
    return List.generate(length, (i) => pool[DateTime.now().microsecondsSinceEpoch % pool.length]).join();
  }

  /// Count words in string
  static int countWords(String text) {
    return text.trim().split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
  }

  /// Get initials from name (e.g., "John Doe" -> "JD")
  static String getInitials(String name, {int maxChars = 2}) {
    final words = name.trim().split(RegExp(r'\s+'));
    final initials = words.map((word) => word.isNotEmpty ? word[0].toUpperCase() : '').take(maxChars).join();
    return initials;
  }

  /// Check if string contains only numbers
  static bool isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  /// Check if string is valid email format
  static bool isEmail(String str) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(str);
  }

  /// Reverse string
  static String reverse(String str) {
    return str.split('').reversed.join();
  }

  /// Compare two strings ignoring case
  static bool equalsIgnoreCase(String? str1, String? str2) {
    if (str1 == null || str2 == null) return str1 == str2;
    return str1.toLowerCase() == str2.toLowerCase();
  }
}