import 'package:budget_tracker_app/model/category_model.dart';
import 'package:budget_tracker_app/model/spending_model.dart';
import 'package:budget_tracker_app/utils/helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpendingController extends GetxController {
  String? modeSelection;
  DateTime? dateTime;
  int? spendingImgIndex, categoryId;
  Future<List<SpendingModel>>? allSpends;

  void changeMode(String? inx) {
    modeSelection = inx;
    update();
  }

  void changeDate(DateTime? value) {
    dateTime = value;
    update();
  }

  void spendImageIndex({required int index, required int id}) {
    spendingImgIndex = index;
    categoryId = id;
    update();
  }

  Future<void> addSpendingRecord({required SpendingModel model}) async {
    int? res = await DBHelper.dbHelper.insertSpendings(model: model);

    if (res != null) {
      Get.snackbar(
        "INSERTION",
        "spending insert successfully....",
        backgroundColor: Colors.green,
      );
    } else {
      Get.snackbar(
        "FAILED",
        "spending insertion failed....",
        backgroundColor: Colors.red,
      );
    }
  }

  void assignDefaultValue() {
    modeSelection = dateTime = spendingImgIndex = null;
    update();
  }

  void getSpendingRecord() async {
    allSpends = DBHelper.dbHelper.fetchSpendingRecord();
    update();
  }

  Future<CategoryModel> fetchCategory(int id) async {
    return await DBHelper.dbHelper.fetchSingleCategory(id);
  }

  Future<void> deleteSpendRecord(int id) async {
    int? response = await DBHelper.dbHelper.deleteSpendingCategory(id);
    if (response != null) {
      getSpendingRecord();
      Get.snackbar('DELETE', 'Deletion successfull',
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      Get.snackbar('DELETION FAILED', 'Deletion failed',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    update();
  }

  Future<void> updateSpendingRecord(SpendingModel model) async {
    int? res = await DBHelper.dbHelper.updateSpendRecord(model);
    if (res != null) {
      getSpendingRecord();
      Get.snackbar('UPDATE', 'UPDATION was done successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      Get.snackbar('FAILED', 'UPDATION was failed',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    update();
  }
}
