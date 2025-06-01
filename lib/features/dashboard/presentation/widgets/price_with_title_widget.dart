import 'package:expenses/core/apptheme_and_decoration/color_helper.dart';
import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:expenses/core/extensions/sized_box_extension.dart';
import 'package:expenses/core/size_config/app_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'price_widget.dart';

class PriceWithTitleWidget extends StatelessWidget {
  final String title;
  final String price;
  final IconData icon;
  const PriceWithTitleWidget({super.key,required this.title,required this.price,required this.icon});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: PrimaryColors.lightShade,
              radius: 14.h,
              child: Icon(icon,size:18.h,color: NeutralColors.light,),
            ),
            3.widthBox,
            Text(
             title,
              style: Theme.of(context).textTheme.font18With400().copyWith(color: NeutralColors.light.withAlpha(210)),
            ),
          ],
        ),
        4.heightBox,
        PriceWidget(
          price: price,
          fontSize: 19.sp,
        )
      ],
    );
  }
}
