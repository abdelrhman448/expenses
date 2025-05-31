import 'package:expenses/core/size_config/app_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_helper.dart';

/// TextTheme implementation based on the design system
/// Contains all the necessary text styles for the application
/// Organized by typography hierarchy (headings, subtitles, body text)
class TextThemeHelper {
  static TextTheme mainTextTheme(context) => TextTheme(

    displayLarge: TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
      fontFamily: 'poppins'

    ),
    displayMedium: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
        fontFamily: 'poppins'

    ),
    bodyMedium:  TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
        fontFamily: 'poppins'

    ),
    bodyLarge: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'poppins'

    ),
    displaySmall: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
        fontFamily: 'poppins'

    ),
    headlineLarge: TextStyle(
      fontSize:14.sp,
      fontWeight: FontWeight.w400,
        fontFamily: 'poppins'


    ),
    headlineMedium: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
        fontFamily: 'poppins'

    ),
    labelLarge: TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
        fontFamily: 'poppins'

    ),

  );

}

extension CustomTextTheme on TextTheme {
  TextStyle font32With700() {
    return displayLarge!;
  }

  TextStyle font20With700() {
    return displayMedium!;
  }

  TextStyle font16With400() {
    return displaySmall!;
  }

  TextStyle font14With400() {
    return headlineLarge!;
  }

  TextStyle font12With400() {
    return headlineMedium!;
  }

  TextStyle font18With400() {
    return bodyLarge!;
  }
  TextStyle font24With400() {
    return bodyMedium!;
  }

  TextStyle font10With400() {
    return labelLarge!;
  }

}
