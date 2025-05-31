// import 'package:expenses/features/dashboard/presentation/pages/dashboard_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// void main(){
//   group(
//       'DashboardScreen Widget Tests', (){
//     setUp(() async {
//       // Initialize ScreenUtil for tests
//       await ScreenUtil.ensureScreenSize();
//     });
//     testWidgets('should render DashboardScreen correctly', (WidgetTester tester) async {
//       // Arrange & Act
//       await tester.pumpWidget(
//         MaterialApp(
//           home: DashboardScreen(),
//         ),
//       );
//
//       // Assert
//       expect(find.byType(DashboardScreen), findsOneWidget);
//       expect(find.byType(Scaffold), findsOneWidget);
//       expect(find.byType(Stack), findsOneWidget);
//     });
//
//   );
// }