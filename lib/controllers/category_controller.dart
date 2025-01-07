import 'package:budget_tracker_app/model/category_model.dart';
import 'package:budget_tracker_app/utils/helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  int? categoryIndex;
  Future<List<CategoryModel>>? allCategory;
  // CategoryController() {
  //   fetchCategoryData();
  // }

  void changeCategoryImageInx(int inx) {
    categoryIndex = inx;
    update();
  }

  void categoryImageDefaultValue() {
    categoryIndex = null;
    update();
  }

  Future<void> insertCategory(String cateName, Uint8List img) async {
    int? response =
        await DBHelper.dbHelper.insertCategories(cateName, img, categoryIndex!);
    if (response != null) {
      Get.snackbar('Insert', 'Record has inserted',
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar('Failed', 'Record has not inserted',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void fetchCategoryData() {
    allCategory = DBHelper.dbHelper.fetchCategory();
    // update();
  }

  void searchedCategoryData(String search) {
    allCategory = DBHelper.dbHelper.liveSearchCategory(search);
    update();
  }

  Future<void> updateCategory(CategoryModel model) async {
    int? res = await DBHelper.dbHelper.updateRecord(model);
    if (res != null) {
      fetchCategoryData();
      Get.snackbar('UPDATE', 'UPDATION was done successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      Get.snackbar('FAILED', 'UPDATION was failed',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    update();
  }

  Future<void> deleteRecord(int id) async {
    int? response = await DBHelper.dbHelper.deleteCategory(id);
    if (response != null) {
      fetchCategoryData();
      Get.snackbar('DELETE', 'Deletion successfull',
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      Get.snackbar('DELETION FAILED', 'Deletion failed',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    update();
  }
}
