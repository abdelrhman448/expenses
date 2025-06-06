import 'package:flutter/material.dart';

// Color Extensions
extension Hex on Color {
  /// return hex String
  String toHex({bool leadingHashSign = true, bool includeAlpha = false}) =>
      '${leadingHashSign ? '#' : ''}'
      '${includeAlpha ? alpha.toRadixString(16).padLeft(2, '0') : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  /// Return true if given Color is dark
  bool isDark() => getBrightness() < 128.0;

  /// Return true if given Color is light
  bool isLight() => !isDark();

  /// Returns Brightness of give Color
  double getBrightness() =>
      (this.red * 299 + this.green * 587 + this.blue * 114) / 1000;

  /// Returns Luminance of give Color
  double getLuminance() => this.computeLuminance();
}

///////How to use////////

//Color color = Colors.red;
//print(color.toHex(includeAlpha: true));
//print(color.toHex(includeAlpha: false));
//print(color.toHex(leadingHashSign: false));
//print(color.toHex(leadingHashSign: false, includeAlpha: false));

//print(color.isDark());
//print(color.isLight());
//print(color.getBrightness());
//print(color.getLuminance());