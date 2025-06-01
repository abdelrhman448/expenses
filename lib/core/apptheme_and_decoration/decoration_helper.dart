import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_helper.dart';


class AppDecorations {

  static BoxDecoration dashboardBlueContainer({required BuildContext context}){
    return  BoxDecoration(
        color: PrimaryColors.main,
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd:Radius.circular(5.h),
          bottomStart:Radius.circular(5.h),
        )
    );
  }
  static BoxDecoration dashboardFilterContainer({required BuildContext context}){
    return   BoxDecoration(
      color: NeutralColors.light,
      borderRadius: BorderRadius.circular(10.h),
    );
  }
  static BoxDecoration mainButtonDecoration(){
    return  BoxDecoration(
        color: PrimaryColors.main,
        borderRadius: BorderRadius.circular(10.r)
    );
  }

}