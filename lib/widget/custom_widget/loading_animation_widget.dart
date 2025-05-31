import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/size_config/app_size_config.dart';

class AdaptiveLoadingAnimationWidget extends StatefulWidget {
  const AdaptiveLoadingAnimationWidget({
    super.key,
    this.size,
    this.height,
    this.color = Colors.white,
    this.paddingTop,
  });

  final double? size;
  final double? height;
  final Color? color;
  final double? paddingTop;

  @override
  State<AdaptiveLoadingAnimationWidget> createState() => _AdaptiveLoadingAnimationWidgetState();
}

class _AdaptiveLoadingAnimationWidgetState extends State<AdaptiveLoadingAnimationWidget> {
  Widget _buildLoadingIndicator({
    double? size,
    double? paddingTop,
    double? height,
    Color? color,
  }) {
    final effectiveColor = color ?? Colors.white;
    final effectiveSize = size ?? ScreenUtil().screenHeight* 0.02;
    final effectiveHeight = height ?? ScreenUtil().screenHeight * 0.075;
    final effectivePadding = paddingTop ?? 0;

    return Container(
      margin: EdgeInsets.only(top: effectivePadding),
      width: double.infinity,
      height: effectiveHeight,
      child: Platform.isIOS || Platform.isMacOS
          ? CupertinoActivityIndicator(
        radius: effectiveSize,
        color: effectiveColor,
      )
          : Center(
            child: SizedBox(
              width: effectiveSize * 2,
              height: effectiveSize * 2,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                 color: effectiveColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoadingIndicator(
      size: widget.size,
      paddingTop: widget.paddingTop,
      height: widget.height,
      color: widget.color,
    );
  }
}