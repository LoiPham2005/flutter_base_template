// lib/core/utils/date_utils.dart
import 'package:intl/intl.dart';

class DateUtils {
  DateUtils._();
  
  // Format date
  static String format(DateTime date, {String pattern = 'dd/MM/yyyy'}) {
    return DateFormat(pattern).format(date);
  }
  
  // Parse date string
  static DateTime? parse(String dateString, {String pattern = 'dd/MM/yyyy'}) {
    try {
      return DateFormat(pattern).parse(dateString);
    } catch (e) {
      return null;
    }
  }
  
  // Get time ago string
  static String timeAgo(DateTime date, {bool short = false}) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inSeconds < 60) {
      return short ? 'Vừa xong' : 'Vừa xong';
    } else if (difference.inMinutes < 60) {
      return short 
          ? '${difference.inMinutes}p'
          : '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return short 
          ? '${difference.inHours}h'
          : '${difference.inHours} giờ trước';
    } else if (difference.inDays < 7) {
      return short 
          ? '${difference.inDays}d'
          : '${difference.inDays} ngày trước';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return short ? '${weeks}w' : '$weeks tuần trước';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return short ? '${months}m' : '$months tháng trước';
    } else {
      final years = (difference.inDays / 365).floor();
      return short ? '${years}y' : '$years năm trước';
    }
  }
  
  // Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }
  
  // Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && 
           date.month == yesterday.month && 
           date.day == yesterday.day;
  }
  
  // Get start of day
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
  
  // Get end of day
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }
  
  // Get start of month
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }
  
  // Get end of month
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59, 999);
  }
  
  // Get days in month
  static int daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }
  
  // Add working days (skip weekends)
  static DateTime addWorkingDays(DateTime date, int days) {
    var result = date;
    var remainingDays = days.abs();
    final forward = days > 0;
    
    while (remainingDays > 0) {
      result = forward 
          ? result.add(const Duration(days: 1))
          : result.subtract(const Duration(days: 1));
      
      if (result.weekday != DateTime.saturday && 
          result.weekday != DateTime.sunday) {
        remainingDays--;
      }
    }
    
    return result;
  }
}
