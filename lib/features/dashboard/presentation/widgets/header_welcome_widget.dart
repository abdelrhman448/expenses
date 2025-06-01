import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:expenses/core/extensions/sized_box_extension.dart';
import 'package:expenses/core/size_config/app_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/apptheme_and_decoration/color_helper.dart';
import '../../../../widget/custom_image_network.dart';

class HeaderWelcomeWidget extends StatelessWidget {
  final String imageUrl;
  final String username;
  const HeaderWelcomeWidget({super.key,required this.username,required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.h),
              child: NetworkImageComponent(
                imageUrl: imageUrl,
                fit: BoxFit.fill,

              ),
            ),
          ),
          5.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good morning",
                  style: Theme.of(context).textTheme.font14With400().copyWith(color: NeutralColors.light.withAlpha(200)),
                ),
                2.heightBox,
                Text(
                 username,
                  style: Theme.of(context).textTheme.font18With400().copyWith(color: NeutralColors.light),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
