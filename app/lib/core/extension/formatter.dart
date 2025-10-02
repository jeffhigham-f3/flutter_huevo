import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_huevo/core/extension/context.dart';

final _dayMonthFormatter = DateFormat('d MMMM');
final _dayMonthYearFormatter = DateFormat.yMMMMd();

extension DateTimeExt on DateTime {
  String toNiceDateString(BuildContext context) {
    if (isToday()) {
      // Today
      return context.l10n.today;
    }

    if (isYesterday()) {
      // Yesterday
      return context.l10n.yesterday;
    }

    if (isThisYear()) {
      // 12. March
      return toDayMonthString();
    }

    // 12. March, 2025
    return toDayMonthYearString();
  }

  String toDayMonthYearString() {
    return _dayMonthYearFormatter.format(this);
  }

  String toDayMonthString() {
    return _dayMonthFormatter.format(this);
  }

  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool isYesterday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day - 1;
  }

  bool isThisYear() {
    final now = DateTime.now();
    return year == now.year;
  }
}
