import 'package:expenses/features/dashboard/presentation/widgets/filter_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../expense/domain/entities/expense_entity.dart';
import '../../../expense/domain/use_cases/get_expenses_use_case.dart';
import '../../../expense/domain/use_cases/get_total_expanses_use_case.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetExpensesUseCase _getExpensesUseCase;
  final GetTotalExpensesUseCase _getTotalExpensesUseCase;

  DashboardCubit({
    required GetTotalExpensesUseCase getTotalExpensesUseCase,
    required GetExpensesUseCase getExpensesUseCase,
  })  : _getTotalExpensesUseCase = getTotalExpensesUseCase,
        _getExpensesUseCase = getExpensesUseCase,
        super(const DashboardInitial());

  static DashboardCubit get(context) => BlocProvider.of(context);

  // State variables
  double _totalBalance = 0.0;
  List<ExpenseEntity> _expenses = [];
  int _currentPage = 1;
  bool _hasMoreData = true;
  bool _isLoadingMore = false;
  FilterByDays currentFilter=FilterByDays.lastMonth;
  String? _currentCategory;
  static const int _pageSize = 10;


  changeFilterValue(FilterByDays value){
    currentFilter=value;
    emit(CurrentFilterChange());
  }

  // Getters
  double get totalBalance => _totalBalance;
  List<ExpenseEntity> get expenses => _expenses;
  bool get hasMoreData => _hasMoreData;
  bool get isLoadingMore => _isLoadingMore;

  // Main method - loads dashboard data
  Future<void> loadDashboard({String? category, FilterByDays? filter}) async {
    emit(const DashboardLoading());

    try {
      // Reset pagination
      _currentPage = 1;
      _expenses.clear();
      _hasMoreData = true;
      currentFilter = filter??FilterByDays.lastMonth;
      _currentCategory = category;

      // Load total balance
      final total = await _getTotalExpensesUseCase.call(
        GetTotalExpensesParams(category: category),
      );
      _totalBalance = total;

      // Load first page of expenses
      if (filter != null) {
        final expensesList = await _getExpensesUseCase.call(
          GetExpensesParams(
            limit: _pageSize,
            category: category,
            filter: filter,
            page: 1,
          ),
        );
        _expenses = expensesList;
        _hasMoreData = expensesList.length == _pageSize;
      }

      emit(DashboardSuccess(
        totalBalance: _totalBalance,
        expenses: _expenses,
        hasMoreData: _hasMoreData,
      ));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  // Load more expenses for pagination
  Future<void> loadMoreExpenses() async {
    if (_isLoadingMore || !_hasMoreData || currentFilter == null) return;

    _isLoadingMore = true;
    emit(ExpensesLoadingMore(
      totalBalance: _totalBalance,
      expenses: _expenses,
      hasMoreData: _hasMoreData,
    ));

    try {
      final expensesList = await _getExpensesUseCase.call(
        GetExpensesParams(
          limit: _pageSize,
          category: _currentCategory,
          filter: currentFilter,
          page: _currentPage + 1,
        ),
      );

      _expenses.addAll(expensesList);
      _currentPage++;
      _hasMoreData = expensesList.length == _pageSize;
      _isLoadingMore = false;

      emit(DashboardSuccess(
        totalBalance: _totalBalance,
        expenses: _expenses,
        hasMoreData: _hasMoreData,
      ));
    } catch (e) {
      _isLoadingMore = false;
      emit(DashboardError(e.toString()));
    }
  }

  // Filter shortcuts
  Future<void> filterByThisMonth({String? category}) async {
    await loadDashboard(category: category, filter:FilterByDays.lastMonth);
  }

  Future<void> filterByLast7Days({String? category}) async {
    await loadDashboard(category: category, filter: FilterByDays.last7days);
  }

  Future<void> refresh() async {
    await loadDashboard(
      category: _currentCategory,
      filter: currentFilter,
    );
  }
}