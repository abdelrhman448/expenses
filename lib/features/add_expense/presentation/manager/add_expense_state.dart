part of 'add_expense_cubit.dart';

sealed class AddExpenseState {}
final class AddExpenseInitial extends AddExpenseState {}
final class UpdateSelectCategoryState extends AddExpenseState {}
