import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../features/expense/data/models/expense_model.dart';

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
    int? limit = 10,
    int page = 1,
    String? category,
    String? filter, // 'week', 'month', or null
  }) async {
    final db = await database;
    String whereClause = '';
    List<dynamic> whereArgs = [];

    // Category filter
    if (category != null) {
      whereClause += 'category = ?';
      whereArgs.add(category);
    }

    // Date filters
    if (filter == 'week') {
      if (whereClause.isNotEmpty) whereClause += ' AND ';
      DateTime weekAgo = DateTime.now().subtract(Duration(days: 7));
      String weekAgoStr = weekAgo.toIso8601String().split(
          'T')[0]; // Gets YYYY-MM-DD
      whereClause += 'date >= ?';
      whereArgs.add(weekAgoStr);
    }

    if (filter == 'month') {
      if (whereClause.isNotEmpty) whereClause += ' AND ';
      DateTime now = DateTime.now();
      String currentMonth = '${now.year}-${now.month.toString().padLeft(
          2, '0')}';
      whereClause += 'date LIKE ?';
      whereArgs.add('$currentMonth%');
    }

    // Calculate offset for pagination
    int offset = (page - 1) * (limit ?? 10);

    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      where: whereClause.isEmpty ? null : whereClause,
      whereArgs: whereArgs.isEmpty ? null : whereArgs,
      orderBy: 'created_at DESC',
      limit: limit,
      offset: offset,
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
      'SELECT SUM(converted_amount) as total FROM expenses${whereClause.isEmpty
          ? ''
          : ' WHERE $whereClause'}',
      whereArgs.isEmpty ? null : whereArgs,
    );

    return (result.first['total'] as num?)?.toDouble() ?? 0.0;
  }

  Future<int> getExpensesCount({
    String? category,
    String? filter, // 'week', 'month', or null
  }) async {
    final db = await database;
    String whereClause = '';
    List<dynamic> whereArgs = [];

    // Category filter
    if (category != null) {
      whereClause += 'category = ?';
      whereArgs.add(category);
    }

    // Date filters (same logic as getAllExpenses)
    if (filter == 'week') {
      if (whereClause.isNotEmpty) whereClause += ' AND ';
      DateTime weekAgo = DateTime.now().subtract(Duration(days: 7));
      String weekAgoStr = weekAgo.toIso8601String().split('T')[0];
      whereClause += 'date >= ?';
      whereArgs.add(weekAgoStr);
    }

    if (filter == 'month') {
      if (whereClause.isNotEmpty) whereClause += ' AND ';
      DateTime now = DateTime.now();
      String currentMonth = '${now.year}-${now.month.toString().padLeft(2, '0')}';
      whereClause += 'date LIKE ?';
      whereArgs.add('$currentMonth%');
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