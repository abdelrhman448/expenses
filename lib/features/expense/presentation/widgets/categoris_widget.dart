import 'package:expenses/core/apptheme_and_decoration/color_helper.dart';
import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:expenses/core/size_config/app_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../dashboard/domain/entities/expense_model.dart';
import 'category_widget.dart';

class ExpensesGridWidget extends StatelessWidget {
  final List<ExpensesModel> expenses;
  final Function(int index) onCategoryClick;

  const ExpensesGridWidget({super.key, required this.expenses,required this.onCategoryClick});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: ResponsiveUtils.isSmallScreen(context)?1.2:1.4   // Adjust this ratio as needed
      ),
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return GestureDetector(
          onTap:()=> onCategoryClick(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CategoryWidget(categoriesEnum: expense.categoriesEnum,select: expense.selected,),
              ),
              Text(
                expense.categoriesEnum.name,
                style: Theme.of(context).textTheme.font10With400().copyWith(color: expense.selected?PrimaryColors.main:NeutralColors.dark),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}