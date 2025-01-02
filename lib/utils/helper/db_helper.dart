import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  //Creating a Database
  Future<void> initDB() async {
    String dbPath = await getDatabasesPath();
    String path = '${dbPath}budget.db';
    //Open a DataBase
    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        //Creating a table
        String query =
            'CREATE TABLE category(cat_id INTEGER PRIMARY KEY AUTOINCREMENT,cat_name TEXT NOT NULL,cat_image BLOB NOT NULL)';
        await db.execute(query);
      },
    );
  }
}
