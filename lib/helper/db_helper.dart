
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {

  static Database? _database;

  // Singleton pattern to ensure only one instance of the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  _initDatabase() async {

    String path = join(await getDatabasesPath(), 'employee.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Create the employee table with auto-increment primary key
        return db.execute(
          '''
          CREATE TABLE employee(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            role TEXT,
            fromDate TEXT,
            toDate TEXT
          )
          ''',
        );
      },
    );
  }

  // Insert an employee record
  Future<int> insertEmployee(Map<String, dynamic> employee) async {
    Database db = await database;
    return await db.insert('employee', employee);
  }

  // Retrieve all employee records
  Future<List<Map<String, dynamic>>> getEmployees() async {
    Database db = await database;
    return await db.query('employee');
  }
  Future<int> deleteEmployee(int id) async {
    Database db = await database;
    return await db.delete(
      'employee',
      where: 'id = ?',
      whereArgs: [id],
    );

}


  Future<int> updateEmployee(int id,Map<String, dynamic> employee) async {
    Database db = await database;
    return await db.update(
      'employee',
      employee,
      where: 'id = ?',
      whereArgs: [id],
    );

  }
}
