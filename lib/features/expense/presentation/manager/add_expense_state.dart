// add_expense_state.dart
part of 'add_expense_cubit.dart';

abstract class AddExpenseState extends Equatable {
  const AddExpenseState();

  @override
  List<Object?> get props => [];
}

class AddExpenseInitial extends AddExpenseState {
  const AddExpenseInitial();
}

class AddExpenseLoading extends AddExpenseState {
  const AddExpenseLoading();
}

class AddExpenseSuccess extends AddExpenseState {
  const AddExpenseSuccess();
}

class AddExpenseError extends AddExpenseState {
  final String message;

  const AddExpenseError(this.message);

  @override
  List<Object> get props => [message];
}

class ExpenseSelectionUpdatedState extends AddExpenseState {
  const ExpenseSelectionUpdatedState();
}

class CurrencyUpdatedState extends AddExpenseState {
  final String currency;

  const CurrencyUpdatedState(this.currency);

  @override
  List<Object> get props => [currency];
}

class CategoryVisibilityChangedState extends AddExpenseState {
  final bool isVisible;

  const CategoryVisibilityChangedState(this.isVisible);

  @override
  List<Object> get props => [isVisible];
}