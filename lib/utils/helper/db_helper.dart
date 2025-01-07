import 'dart:developer';

import 'package:budget_tracker_app/model/category_model.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  Database? db;
  String tableName = 'category';
  String categoryName = 'cat_name';
  String categoryImage = 'cat_image';
  String categoryImgIndex = 'cat_img_index';
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
        String query = '''CREATE TABLE $tableName(
                  cat_id INTEGER PRIMARY KEY AUTOINCREMENT,
                  $categoryName TEXT NOT NULL,
                  $categoryImage BLOB NOT NULL,
                  $categoryImgIndex INTEGER
              );''';
        await db.execute(query);
      },
    );
  }

  //Inserting Records
  Future<int?> insertCategories(
      String catyName, Uint8List catyImage, int imageIndex) async {
    await initDB();
    String query =
        "INSERT INTO $tableName($categoryName,$categoryImage,$categoryImgIndex) VALUES(?,?,?);";
    // log('$query');
    return db?.rawInsert(query, [catyName, catyImage, imageIndex]);
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

  // Live Search
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

  //Update Record
  Future<int?> updateRecord(CategoryModel model) async {
    await initDB();

    String query =
        "UPDATE $tableName SET $categoryName=?,$categoryImage=?,$categoryImgIndex=? WHERE cat_id=${model.id}";
    return await db
        ?.rawUpdate(query, [model.name, model.image, model.imageIndex]);
  }

  //Delete Record
  Future<int?> deleteCategory(int id) async {
    await initDB();
    String query = 'DELETE FROM $tableName WHERE cat_id=$id;';
    return await db?.rawDelete(query);
  }
}
