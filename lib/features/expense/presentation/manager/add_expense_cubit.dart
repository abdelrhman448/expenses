import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../dashboard/domain/entities/expense_model.dart';
import '../../domain/use_cases/add_expense_use_case.dart';

part 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  final AddExpenseUseCase _addExpenseUseCase;

  AddExpenseCubit({required AddExpenseUseCase addExpenseUseCase})
      : _addExpenseUseCase = addExpenseUseCase,
        super(const AddExpenseInitial());

  static AddExpenseCubit get(context) => BlocProvider.of(context);

  // Private fields
  bool _showCategories = false;
  String _selectedCurrency = 'EGP';
  static const List<String> _availableCurrencies = ['EGP','USD',];

  // Getters
  bool get showCategories => _showCategories;
  String get selectedCurrency => _selectedCurrency;
  List<String> get availableCurrencies => _availableCurrencies;

  // Category selection methods
  void toggleCategoryVisibility() {
    _showCategories = !_showCategories;
    emit(CategoryVisibilityChangedState(_showCategories));
  }

  void updateExpenseSelection({
    required List<ExpensesModel> expenses,
    required int selectedIndex,
  }) {
    if (selectedIndex >= 0 && selectedIndex < expenses.length) {
      expenses[selectedIndex].updateExpenseSelection(expenses, selectedIndex);
      emit(const ExpenseSelectionUpdatedState());
    }
  }

  // Currency methods
  void updateCurrency(String currency) {
    if (_availableCurrencies.contains(currency)) {
      _selectedCurrency = currency;
      emit(CurrencyUpdatedState(currency));
    }
  }

  // Main expense adding method
  Future<void> addExpense({
    required String category,
    required double amount,
    required DateTime date,
    String? receiptPath,
  }) async {
    if (category.isEmpty || amount <= 0) {
      emit(const AddExpenseError('Invalid expense data'));
      return;
    }

    emit(const AddExpenseLoading());

    try {
      final params = AddExpenseParams(
        category: category,
        amount: amount,
        currency: _selectedCurrency,
        date: date,
        receiptPath: receiptPath,
      );

      final expenseId = await _addExpenseUseCase.call(params);

      if (expenseId > 0) {
        emit( AddExpenseSuccess());
      } else {
        emit(const AddExpenseError('Failed to save expense'));
      }
    } catch (e) {
      emit(AddExpenseError('Error adding expense: ${e.toString()}'));
    }
  }

  // Reset methods
  void resetState() {
    _selectedCurrency = 'USD';
    _showCategories = false;
    emit(AddExpenseInitial());
  }

  void resetToInitial() {
    resetState();
  }
}