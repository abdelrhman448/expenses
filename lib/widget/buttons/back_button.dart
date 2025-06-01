import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:expenses/core/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/apptheme_and_decoration/color_helper.dart';



class CustomBackButton extends StatelessWidget {
  final String title;
  final bool withBackButton;
  final VoidCallback? onPress;
   const CustomBackButton({super.key,required this.title,this.onPress,this.withBackButton=true});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => onPress!=null&&withBackButton?Navigator.pop(context):null,
      child: Row(
        children: [
          Visibility(
            visible: withBackButton,
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: NeutralColors.dark,
                  size: 12.h,
                ),
                4.widthBox,
              ],
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.font16With400(),
          )
        ],
      ),
    );
  }
}
