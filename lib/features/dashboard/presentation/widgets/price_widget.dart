import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:expenses/core/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import '../../../../core/apptheme_and_decoration/color_helper.dart';
import '../../../../core/formats/price.dart';

class PriceWidget extends StatelessWidget {
  final double? fontSize;
  final String price;
  const PriceWidget({super.key,this.fontSize,required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "\$",
          style: Theme.of(context).textTheme.font24With400().copyWith(color: NeutralColors.light).copyWith(fontSize: fontSize),
        ),
        4.heightBox,
        Text(
          priceViewFormat(price).toString(),
          style: Theme.of(context).textTheme.font24With400().copyWith(color: NeutralColors.light,fontSize: fontSize),

        ),
      ],
    );
  }
}
