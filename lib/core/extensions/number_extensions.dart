// lib/extensions/number_extensions.dart
import 'dart:math';

import 'package:intl/intl.dart';

extension IntExtensions on int {
  Duration get milliseconds => Duration(milliseconds: this);
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get hours => Duration(hours: this);
  Duration get days => Duration(days: this);

  String toCurrency({String symbol = '₫'}) {
    final formatter = NumberFormat('#,###');
    return '${formatter.format(this)}$symbol';
  }

  String padLeft(int width, [String padding = '0']) {
    return toString().padLeft(width, padding);
  }
}

extension DoubleExtensions on double {
  double roundTo(int decimals) {
    final mod = pow(10, decimals);
    return (this * mod).round() / mod;
  }

  String toCurrency({String symbol = '₫', int decimals = 0}) {
    final formatter = NumberFormat('#,###${decimals > 0 ? '.${"#" * decimals}' : ''}');
    return '${formatter.format(this)}$symbol';
  }

  String toPercentage({int decimals = 0}) {
    return '${(this * 100).toStringAsFixed(decimals)}%';
  }
}

extension NumExtensions on num {
  String formatCurrency({String symbol = '₫', int decimals = 0}) {
    return this is int 
      ? (this as int).toCurrency(symbol: symbol)
      : (this as double).toCurrency(symbol: symbol, decimals: decimals);
  }
}