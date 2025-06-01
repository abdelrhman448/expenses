import 'dart:convert';



extension NullableStringExtension on String? {
  bool get isNullOrEmpty => this == null;

  int? toIntOrNull() {
    return int.tryParse(this ?? '');
  }

  double? toDoubleOrNull() {
    return double.tryParse(this ?? '');
  }
}
