import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../size_config/app_size_config.dart';

extension SizeExtensionBox on num {
  Widget get widthBox => SizedBox(width: ScreenUtil().setWidth(this),);

  Widget get heightBox => SizedBox(
    height: ScreenUtil().setHeight(this),
  );

  double setHeight()=>ScreenUtil().setHeight(this);
  double setWidth()=>ScreenUtil().setWidth(this);

}
