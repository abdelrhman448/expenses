import 'package:expenses/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../features/expense/presentation/pages/add_expense_screen.dart';



String splash="splash";
String dashboard="dashboard";
String addExpenseScreen="addExpenseScreen";





GlobalKey<NavigatorState> hanyahNavigatorKey=GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: hanyahNavigatorKey,
  initialLocation: '/dashboard',
  routes: [
   GoRoute(
       path: '/dashboard',
       name: splash,
       pageBuilder: (context, state) => CupertinoPage(child: DashboardScreen()),
   ),
   GoRoute(
       path: '/addExpenseScreen',
       name: addExpenseScreen,
       pageBuilder: (context, state) => CupertinoPage(child: AddExpenseScreen()),
   ),


  ],
);


