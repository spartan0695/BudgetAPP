import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transactions.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB("budget_db.db");
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE transactions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            amount REAL,
            category TEXT,
            tags TEXT,
            isEntry INTEGER,
            date TEXT,
            note TEXT,
            isRecurring INTEGER,
            recurringFrequency TEXT,
            recurringStart TEXT,
            recurringEnd TEXT,
            recurringCount INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertTransaction(Transactions trx) async {
    final db = await database;
    return await db.insert('transactions', trx.toMap());
  }

  Future<int> deleteTransaction(int id) async {
    final db = await database;
    return await db.delete(
                            'transactions',
                            where: 'id = ?',
                            whereArgs: [id]);
  }


  Future<List<Transactions>> getAllTransactions() async {
    final db = await database;
    final maps = await db.query('transactions', orderBy: 'date DESC');
    return List.generate(maps.length, (i) => Transactions.fromMap(maps[i]));
  }

  // ... Aggiungi update e delete se ti servono
}

