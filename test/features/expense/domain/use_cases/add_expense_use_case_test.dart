import 'package:expenses/features/expense/domain/entities/expense_entity.dart';
import 'package:expenses/features/expense/domain/repositories/expense_repository.dart';
import 'package:expenses/features/expense/domain/use_cases/add_expense_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Create mock class extending Mock
class MockExpenseRepository extends Mock implements ExpenseRepository {}
class FakeExpenseEntity extends Fake implements ExpenseEntity {}


void main() {
  late AddExpenseUseCase useCase;
  late MockExpenseRepository mockRepository;
  setUpAll(() {
    registerFallbackValue(FakeExpenseEntity());
  });

  setUp(() {
    mockRepository = MockExpenseRepository();
    useCase = AddExpenseUseCase(mockRepository);
  });

  group('AddExpenseUseCase', () {
    final testParams = AddExpenseParams(
      category: 'Food',
      amount: 25.50,
      currency: 'USD',
      date: DateTime(2024, 1, 15),
      receiptPath: null,
    );

    test('should add expense successfully when currency is USD', () async {
      // arrange
      const expectedId = 1;
      when(() => mockRepository.createExpense(any())).thenAnswer((_) async => expectedId);

      // act
      final result = await useCase.call(testParams);

      // assert
      expect(result, expectedId);
      verify(() => mockRepository.createExpense(any())).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should convert currency and add expense when currency is not USD', () async {
      // arrange
      const expectedId = 1;
      const conversionRate = 0.85;
      final paramsWithEUR = AddExpenseParams(
        category: 'Food',
        amount: 30.0,
        currency: 'EUR',
        date: DateTime(2024, 1, 15),
      );

      when(() => mockRepository.convertCurrency(30.0, 'EUR', 'USD'))
          .thenAnswer((_) async => 30.0 * conversionRate);
      when(() => mockRepository.createExpense(any())).thenAnswer((_) async => expectedId);

      // act
      final result = await useCase.call(paramsWithEUR);

      // assert
      expect(result, expectedId);
      verify(() => mockRepository.convertCurrency(30.0, 'EUR', 'USD')).called(1);
      verify(() => mockRepository.createExpense(any())).called(1);
    });

    test('should throw exception when repository throws exception', () async {
      // arrange
      when(() => mockRepository.createExpense(any()))
          .thenThrow(Exception('Database error'));

      // act & assert
      expect(
            () async => await useCase.call(testParams),
        throwsA(isA<Exception>()),
      );
    });
  });
}