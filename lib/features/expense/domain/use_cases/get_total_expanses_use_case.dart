import '../repositories/expense_repository.dart';

class GetTotalExpensesUseCase {
  final ExpenseRepository repository;

  GetTotalExpensesUseCase(this.repository);

  Future<double> call(GetTotalExpensesParams params) async {
    return await repository.getTotalExpenses(
      category: params.category,


    );
  }
}

class GetTotalExpensesParams {
  final String? category;

  GetTotalExpensesParams({
    this.category,
  });
}