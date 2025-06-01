
import 'package:expenses/features/dashboard/presentation/widgets/filter_widget.dart';

import '../entities/expense_entity.dart';
import '../repositories/expense_repository.dart';

class GetExpensesUseCase {
  final ExpenseRepository repository;

  GetExpensesUseCase(this.repository);

  Future<List<ExpenseEntity>> call(GetExpensesParams params) async {
    return await repository.getExpenses(
      limit: params.limit,
      category: params.category,
      filter: params.filter,
      page: params.page
    );
  }
}
class GetExpensesParams {
  final int? limit;
  final String? category;
  final FilterByDays filter;
  final int page;

  GetExpensesParams({
    this.limit,
    this.category,
    this.filter=FilterByDays.lastMonth,
    this.page=1

  });
}