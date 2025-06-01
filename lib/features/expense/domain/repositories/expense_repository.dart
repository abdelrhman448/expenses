import 'package:expenses/features/dashboard/presentation/widgets/filter_widget.dart';

import '../entities/expense_entity.dart';

abstract class ExpenseRepository {
  Future<List<ExpenseEntity>> getExpenses({
    int? limit,
    int page,
    String? category,
    required FilterByDays filter,
  });

  Future<ExpenseEntity?> getExpenseById(int id);

  Future<int> createExpense(ExpenseEntity expense);

  Future<bool> updateExpense(ExpenseEntity expense);

  Future<bool> deleteExpense(int id);

  Future<double> getTotalExpenses({
    String? category,

  });

  Future<int> getExpensesCount({
    String? category,
    String? filter, // 'week', 'month', or null

  });

  Future<double> convertCurrency(double amount, String fromCurrency);
}