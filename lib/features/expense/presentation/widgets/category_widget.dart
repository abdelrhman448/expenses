import 'package:expenses/core/extensions/sized_box_extension.dart';
import 'package:expenses/features/dashboard/presentation/widgets/expense_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/apptheme_and_decoration/color_helper.dart';
import '../../../dashboard/domain/entities/expense_icon_model.dart';
enum CategoriesEnum {groceries,entertainment,gas,shopping,newsPaper,transport,rent}


class CategoryWidget extends StatelessWidget {
  final CategoriesEnum categoriesEnum;
  bool select;

   CategoryWidget({super.key,required this.categoriesEnum,this.select=false});

  @override
  Widget build(BuildContext context) {
    return   Container(
        height: 40.w,
        width: 40.w,
        decoration: BoxDecoration(
            color: select?PrimaryColors.main:getIconAndColor(categoriesEnum).backgroundColor,
            shape: BoxShape.circle
        ),
        child: Icon(getIconAndColor(categoriesEnum).icon,size: 20.h,color: getIconAndColor(categoriesEnum).color,)
    );
  }
  ExpenseIconModel getIconAndColor (CategoriesEnum categories){
    switch(categories){
      case CategoriesEnum.groceries:
        return ExpenseIconModel(
            color: PrimaryColors.groceriesIcon,
            backgroundColor: PrimaryColors.groceriesBg,
            icon: FontAwesomeIcons.cartFlatbedSuitcase,
            title: "Groceries"
        );
      case CategoriesEnum.entertainment:
        return ExpenseIconModel(
            color: PrimaryColors.entertainmentIcon,
            backgroundColor: PrimaryColors.entertainmentBg,
            icon: FontAwesomeIcons.houseMedical,
            title:"Entertainment"
        );
      case CategoriesEnum.gas:
        return ExpenseIconModel(
            color: PrimaryColors.gasIcon,
            backgroundColor: PrimaryColors.gasBg,
            icon: FontAwesomeIcons.gasPump,
            title: "Gas"
        );
      case CategoriesEnum.shopping:
        return ExpenseIconModel(
            color: PrimaryColors.shoppingIcon,
            backgroundColor: PrimaryColors.shoppingBg,
            icon: FontAwesomeIcons.shop,
            title: "Shopping"
        );
      case CategoriesEnum.newsPaper:
        return ExpenseIconModel(
            color: PrimaryColors.newsPaperIcon,
            backgroundColor: PrimaryColors.newsPaperBg,
            icon: FontAwesomeIcons.newspaper,
            title: "News paper"
        );
      case CategoriesEnum.transport:
        return ExpenseIconModel(
            color: PrimaryColors.transportIcon,
            backgroundColor: PrimaryColors.transportBg,
            icon: FontAwesomeIcons.car,
            title: "Car"
        );
      case CategoriesEnum.rent:
        return ExpenseIconModel(
            color: PrimaryColors.rentIcon,
            backgroundColor: PrimaryColors.rentBg,
            icon: FontAwesomeIcons.houseMedicalFlag,
            title: "Rent"
        );
    }
  }

}
