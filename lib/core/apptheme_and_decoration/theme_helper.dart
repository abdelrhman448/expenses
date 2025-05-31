import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../shared_pref/shared_pref_helper.dart';
import '../utils/constants/shared_preference_constants.dart';
import 'color_helper.dart';

class ThemeHelper {
  static ThemeData lightTheme(context)=> ThemeData(
    brightness: Brightness.light,

    primaryColor: PrimaryColors.main,
    useMaterial3: true,
    textTheme:TextThemeHelper.mainTextTheme(context),
    scaffoldBackgroundColor:NeutralColors.light,
    appBarTheme:  AppBarTheme(
      backgroundColor: Colors.grey,
      foregroundColor:Colors.black,
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.blue),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(),
    ),
  );


  static statusBarTheme() async {
    const SystemUiOverlayStyle(statusBarBrightness:
    Brightness.dark,

      ///top status bar icon for android color
      statusBarIconBrightness: Brightness.light,


      /// bottom bar button icon for android color
      systemNavigationBarIconBrightness: Brightness.dark,);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

}
