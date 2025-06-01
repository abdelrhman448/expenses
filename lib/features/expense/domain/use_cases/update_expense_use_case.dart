
import '../entities/expense_entity.dart';
import '../repositories/expense_repository.dart';

class UpdateExpenseUseCase {
  final ExpenseRepository repository;

  UpdateExpenseUseCase(this.repository);

  Future<bool> call(UpdateExpenseParams params) async {
    // Convert currency to USD if not already
    double convertedAmount = params.amount;
    if (params.currency.toUpperCase() != 'USD') {
      convertedAmount = await repository.convertCurrency(
        params.amount,
        params.currency,

      );
    }

    final expense = ExpenseEntity(
      id: params.id,
      category: params.category,
      amount: params.amount,
      currency: params.currency,
      convertedAmount: convertedAmount,
      date: params.date,
      receiptPath: params.receiptPath,
      createdAt: params.createdAt,
      updatedAt: DateTime.now(),
    );

    return await repository.updateExpense(expense);
  }
}

class UpdateExpenseParams {
  final int id;
  final String category;
  final double amount;
  final String currency;
  final DateTime date;
  final String? receiptPath;
  final DateTime createdAt;

  UpdateExpenseParams({
    required this.id,
    required this.category,
    required this.amount,
    required this.currency,
    required this.date,
    this.receiptPath,
    required this.createdAt,
  });
}