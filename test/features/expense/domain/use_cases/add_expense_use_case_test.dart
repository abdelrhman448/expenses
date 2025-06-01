import 'package:expenses/features/expense/domain/entities/expense_entity.dart';
import 'package:expenses/features/expense/domain/repositories/expense_repository.dart';
import 'package:expenses/features/expense/domain/use_cases/add_expense_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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
    final testDate = DateTime(2024, 1, 15);

    test('should add expense successfully when currency is USD (no conversion needed)', () async {
      // arrange
      const expectedId = 1;
      final testParams = AddExpenseParams(
        category: 'Food',
        amount: 25.50,
        currency: 'USD',
        date: testDate,
        receiptPath: null,
      );

      when(() => mockRepository.createExpense(any())).thenAnswer((_) async => expectedId);

      // act
      final result = await useCase.call(testParams);

      // assert
      expect(result, expectedId);

      final captured = verify(() => mockRepository.createExpense(captureAny())).captured;
      final expenseEntity = captured.first as ExpenseEntity;

      expect(expenseEntity.category, 'Food');
      expect(expenseEntity.amount, 25.50);
      expect(expenseEntity.currency, 'USD');
      expect(expenseEntity.convertedAmount, 25.50); // Same as amount since no conversion
      expect(expenseEntity.date, testDate);
      expect(expenseEntity.receiptPath, null);

      // Verify no currency conversion was called for USD
      verifyNever(() => mockRepository.convertCurrency(any(), any()));
      verifyNoMoreInteractions(mockRepository);
    });


    test('should convert currency and add expense when currency is EGP', () async {
      // arrange
      const expectedId = 3;
      const convertedAmount = 1.63; // EGP to USD conversion result (30 EGP ≈ 1.63 USD)

      final testParams = AddExpenseParams(
        category: 'Shopping',
        amount: 30.0,
        currency: 'EGP',
        date: testDate,
        receiptPath: null,
      );

      when(() => mockRepository.convertCurrency(30.0, 'EGP'))
          .thenAnswer((_) async => convertedAmount);
      when(() => mockRepository.createExpense(any())).thenAnswer((_) async => expectedId);

      // act
      final result = await useCase.call(testParams);

      // assert
      expect(result, expectedId);

      // Verify currency conversion was called
      verify(() => mockRepository.convertCurrency(30.0, 'EGP')).called(1);

      // Verify createExpense was called with converted amount
      final captured = verify(() => mockRepository.createExpense(captureAny())).captured;
      final expenseEntity = captured.first as ExpenseEntity;

      expect(expenseEntity.category, 'Shopping');
      expect(expenseEntity.amount, 30.0); // Original amount in EGP
      expect(expenseEntity.currency, 'EGP'); // Original currency
      expect(expenseEntity.convertedAmount, convertedAmount); // Converted to USD
      expect(expenseEntity.date, testDate);

      verifyNoMoreInteractions(mockRepository);
    });

    test('should handle EGP currency case insensitively', () async {
      // arrange
      const expectedId = 4;
      const convertedAmount = 2.17; // EGP to USD conversion result

      final testParams = AddExpenseParams(
        category: 'Entertainment',
        amount: 40.0,
        currency: 'egp', // lowercase
        date: testDate,
        receiptPath: '/path/to/ticket.pdf',
      );

      when(() => mockRepository.convertCurrency(40.0, 'egp'))
          .thenAnswer((_) async => convertedAmount);
      when(() => mockRepository.createExpense(any())).thenAnswer((_) async => expectedId);

      // act
      final result = await useCase.call(testParams);

      // assert
      expect(result, expectedId);
      verify(() => mockRepository.convertCurrency(40.0, 'egp')).called(1);

      final captured = verify(() => mockRepository.createExpense(captureAny())).captured;
      final expenseEntity = captured.first as ExpenseEntity;
      expect(expenseEntity.convertedAmount, convertedAmount);

      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw exception when EGP currency conversion fails', () async {
      // arrange
      final testParams = AddExpenseParams(
        category: 'Food',
        amount: 50.0,
        currency: 'EGP',
        date: testDate,
        receiptPath: null,
      );

      when(() => mockRepository.convertCurrency(50.0, 'EGP'))
          .thenThrow(Exception('Currency conversion failed'));

      // act & assert
      expect(
            () async => await useCase.call(testParams),
        throwsA(isA<Exception>()),
      );

      verify(() => mockRepository.convertCurrency(50.0, 'EGP')).called(1);
      // createExpense should not be called if conversion fails
      verifyNever(() => mockRepository.createExpense(any()));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw exception when repository createExpense fails', () async {
      // arrange
      final testParams = AddExpenseParams(
        category: 'Food',
        amount: 25.50,
        currency: 'USD',
        date: testDate,
        receiptPath: null,
      );

      when(() => mockRepository.createExpense(any()))
          .thenThrow(Exception('Database error'));

      // act & assert
      expect(
            () async => await useCase.call(testParams),
        throwsA(isA<Exception>()),
      );

      verify(() => mockRepository.createExpense(any())).called(1);
      verifyNoMoreInteractions(mockRepository);
    });


    test('should preserve all expense data including receipt path for non-EGP currency', () async {
      // arrange
      const expectedId = 5;
      const receiptPath = '/storage/receipts/receipt_123.jpg';

      final testParams = AddExpenseParams(
        category: 'Business',
        amount: 100.0,
        currency: 'GBP', // Non-EGP currency
        date: testDate,
        receiptPath: receiptPath,
      );

      when(() => mockRepository.createExpense(any())).thenAnswer((_) async => expectedId);

      // act
      final result = await useCase.call(testParams);

      // assert
      expect(result, expectedId);

      final captured = verify(() => mockRepository.createExpense(captureAny())).captured;
      final expenseEntity = captured.first as ExpenseEntity;

      expect(expenseEntity.category, 'Business');
      expect(expenseEntity.amount, 100.0);
      expect(expenseEntity.currency, 'GBP');
      expect(expenseEntity.convertedAmount, 100.0); // Same as amount, no conversion
      expect(expenseEntity.date, testDate);
      expect(expenseEntity.receiptPath, receiptPath);
      expect(expenseEntity.createdAt, isA<DateTime>());
      expect(expenseEntity.updatedAt, isA<DateTime>());

      // No conversion should happen for GBP
      verifyNever(() => mockRepository.convertCurrency(any(), any()));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}