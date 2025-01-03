import 'dart:developer';

import 'package:budget_tracker_app/model/category_model.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  Database? db;
  String tableName = 'category';

  //Creating a Database
  Future<void> initDB() async {
    String dbPath = await getDatabasesPath();
    String path = '${dbPath}budget.db';
    //Open a DataBase
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        //Creating a table
        String query =
            'CREATE TABLE $tableName(cat_id INTEGER PRIMARY KEY AUTOINCREMENT,cat_name TEXT NOT NULL,cat_image BLOB NOT NULL)';
        await db.execute(query);
      },
    );
  }

  //Inserting Records
  Future<int?> insertCategories(
      String categoryName, Uint8List categoryImage) async {
    await initDB();
    String query = "INSERT INTO $tableName(cat_name,cat_image) VALUES(?,?);";
    // log('$query');
    return db?.rawInsert(query, [categoryName, categoryImage]);
  }

  //Fetch Records
  Future<List<CategoryModel>> fetchCategory() async {
    await initDB();
    String query = "SELECT * FROM $tableName;";
    List<Map<String, dynamic>> fetchedCategory =
        await db?.rawQuery(query) ?? [];
    return fetchedCategory
        .map(
          (e) => CategoryModel.fromMap(e),
        )
        .toList();
  }

  Future<List<CategoryModel>> liveSearchCategory(String search) async {
    await initDB();

    String query = "SELECT * FROM $tableName WHERE cat_name LIKE '%$search%'; ";
    List<Map<String, dynamic>> searchedCategory =
        await db?.rawQuery(query) ?? [];

    return searchedCategory
        .map(
          (e) => CategoryModel.fromMap(e),
        )
        .toList();
  }
}
