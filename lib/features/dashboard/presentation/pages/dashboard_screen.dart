import 'package:expenses/core/apptheme_and_decoration/color_helper.dart';
import 'package:expenses/core/apptheme_and_decoration/decoration_helper.dart';
import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:expenses/core/extensions/sized_box_extension.dart';
import 'package:expenses/core/size_config/app_size_config.dart';
import 'package:expenses/core/utils/constants/padding.dart';
import 'package:expenses/features/dashboard/presentation/widgets/header_welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/router_config.dart';
import '../../domain/entities/expense_model.dart';
import '../widgets/expense_widget.dart';
import '../widgets/filter_widget.dart';
import '../widgets/money_card_widget.dart';

class DashboardScreen extends StatelessWidget {

  const DashboardScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SizedBox(
         height: ScreenUtil().screenHeight,
         child: Stack(
           children: [
             Container(
               height:ResponsiveUtils.isSmallScreen(context)? 290.setHeight():320.setHeight(),
               width: ScreenUtil().screenWidth,
               decoration: AppDecorations.dashboardBlueContainer(context: context),
             ),
             // header welcome widget with filter
             PositionedDirectional(
               top:ResponsiveUtils.isSmallScreen(context)? 64.setHeight():50.setHeight(),
               end: 16.setWidth(),
               start: 16.setWidth(),
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   HeaderWelcomeWidget(
                       username: "ahmed ali33",
                       imageUrl: "https://img.freepik.com/premium-photo/artist-white_988361-3.jpg?semt=ais_hybrid&w=740"
                   ),
                   5.widthBox,
                   FilterWidget()
                 ],
               ),
             ),

           // money card with income and expenses
             PositionedDirectional(
                 top: 150.setHeight(),
                 end: 16.setWidth(),
                 start: 16.setWidth(),
                 child:MoneyCardWidget(
                   expenses: "4345",
                   income: "45643",
                   totalBalance: "54567",
                 )
             ),

             // list of expenses
             PositionedDirectional(
                 top: ResponsiveUtils.isSmallScreen(context)?360.setHeight():410.setHeight(),
                 end: 16.setWidth(),
                 start: 16.setWidth(),
                 child:Column(
                   children: [
                     Row(
                      children: [
                        Text(
                            "Recent Expenses",
                          style: Theme.of(context).textTheme.font18With400().copyWith(fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Text(
                          "See all",
                          style: Theme.of(context).textTheme.font16With400().copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                     ),
                     10.widthBox,
                     SizedBox(
                       height: ResponsiveUtils.isSmallScreen(context)? 350.setHeight():300.setHeight(),
                       child: ListView.separated(
                         padding: EdgeInsets.only(top: PaddingHelper.padding16Vertical()),
                           itemBuilder: (context, index) =>ExpenseWidget(
                            expensesModel: sampleExpenses[index],
                           ) ,
                           separatorBuilder: (context, index) => 8.heightBox,
                           itemCount: sampleExpenses.length
                       ),
                     )
                   ],
                 )
             )
           ],
         ),
       ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () =>context.pushNamed(addExpenseScreen),
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: 'Add Expense',
        child: Icon(Icons.add, color: NeutralColors.light, size: 24.sp,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
