import '../entities/expense_entity.dart';
import '../repositories/expense_repository.dart';

class AddExpenseUseCase {
  final ExpenseRepository repository;

  AddExpenseUseCase(this.repository);

  Future<int> call(AddExpenseParams params) async {
    // Convert currency to USD if not already
    double convertedAmount = params.amount;
    if (params.currency.toUpperCase() != 'USD') {
      print("dfdfegbrbgrbhrthgtght");
      print(params.amount);
      convertedAmount = await repository.convertCurrency(
        params.amount,
        params.currency,
        'USD',

      );
    }

    final expense = ExpenseEntity(
      category: params.category,
      amount: params.amount,
      currency: params.currency,
      convertedAmount: convertedAmount,
      date: params.date,
      receiptPath: params.receiptPath,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return await repository.createExpense(expense);
  }
}

class AddExpenseParams {
  final String category;
  final double amount;
  final String currency;
  final DateTime date;
  final String? receiptPath;

  AddExpenseParams({
    required this.category,
    required this.amount,
    required this.currency,
    required this.date,
    this.receiptPath,
  });
}
