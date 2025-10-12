import 'package:intl/intl.dart';

extension DoubleExtensions on double {
  // Làm tròn
  double roundToDecimal(int places) {
    final mod = 10.0 * places;
    return (this * mod).round().toDouble() / mod;
  }

  // Currency format
  String toCurrency({String symbol = '₫', int decimalDigits = 0}) {
    final formatter = NumberFormat('#,###${decimalDigits > 0 ? '.' : ''}${'#' * decimalDigits}');
    return '${formatter.format(this)}$symbol';
  }

  // Percentage
  String toPercentage({int decimalDigits = 0}) {
    return '${(this * 100).toStringAsFixed(decimalDigits)}%';
  }
}