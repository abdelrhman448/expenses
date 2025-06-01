import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:expenses/core/apptheme_and_decoration/color_helper.dart';
import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:expenses/core/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextStyle? hintStyle;
  final bool enabled;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final String title;
  final TextInputType? textInputType;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.hintStyle,
    this.enabled = true,
    this.controller,
    this.suffixIcon,
    this.onTap,
    this.validator,
    this.textInputType,

    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.font16With400().copyWith(fontWeight: FontWeight.w700),
        ),
        8.heightBox,
        GestureDetector(
          onTap: enabled?null:onTap,
          child: TextFormField(
            inputFormatters: [
              CurrencyTextInputFormatter(NumberFormat(),enableNegative: false),

            ],
            keyboardType: textInputType,
            enabled: enabled,
            validator: validator,
            style:Theme.of(context).textTheme.font14With400() ,
            cursorHeight: 15.h,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 5.h,left: 10.w,right: 10.w),
              hintText: hintText,
              hintStyle: hintStyle??Theme.of(context).textTheme.font14With400().copyWith(color: NeutralColors.shade400),
              suffixIcon: suffixIcon ,
              fillColor: PrimaryColors.groceriesBg,
              filled: true, // important to show fillColor
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.h),
                borderSide: BorderSide(color: PrimaryColors.groceriesBg),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.h),
                borderSide: BorderSide(color: PrimaryColors.groceriesBg),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.h),
                borderSide: BorderSide(color: PrimaryColors.groceriesBg),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.h),
                borderSide: BorderSide(color: PrimaryColors.groceriesBg),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.h),
                borderSide: BorderSide(color: PrimaryColors.groceriesBg),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.h),
                borderSide: BorderSide(color: PrimaryColors.groceriesBg),
              ),
            ),
          ),
        ),
      ],
    );
  }
}