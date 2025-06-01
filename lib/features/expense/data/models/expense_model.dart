
import '../../domain/entities/expense_entity.dart';

class ExpenseModel extends ExpenseEntity {
  const ExpenseModel({
    super.id,
    required super.category,
    required super.amount,
    required super.currency,
    required super.convertedAmount,
    required super.date,
    super.receiptPath,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as int?,
      category: json['category'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      convertedAmount: (json['converted_amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      receiptPath: json['receipt_path'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'currency': currency,
      'converted_amount': convertedAmount,
      'date': date.toIso8601String(),
      'receipt_path': receiptPath,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as int?,
      category: map['category'] as String,
      amount: (map['amount'] as num).toDouble(),
      currency: map['currency'] as String,
      convertedAmount: (map['converted_amount'] as num).toDouble(),
      date: DateTime.parse(map['date'] as String),
      receiptPath: map['receipt_path'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'currency': currency,
      'converted_amount': convertedAmount,
      'date': date.toIso8601String(),
      'receipt_path': receiptPath,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory ExpenseModel.fromEntity(ExpenseEntity expense) {
    return ExpenseModel(
      id: expense.id,
      category: expense.category,
      amount: expense.amount,
      currency: expense.currency,
      convertedAmount: expense.convertedAmount,
      date: expense.date,
      receiptPath: expense.receiptPath,
      createdAt: expense.createdAt,
      updatedAt: expense.updatedAt,
    );
  }
}