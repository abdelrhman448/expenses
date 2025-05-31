import 'dart:convert';

import '../localization/app_localization.dart';


extension StringExtension on String {
  /// Example: your name => Text("userName".tr),
  String get tr => AppLocalizations.instance.translate(this) ?? "";

  /// Capitalize each word inside string
  /// Example: your name => Your Name
  String capitalizeWords() {
    if (isEmpty) {
      return this;
    }
    return split(' ')
        .map((word) =>
    word.isEmpty ? '' : '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  /// Uppercase first letter inside string and let the others lowercase
  /// Example: your name => Your name
  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// returns only the first word of a sentence
  String firstWord() {
    if (isEmpty) {
      return '';
    }
    final firstSpace = indexOf(' ');
    if (firstSpace == -1) {
      return this;
    }
    return substring(0, firstSpace);
  }

  /// Remove all whitespace inside string
  /// Example: your name => yourname
  String removeAllWhitespace() {
    return replaceAll(' ', '');
  }

  ///removes all leading and trailing whitespace characters from the string,
  /// and also removes any whitespace characters between words
  String get trimAll => replaceAll(RegExp(r'\s+'), ' ').trim();

  ///removes all trailing whitespace characters from the string,
  ///or returns an empty string if the input is null or empty:
  String get trimEnd => trimRight();

  ///truncates the string to the specified length,
  ///adding an optional omission at the end.
  ///If the input is null or empty, returns an empty string
  String truncate(int length, {String omission = '...'}) {
    if (isEmpty) {
      return '';
    }
    if (this.length <= length) {
      return this;
    }
    return '${substring(0, length - omission.length)}$omission';
  }

  ///converts the string to camel case, where the first letter of each word
  ///except the first is capitalized and all spaces are removed.
  ///If the input is null or empty, returns an empty string
  String toCamelCase() {
    if (isEmpty) {
      return '';
    }
    final words = split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) {
      return '';
    }
    final first = words.first.toLowerCase();
    final rest = words
        .skip(1)
        .map((w) => '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}');
    return '$first${rest.join()}';
  }

  /// removes all accents from the string,
  /// replacing them with their non-accented equivalents.
  /// If the input is null or empty, returns an empty string
  String stripAccents() {
    if (isEmpty) {
      return '';
    }
    return replaceAll(RegExp(r'[ÀÁÂÃÄÅàáâãäå]'), 'a')
        .replaceAll(RegExp(r'[ÈÉÊËèéêë]'), 'e')
        .replaceAll(RegExp(r'[ÌÍÎÏìíîï]'), 'i')
        .replaceAll(RegExp(r'[ÒÓÔÕÖØòóôõöø]'), 'o')
        .replaceAll(RegExp(r'[ÙÚÛÜùúûü]'), 'u')
        .replaceAll(RegExp(r'[Ýýÿ]'), 'y');
  }

  /// converts the string to a hexadecimal representation.
  /// If the input is null or empty, returns an empty string
  String toHexString() {
    if (isEmpty) {
      return '';
    }
    return codeUnits.map((c) => c.toRadixString(16).padLeft(2, '0')).join('');
  }

  ///encodes the string as a base-64 string.
  /// If the input is null or empty, returns an empty string:
  String toBase64() {
    if (isEmpty) {
      return '';
    }
    return base64Encode(utf8.encode(this));
  }

  ///escapes HTML special characters in the string,
  ///replacing them with their corresponding HTML entities.
  ///If the input is null or empty, returns an empty string
  String escapeHtml() {
    if (isEmpty) {
      return '';
    }
    return const HtmlEscape().convert(this);
  }

  DateTime? toDateTime({String format = 'yyyy-MM-ddTHH:mm:ss'}) {
    if (isEmpty) {
      return null;
    }
    return DateTime.tryParse(
      replaceAll(RegExp(r'\.\d+'), ''),
    );
  }

  /// returns true if the length of the string is between min and max,
  /// inclusive, otherwise false. If the input is null or empty, returns false
  bool hasLengthInRange(int min, int max) {
    if (isEmpty) {
      return false;
    }
    final length = this.length;
    return length >= min && length <= max;
  }

  ///returns true if the string contains any of the specified values,
  ///otherwise false. If the input or the values list is null, returns false:
  bool containsAny(List<String>? values) {
    if (isEmpty || values == null) {
      return false;
    }
    return values.any((value) => contains(value));
  }

  ///returns true if the string starts with an uppercase letter,
  ///otherwise false. If the input is null or empty, returns false:
  bool get startsWithUpper =>
      isNotEmpty == true && RegExp(r'^[A-Z]').hasMatch(this);

  ///returns true if the string contains only digits,
  ///otherwise false. If the input is null or empty, returns false
  bool get containsOnlyDigits =>
      isNotEmpty == true && RegExp(r'^\d+$').hasMatch(this);

  ///returns true if the string contains the specified substring,
  /// ignoring case, otherwise false:
  bool containsIgnoreCase(String other) {
    return toLowerCase().contains(other.toLowerCase());
  }

  bool hasMatch(String pattern) {
    return RegExp(pattern).hasMatch(this);
  }

  /// Checks if string consist only numeric.
  /// Numeric only doesn't accepting "." which double data type have
  bool isNumericOnly() => hasMatch(r'^\d+$');

  /// Checks if string consist only Alphabet. (No Whitespace)
  bool isAlphabetOnly() => hasMatch(r'^[a-zA-Z]+$');

  /// Checks if string contains at least one Capital Letter
  bool hasCapitalLetter() => hasMatch(r'[A-Z]');

  /// Checks if string is boolean.
  bool isBool() {
    return (this == 'true' || this == 'false');
  }

  ///returns true if the string matches the format of an email address,
  ///otherwise false. If the input is null or empty, returns false
  bool get isEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  ///returns true if the string matches the format of a UUID (Universally Unique Identifier),
  ///otherwise false. If the input is null or empty, returns false
  bool isUUID() {
    return isNotEmpty == true &&
        RegExp(r'^[a-f\d]{8}-[a-f\d]{4}-[a-f\d]{4}-[a-f\d]{4}-[a-f\d]{12}$',
            caseSensitive: false)
            .hasMatch(this);
  }

  ///returns true if the string meets password complexity requirements,
  /// such as a certain length and containing both letters and numbers.
  /// If the input is null or empty, returns false:
  bool isValidPassword() {
    if (isEmpty) {
      return false;
    }
    final hasLetters = RegExp(r'[a-zA-Z]').hasMatch(this);
    final hasNumbers = RegExp(r'\d').hasMatch(this);
    return length >= 8 && hasLetters && hasNumbers;
  }

  ///returns true if the string meets username complexity requirements,
  ///such as a certain length and containing only alphanumeric characters.
  ///If the input is null or empty, returns false

  bool isValidUsername() {
    if (isEmpty) {
      return false;
    }
    return length >= 4 && RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);
  }

