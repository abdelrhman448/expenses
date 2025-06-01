import 'package:expenses/core/apptheme_and_decoration/color_helper.dart';
import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:expenses/core/extensions/sized_box_extension.dart';
import 'package:expenses/core/formats/price.dart';
import 'package:expenses/core/utils/constants/padding.dart';
import 'package:expenses/core/validation/date_time.dart';
import 'package:expenses/features/dashboard/domain/entities/expense_icon_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../expense/domain/entities/expense_entity.dart';
import '../../../expense/presentation/widgets/category_widget.dart';


class ExpenseWidget extends StatelessWidget {
  final ExpenseEntity expenseEntity;

  const ExpenseWidget({super.key,required this.expenseEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: PaddingHelper.padding8Horizontal(context)),
      child: Card(
        elevation: 4,
        color: NeutralColors.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: PaddingHelper.padding16Horizontal(),vertical:PaddingHelper.padding8Vertical(context)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryWidget(
                categoriesEnum: CategoriesEnum.values.firstWhere((element) => element.name==expenseEntity.category,),
              ),
              15.widthBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  getIconAndColor(CategoriesEnum.values.firstWhere((element) => element.name==expenseEntity.category,)).title,
                    style: Theme.of(context).textTheme.font18With400(),
                  ),
                  Text(
                    "Manually",
                    style: Theme.of(context).textTheme.font14With400().copyWith(color: NeutralColors.shade600),
                  ),
      
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end
                ,
                children: [
                  Text(
                    "-\$${priceViewFormat(expenseEntity.convertedAmount.toString())}",
                    style: Theme.of(context).textTheme.font20With700(),
                  ),
                  4.heightBox,
                  Visibility(
                    visible: expenseEntity.amount!=expenseEntity.convertedAmount,
                    child: Column(
                      children: [
                        Text(
                          "-EGP ${priceViewFormat(expenseEntity.amount.toString())}",
                          style: Theme.of(context).textTheme.font14With400(),
                        ),
                        4.heightBox,
                      ],
                    ),
                  ),
                  Text(
                    getDayLabel(expenseEntity.date),
                    style: Theme.of(context).textTheme.font14With400().copyWith(color: NeutralColors.shade600),
                  ),

                ],
              ),
      
            ],
          ),
        ),
      ),
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
