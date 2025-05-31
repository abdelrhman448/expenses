
import 'package:expenses/core/extensions/sized_box_extension.dart';
import 'package:expenses/core/size_config/app_size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_helper.dart';


class AppDecorations {

  static BoxDecoration dashboardBlueContainer({required BuildContext context}){
    return  BoxDecoration(
        color: PrimaryColors.main,
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd:Radius.circular(5.setHeight()),
          bottomStart:Radius.circular(5.setHeight()),
        )
    );
  }
  static BoxDecoration dashboardFilterContainer({required BuildContext context}){
    return   BoxDecoration(
      color: NeutralColors.light,
      borderRadius: BorderRadius.circular(10.setHeight()),
    );
  }
  static BoxDecoration mainButtonDecoration(){
    return  BoxDecoration(
        color: PrimaryColors.main,
        borderRadius: BorderRadius.circular(10.r)
    );
  }

}