import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/apptheme_and_decoration/theme_helper.dart';
import '../../core/localization/app_localization.dart';
import '../../core/localization/language_cubit.dart';
import '../../core/router/router_config.dart';
import '../../core/size_config/app_size_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) =>  MaterialApp.router(
              builder: FToastBuilder(),
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              locale: Locale('en', ''),
              theme: ThemeHelper.lightTheme(context),
              routerConfig: router,

            ),
          );
        },
      ),
    );
  }
}
