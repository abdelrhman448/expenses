import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:expenses/core/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/apptheme_and_decoration/color_helper.dart';
import '../../core/apptheme_and_decoration/decoration_helper.dart';
import '../../core/size_config/app_size_config.dart';
import '../custom_widget/loading_animation_widget.dart';


class MainButton extends StatelessWidget {
  final double? height;
  final double?  width;
  final bool enabled;
  final VoidCallback onPress;
  final bool loading;
  final String title;
  const MainButton({super.key,this.height,this.width,required this.title,required this.onPress,this.loading=false,this.enabled=true});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:enabled?onPress:null,
      child: Container(
        height: 48.setHeight(),
        decoration: BoxDecoration(
          color: PrimaryColors.main,
          borderRadius: BorderRadius.circular(10.r)
        ),
        child: Center(
          child: Visibility(
            visible: !loading,
            replacement: AdaptiveLoadingAnimationWidget(),
            child: Text(
              title,
              style: Theme.of(context).textTheme.font14With400().copyWith(fontWeight: FontWeight.bold,color: NeutralColors.light),
            ),
          ),
        ),
      ),
    );
  }
}
