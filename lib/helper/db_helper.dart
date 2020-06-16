import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  //Opening the data base if there is or creates the database
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, "spaces.db"),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_spaces(id TEXT PRIMARY KEY, title Text, img Text, loc_lat REAL, loc_long REAL, address TEXT)',
        );
      },
      version: 1,
    );
  }

  // Insert data into the table of the database
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  //Get data from the table of the database
  static Future<List<Map<String, dynamic>>> getdata(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
