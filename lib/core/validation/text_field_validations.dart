import 'package:expenses/core/extensions/extension_util/string_extension.dart';


/// A Flutter utility class that provides validation functions for common input types
class ValidationHelper {
  /// Validates an email address
  /// Returns null if valid, or an error message if invalid
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'fieldEmpty'.tr;
    }
    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if (!emailValid) {
    return 'pleaseEnterAValidEmailAddress'.tr;
    }

    return null;
  }

  /// Validates an Egyptian phone number
  /// Returns null if valid, or an error message if invalid
  static String? validateEgyptianPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'fieldEmpty'.tr;
    }

    // Remove any spaces, dashes, or parentheses
    final cleaned = value.replaceAll(RegExp(r'[\s\-()]'), '');

    // Egyptian mobile numbers start with:
    // - 010, 011, 012, 015 (Vodafone, Etisalat, Orange, WE)
    // Can be in formats:
    // - 01xxxxxxxxx (11 digits)
    // - +201xxxxxxxxx (12 digits with + sign)
    // - 201xxxxxxxxx (12 digits)
    final egyptianMobileRegex = RegExp(r'^((\+?20)|0)?1[0125][0-9]{8}$');

    if (!egyptianMobileRegex.hasMatch(cleaned)) {
      return 'incorrectPhoneNumber'.tr;
    }

    return null;
  }

  /// Validates a password with customizable requirements
  /// Returns null if valid, or an error message if invalid
  static String? validatePassword(
      String? value, {
        int minLength = 8,
        bool requireUppercase = true,
        bool requireLowercase = true,
        bool requireNumbers = true,
        bool requireSpecialChars = true,
      }) {
    if (value == null || value.isEmpty) {
      return 'fieldEmpty'.tr;
    }

    if (value.length < minLength) {
      return 'incorrectPassword'.tr;
    }

    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return 'incorrectPassword'.tr;
    }

    if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      return 'incorrectPassword'.tr;
    }

    if (requireNumbers && !value.contains(RegExp(r'[0-9]'))) {
      return 'incorrectPassword'.tr;
    }

    if (requireSpecialChars &&
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'incorrectPassword'.tr;
    }

    return null;
  }

  static String? validateConfirmPassword(
      String? confirmPassword,
      String? originalPassword,
      ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'fieldEmpty'.tr;
    }

    if (confirmPassword != originalPassword) {
      return 'passwordsDoNotMatch'.tr; // تأكد إن دي موجودة في ملف الترجمة
    }

    return null;
  }

  /// Validates an Egyptian National ID (14 digits)
  /// Returns null if valid, or an error message if invalid
  static String? validateEgyptianNationalID(String? value) {
    if (value == null || value.isEmpty) {
      return 'National ID is required';
    }

    // Egyptian National ID is 14 digits
    if (!RegExp(r'^\d{14}$').hasMatch(value)) {
      return 'National ID must be exactly 14 digits';
    }

    // First digit century code: 2 = 1900s, 3 = 2000s
    final centuryCode = int.parse(value[0]);
    if (centuryCode != 2 && centuryCode != 3) {
      return 'National ID must start with 2 or 3';
    }

    // Check birth date validity (digits 1-7 represent YYMMDD)
    try {
      final year = int.parse(value.substring(1, 3)) + (centuryCode == 2 ? 1900 : 2000);
      final month = int.parse(value.substring(3, 5));
      final day = int.parse(value.substring(5, 7));

      if (month < 1 || month > 12) {
        return 'National ID contains invalid birth month';
      }

      if (day < 1 || day > 31) {
        return 'National ID contains invalid birth day';
      }

      // Check if date is valid using DateTime
      DateTime.utc(year, month, day);
    } catch (e) {
      return 'National ID contains invalid birth date';
    }

    return null;
  }

  /// Validates a URL string
  /// Returns null if valid, or an error message if invalid
  static String? validateURL(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }

    final urlRegex = RegExp(
        r'^(http|https)://'
        r'([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,6}'
        r'(/[\w\-\.,@?^=%&:/~\+#]*)*$'
    );

    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  /// Validates a date string in YYYY-MM-DD format
  /// Returns null if valid, or an error message if invalid
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date is required';
    }

    // Check format
    if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
      return 'Date must be in YYYY-MM-DD format';
    }

    try {
      final parts = value.split('-');
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);

      // Create DateTime object to validate the date
      DateTime(year, month, day);
    } catch (e) {
      return 'Please enter a valid date';
    }

    return null;
  }

  /// Validates a credit card number using Luhn algorithm
  /// Returns null if valid, or an error message if invalid
  static String? validateCreditCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Credit card number is required';
    }

    // Remove any spaces or dashes
    final cleanedValue = value.replaceAll(RegExp(r'[\s\-]'), '');

    // Check if all characters are digits
    if (!RegExp(r'^\d+$').hasMatch(cleanedValue)) {
      return 'Credit card number must contain only digits';
    }

    // Check length (most cards are 13-19 digits)
    if (cleanedValue.length < 13 || cleanedValue.length > 19) {
      return 'Credit card number has an invalid length';
    }

    // Luhn algorithm validation
    int sum = 0;
    bool alternate = false;

    for (int i = cleanedValue.length - 1; i >= 0; i--) {
      int digit = int.parse(cleanedValue[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    if (sum % 10 != 0) {
      return 'Invalid credit card number';
    }

    return null;
  }

  static String? validateUsername(String? value) {
    // Check if empty
    if (value == null || value.isEmpty) {
      return 'fieldEmpty'.tr;
    }

    // Check length
    if (value.length < 3) {
      return 'incorrectUsername'.tr;
    }

    if (value.length > 20) {
      return 'incorrectUsername'.tr;
    }

    // Check for valid characters (alphanumeric and some special characters)
    final RegExp validCharsRegex = RegExp(r'^[a-zA-Z0-9._-]+$');
    if (!validCharsRegex.hasMatch(value)) {
      return 'incorrectUsername'.tr;
    }

    // Check that username doesn't start with special characters
    if (value.startsWith('.') || value.startsWith('_') || value.startsWith('-')) {
      return 'incorrectUsername'.tr;
    }

    // Check that username doesn't end with special characters
    if (value.endsWith('.') || value.endsWith('_') || value.endsWith('-')) {
      return 'incorrectUsername'.tr;
    }

    // Check for consecutive special characters
    if (value.contains('..') || value.contains('__') || value.contains('--') ||
        value.contains('._') || value.contains('_.') || value.contains('.-') ||
        value.contains('-.') || value.contains('_-') || value.contains('-_')) {
      return 'incorrectUsername'.tr;
    }

    return null; // Return null when validation passes
  }
}