import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getDayLabel(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(Duration(days: 1));
  final inputDate = DateTime(date.year, date.month, date.day);

  if (inputDate == today) {
    return 'Today';
  } else if (inputDate == yesterday) {
    return 'Yesterday';
  } else {
    return DateFormat('MMM d, yyyy').format(date); // e.g., May 29, 2025
  }
}

Future<DateTime?> pickDate(BuildContext context, {DateTime? initialDate}) async {
  final now = DateTime.now();
  return await showDatePicker(
    context: context,
    initialDate: initialDate ?? now,
    firstDate: DateTime(now.year - 100),
    lastDate: DateTime(now.year + 10),
  );
}

