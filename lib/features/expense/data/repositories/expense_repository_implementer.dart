import 'package:expenses/features/dashboard/presentation/widgets/filter_widget.dart';

import '../../domain/entities/expense_entity.dart';
import '../../domain/repositories/expense_repository.dart';
import '../data_sources/add_expense_data_source.dart';
import '../../../../core/database/database_helper.dart';
import '../models/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final DatabaseHelper databaseHelper;
  final CurrencyApiService currencyApiService;

  ExpenseRepositoryImpl({
    required this.databaseHelper,
    required this.currencyApiService,
  });

  @override
  Future<List<ExpenseEntity>> getExpenses({
    int? limit = 10,
    int page = 1,
    String? category,
    required FilterByDays filter,
  }) async {
    try {
      final expenseModels = await databaseHelper.getAllExpenses(
        limit: limit,
        page: page,
        category: category,
        filter: filter==FilterByDays.lastMonth?"month":"week",
      );
      return expenseModels.cast<ExpenseEntity>();
    } catch (e) {
      throw Exception('Failed to get expenses: $e');
    }
  }

  @override
  Future<ExpenseEntity?> getExpenseById(int id) async {
    try {
      final expenseModel = await databaseHelper.getExpenseById(id);
      return expenseModel;
    } catch (e) {
      throw Exception('Failed to get expense by id: $e');
    }
  }

  @override
  Future<int> createExpense(ExpenseEntity expense) async {
    try {
      final expenseModel = ExpenseModel.fromEntity(expense);
      return await databaseHelper.insertExpense(expenseModel);
    } catch (e) {
      throw Exception('Failed to create expense: $e');
    }
  }

  @override
  Future<bool> updateExpense(ExpenseEntity expense) async {
    try {
      final expenseModel = ExpenseModel.fromEntity(expense);
      final result = await databaseHelper.updateExpense(expenseModel);
      return result > 0;
    } catch (e) {
      throw Exception('Failed to update expense: $e');
    }
  }

  @override
  Future<bool> deleteExpense(int id) async {
    try {
      final result = await databaseHelper.deleteExpense(id);
      return result > 0;
    } catch (e) {
      throw Exception('Failed to delete expense: $e');
    }
  }

  @override
  Future<double> getTotalExpenses({
    String? category,
  }) async {
    try {
      return await databaseHelper.getTotalExpenses(
        category: category,

      );
    } catch (e) {
      throw Exception('Failed to get total expenses: $e');
    }
  }

  @override
  Future<int> getExpensesCount({
    String? category,
    String? filter, // 'week', 'month', or null
  }) async {
    try {
      return await databaseHelper.getExpensesCount(
        category: category,
        filter: filter,
      );
    } catch (e) {
      throw Exception('Failed to get expenses count: $e');
    }
  }

  @override
  Future<double> convertCurrency(double amount, String fromCurrency, String toCurrency) async {
    try {
      if (fromCurrency.toUpperCase() == toCurrency.toUpperCase()) {
        return amount;
      }

      final response = await currencyApiService.getExchangeRate(fromCurrency, toCurrency);
     double exchangeRate=0.0;
      response.fold(
          (l) => throw Exception("'Failed to convert currency"),
          (r) => exchangeRate=r,
      );
      return amount / exchangeRate; // Fixed: was multiplying by 2
    } catch (e) {
      print(e);
      throw Exception('Failed to convert currency: $e');
    }
  }


}