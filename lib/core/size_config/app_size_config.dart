import 'package:flutter/material.dart';
class ResponsiveUtils {
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static double getResponsivePadding(BuildContext context) {
    if (isSmallScreen(context)) return 16.0;
    if (isMediumScreen(context)) return 24.0;
    return 32.0;
  }

  static int getGridColumns(BuildContext context) {
    if (isSmallScreen(context)) return 1;
    if (isMediumScreen(context)) return 2;
    return 3;
  }

  static double getCardWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (isSmallScreen(context)) return screenWidth - 32;
    if (isMediumScreen(context)) return (screenWidth - 48) / 2;
    return (screenWidth - 64) / 3;
  }
}
