// lib/core/di/dependency_injection.dart
import 'package:get_it/get_it.dart';
import '../../features/expense/data/data_sources/add_expense_data_source.dart';
import '../../features/expense/data/repositories/expense_repository_implementer.dart';
import '../../features/expense/domain/repositories/expense_repository.dart';
import '../../features/expense/domain/use_cases/add_expense_use_case.dart';
import '../../features/expense/domain/use_cases/delete_expense_use_case.dart';
import '../../features/expense/domain/use_cases/get_expenses_use_case.dart';
import '../../features/expense/domain/use_cases/get_total_expanses_use_case.dart';
import '../../features/expense/domain/use_cases/update_expense_use_case.dart';
import '../../features/expense/presentation/manager/add_expense_cubit.dart';
import '../database/database_helper.dart';
import '../dio_helper/dio_helper.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
 // Core
 getIt.registerLazySingleton<DioHelper>(() => DioHelper());
 getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

 // Data sources
 getIt.registerLazySingleton<CurrencyApiService>(
      () => CurrencyApiServiceImpl(dioHelper: getIt<DioHelper>()),
 );

 // Repositories
 getIt.registerLazySingleton<ExpenseRepository>(
      () => ExpenseRepositoryImpl(
   databaseHelper: getIt<DatabaseHelper>(),
   currencyApiService: getIt<CurrencyApiService>(),
  ),
 );

 // Use cases
 getIt.registerLazySingleton(() => AddExpenseUseCase(getIt<ExpenseRepository>()));
 getIt.registerLazySingleton(() => GetExpensesUseCase(getIt<ExpenseRepository>()));
 getIt.registerLazySingleton(() => GetTotalExpensesUseCase(getIt<ExpenseRepository>()));
 getIt.registerLazySingleton(() => DeleteExpenseUseCase(getIt<ExpenseRepository>()));
 getIt.registerLazySingleton(() => UpdateExpenseUseCase(getIt<ExpenseRepository>()));

 // BLoC/Cubits
 getIt.registerFactory(() => AddExpenseCubit(addExpenseUseCase: getIt<AddExpenseUseCase>()));
}