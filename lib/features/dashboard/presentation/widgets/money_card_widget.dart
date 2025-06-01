import 'package:expenses/core/apptheme_and_decoration/color_helper.dart';
import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:expenses/core/extensions/sized_box_extension.dart';
import 'package:expenses/core/size_config/app_size_config.dart';
import 'package:expenses/core/utils/constants/padding.dart';
import 'package:expenses/features/dashboard/presentation/widgets/price_widget.dart';
import 'package:expenses/features/dashboard/presentation/widgets/price_with_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoneyCardWidget extends StatelessWidget {
  final String totalBalance;
  final String income;
  final String expenses;
  const MoneyCardWidget({super.key,required this.totalBalance,required this.expenses,required this.income});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height:ResponsiveUtils.isSmallScreen(context)? 190.h:245.h,
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        color: PrimaryColors.light,
        borderRadius: BorderRadius.circular(18.h),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: PaddingHelper.padding22Vertical(), horizontal: PaddingHelper.padding16Horizontal()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Balance",
                      style: Theme.of(context).textTheme.font16With400().copyWith(color: NeutralColors.light,fontWeight: FontWeight.w600),
                    ),
                    PriceWidget(price:totalBalance)
                  ],
                ),
                Spacer(),
                Icon(Icons.more_horiz_rounded,color: NeutralColors.light,size: 30.h,)
              ],
            ),
            32.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PriceWithTitleWidget(
                  price: income,
                  title: "income",
                  icon: Icons.arrow_downward_rounded,
                ),
                PriceWithTitleWidget(
                  price: expenses,
                  title: "Expenses",
                  icon: Icons.arrow_upward_sharp,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
