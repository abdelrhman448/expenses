import 'package:expenses/features/dashboard/presentation/widgets/filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/apptheme_and_decoration/theme_helper.dart';
import '../../core/router/router_config.dart';
import '../../core/service_locator/get_it.dart';
import '../dashboard/presentation/manager/dashboard_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) =>  BlocProvider(
        create: (context) => DashboardCubit(
          getExpensesUseCase: getIt(),
          getTotalExpensesUseCase: getIt(),
        )..loadDashboard(filter: FilterByDays.lastMonth),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          locale: Locale('en', ''),
          theme: ThemeHelper.lightTheme(context),
          routerConfig: router,

        ),
      ),
    );
  }
}
