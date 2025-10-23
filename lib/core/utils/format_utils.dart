// lib/core/utils/format_utils.dart
import 'package:intl/intl.dart';

class FormatUtils {
  FormatUtils._();
  
  // Format currency (VND)
  static String currency(num value, {String symbol = '₫', int decimalDigits = 0}) {
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(value);
  }
  
  // Format number with separators
  static String number(num value, {int decimalDigits = 0}) {
    final formatter = NumberFormat('#,###${decimalDigits > 0 ? '.' : ''}${'#' * decimalDigits}');
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
    return text.split(' ')
        .map((word) => word.isEmpty ? word : capitalize(word))
        .join(' ');
  }
  
  // Truncate text with ellipsis
  static String truncate(String text, int maxLength, {String ellipsis = '...'}) {
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
    
    final masked = username[0] + 
        '*' * (username.length - 2) + 
        username[username.length - 1];
    
    return '$masked@$domain';
  }
  
  static String maskPhone(String phone) {
    if (phone.length < 4) return phone;
    return '${phone.substring(0, phone.length - 4)}****';
  }
}