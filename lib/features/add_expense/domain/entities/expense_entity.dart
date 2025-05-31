import 'package:equatable/equatable.dart';

class ExpenseEntity extends Equatable {
  final int? id;
  final String category;
  final double amount;
  final String currency;
  final double convertedAmount; // Amount in USD
  final DateTime date;
  final String? receiptPath;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ExpenseEntity({
    this.id,
    required this.category,
    required this.amount,
    required this.currency,
    required this.convertedAmount,
    required this.date,
    this.receiptPath,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    category,
    amount,
    currency,
    convertedAmount,
    date,
    receiptPath,
    createdAt,
    updatedAt,
  ];
}