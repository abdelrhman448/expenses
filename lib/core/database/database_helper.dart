import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../features/add_expense/data/models/expense_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    _instance ??= DatabaseHelper._internal();
    return _instance!;
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'expenses.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT NOT NULL,
        amount REAL NOT NULL,
        currency TEXT NOT NULL,
        converted_amount REAL NOT NULL,
        date TEXT NOT NULL,
        receipt_path TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertExpense(ExpenseModel expense) async {
    final db = await database;
    final expenseMap = expense.toMap();
    expenseMap.remove('id'); // Remove id for insert
    return await db.insert('expenses', expenseMap);
  }

  Future<List<ExpenseModel>> getAllExpenses({
    int? limit,
    String? category,
  }) async {
    final db = await database;
    String whereClause = '';
    List<dynamic> whereArgs = [];
    if (category != null) {
      whereClause += 'category = ?';
      whereArgs.add(category);
    }
    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      where: whereClause.isEmpty ? null : whereClause,
      whereArgs: whereArgs.isEmpty ? null : whereArgs,
      orderBy: 'created_at DESC',
      limit: limit,
    );
    return List.generate(maps.length, (i) => ExpenseModel.fromMap(maps[i]));
  }

  Future<ExpenseModel?> getExpenseById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ExpenseModel.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateExpense(ExpenseModel expense) async {
    final db = await database;
    return await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<int> deleteExpense(int id) async {
    final db = await database;
    return await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<double> getTotalExpenses({
    String? category,
  }) async {
    final db = await database;

    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (category != null) {
      whereClause += 'category = ?';
      whereArgs.add(category);
    }

    final result = await db.rawQuery(
      'SELECT SUM(converted_amount) as total FROM expenses${whereClause.isEmpty ? '' : ' WHERE $whereClause'}',
      whereArgs.isEmpty ? null : whereArgs,
    );

    return (result.first['total'] as num?)?.toDouble() ?? 0.0;
  }

  Future<int> getExpensesCount({
    String? category,
  }) async {
    final db = await database;

    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (category != null) {
      whereClause += 'category = ?';
      whereArgs.add(category);
    }

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM expenses${whereClause.isEmpty ? '' : ' WHERE $whereClause'}',
      whereArgs.isEmpty ? null : whereArgs,
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('expenses');
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}