import 'package:flutter/cupertino.dart';

import '../../../add_expense/presentation/widgets/category_widget.dart';
import 'expense_model.dart';

class ExpenseIconModel{
  final IconData icon;
  final String title;
  final Color color;
  final Color backgroundColor;

  ExpenseIconModel({
    required this.color,
    required this.icon,
    required this.backgroundColor,
    required this.title,

});
}