  ///returns true if the string matches the format of a phone number,
  ///otherwise false. If the input is null or empty, returns false:
  bool isPhoneNumber() {
    return isNotEmpty == true && RegExp(r'^\d{10}$').hasMatch(this);
  }

  ///returns true if the string matches the format of a URL,
  ///otherwise false. If the input is null or empty, returns false
  bool isUrl() {
    return isNotEmpty == true && Uri.tryParse(this)?.isAbsolute == true;
  }

  ///returns true if the string contains only alphanumeric characters,
  ///otherwise false. If the input is null or empty, returns false
  bool isAlphanumeric() {
    return isNotEmpty == true && RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);
  }

  ///returns the number of times the specified pattern appears in the string,
  ///or 0 if the input is null or empty
  int countOccurrences(String pattern) {
    if (isEmpty) {
      return 0;
    }
    return RegExp(pattern).allMatches(this).length;
  }

  ///returns true if the string is a palindrome (i.e., reads the same forwards and backwards),
  /// otherwise false. If the input is null or empty, returns false
  bool isPalindrome() {
    if (isEmpty) {
      return false;
    }
    final reversed = split('').reversed.join('');
    return this == reversed;
  }

  ///returns true if the string contains only whitespace characters,
  /// otherwise false. If the input is null or empty, returns false
  bool containsOnlyWhitespace() {
    return isNotEmpty == true && RegExp(r'^\s*$').hasMatch(this);
  }

  bool get hasAtLeastOneUpperCase => isNotEmpty == true && RegExp(r'[A-Z]').hasMatch(this);

  /// remove anything except numbers from a string and convert it to an integer value
  int parseIntFromCurrency() {
    RegExp regExp = RegExp(r'\d+');
    String numberString = regExp.allMatches(this).map((m) => m.group(0)).join();
    return int.parse(numberString);
  }
}

extension NullableStringExtension on String? {
  bool get isNullOrEmpty => this == null;

  int? toIntOrNull() {
    return int.tryParse(this ?? '');
  }

  double? toDoubleOrNull() {
    return double.tryParse(this ?? '');
  }
}
