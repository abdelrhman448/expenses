part of 'dashboard_cubit.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class CurrentFilterChange extends DashboardState {
  const CurrentFilterChange();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardSuccess extends DashboardState {
  final double totalBalance;
  final List<ExpenseEntity> expenses;
  final bool hasMoreData;

  const DashboardSuccess({
    required this.totalBalance,
    required this.expenses,
    required this.hasMoreData,
  });

  @override
  List<Object> get props => [totalBalance, expenses, hasMoreData];
}

class ExpensesLoadingMore extends DashboardState {
  final double totalBalance;
  final List<ExpenseEntity> expenses;
  final bool hasMoreData;

  const ExpensesLoadingMore({
    required this.totalBalance,
    required this.expenses,
    required this.hasMoreData,
  });

  @override
  List<Object> get props => [totalBalance, expenses, hasMoreData];
}

class DashboardError extends DashboardState {
  final String error;

  const DashboardError(this.error);

  @override
  List<Object> get props => [error];
}