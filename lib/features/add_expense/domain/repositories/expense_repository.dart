import 'package:expenses/features/add_expense/domain/entities/expense_entity.dart';

abstract class ExpenseRepository {
  Future<List<ExpenseEntity>> getExpenses({
    int? limit,
    String? category,
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
  });
  Future<double> convertCurrency(double amount, String fromCurrency, String toCurrency);
}