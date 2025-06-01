
import '../../../expense/presentation/widgets/category_widget.dart';

class ExpensesModel{
  final CategoriesEnum categoriesEnum;
  final double expenseValue;
  final DateTime date;
  bool selected;


  ExpensesModel({
  required this.categoriesEnum,
  required this.date,
  required this.expenseValue,
    this.selected=false


  });
  void updateExpenseSelection(List<ExpensesModel> expenses, int selectedIndex) {
    for (int i = 0; i < expenses.length; i++) {
      expenses[i].selected = (i == selectedIndex);
    }
  }
}


List<ExpensesModel> sampleExpenses = [
  ExpensesModel(
    categoriesEnum: CategoriesEnum.groceries,
    expenseValue: 75.50,
    date: DateTime(2025, 5, 28),

  ),
  ExpensesModel(
    categoriesEnum: CategoriesEnum.entertainment,
    expenseValue: 40.00,
    date: DateTime(2025, 5, 27),
  ),
  ExpensesModel(
    categoriesEnum: CategoriesEnum.gas,
    expenseValue: 60.75,
    date: DateTime(2025, 5, 26),
  ),
  ExpensesModel(
    categoriesEnum: CategoriesEnum.shopping,
    expenseValue: 120.00,
    date: DateTime(2025, 5, 25),
  ),
  ExpensesModel(
    categoriesEnum: CategoriesEnum.newsPaper,
    expenseValue: 10.00,
    date: DateTime(2025, 5, 24),
  ),
  ExpensesModel(
    categoriesEnum: CategoriesEnum.transport,
    expenseValue: 25.00,
    date: DateTime(2025, 5, 23),
  ),
  ExpensesModel(
    categoriesEnum: CategoriesEnum.rent,
    expenseValue: 850.00,
    date: DateTime(2025, 5, 1),
  ),
];
