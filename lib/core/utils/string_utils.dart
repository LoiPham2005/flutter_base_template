// ════════════════════════════════════════════════════════════════
// 📁 lib/core/utils/string_utils.dart
// ════════════════════════════════════════════════════════════════
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const numbers = '0123456789';
    final pool = numbersOnly ? numbers : chars;
    return List.generate(
      length,
      (i) => pool[DateTime.now().microsecondsSinceEpoch % pool.length],
    ).join();
  }

  /// Count words in string
  static int countWords(String text) {
    return text
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .length;
  }

  /// Get initials from name (e.g., "John Doe" -> "JD")
  static String getInitials(String name, {int maxChars = 2}) {
    final words = name.trim().split(RegExp(r'\s+'));
    final initials = words
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
        .take(maxChars)
        .join();
    return initials;
  }

  /// Check if string contains only numbers
  static bool isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  /// Check if string is valid email format
  static bool isEmail(String str) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(str);
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

  // Copy to clipboard
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  // Format currency (VND)
  static String currency(
    num value, {
    String symbol = '₫',
    int decimalDigits = 0,
  }) {
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(value);
  }

  // Format number with separators
  static String number(num value, {int decimalDigits = 0}) {
    final formatter = NumberFormat(
      '#,###${decimalDigits > 0 ? '.' : ''}${'#' * decimalDigits}',
    );
    return formatter.format(value);
  }

  // Format percentage
  static String percentage(num value, {int decimalDigits = 0}) {
    return '${(value * 100).toStringAsFixed(decimalDigits)}%';
  }

  // Format phone number
  static String phoneNumber(String phone) {
    // Remove all non-numeric characters
    final cleaned = phone.replaceAll(RegExp(r'\D'), '');

    // Format: 0123 456 789
    if (cleaned.length == 10) {
      return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 7)} ${cleaned.substring(7)}';
    }

    return phone;
  }

  // Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  // Capitalize each word
  static String capitalizeWords(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((word) => word.isEmpty ? word : capitalize(word))
        .join(' ');
  }

  // Truncate text with ellipsis
  static String truncate(
    String text,
    int maxLength, {
    String ellipsis = '...',
  }) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}$ellipsis';
  }

  // Format credit card number
  static String creditCard(String cardNumber) {
    final cleaned = cardNumber.replaceAll(RegExp(r'\D'), '');
    final parts = <String>[];

    for (var i = 0; i < cleaned.length; i += 4) {
      final end = (i + 4 < cleaned.length) ? i + 4 : cleaned.length;
      parts.add(cleaned.substring(i, end));
    }

    return parts.join(' ');
  }

  // Mask sensitive data (e.g., email, phone)
  static String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;

    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 2) return email;

    final masked =
        username[0] +
        '*' * (username.length - 2) +
        username[username.length - 1];

    return '$masked@$domain';
  }

  static String maskPhone(String phone) {
    if (phone.length < 4) return phone;
    return '${phone.substring(0, phone.length - 4)}****';
  }

  // Thêm method này (đang thiếu):
  static String camelCase(String text) {
    final words = text.split(RegExp(r'[\s_-]+'));
    return words.first.toLowerCase() +
        words.skip(1).map((w) => capitalize(w)).join();
  }

  static String snakeCase(String text) {
    return text
        .replaceAllMapped(
          RegExp(r'[A-Z]'),
          (Match m) => '_${m[0]!.toLowerCase()}',
        ) // Sửa lỗi ở đây
        .replaceAll(RegExp(r'\s+'), '_')
        .replaceAll(RegExp(r'^_'), '');
  }
}
