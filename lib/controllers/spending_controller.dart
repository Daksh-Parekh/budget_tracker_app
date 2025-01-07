import 'package:budget_tracker_app/model/spending_model.dart';
import 'package:budget_tracker_app/utils/helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpendingController extends GetxController {
  String? modeSelection;
  DateTime? dateTime;
  int? spendingImgIndex, categoryId;

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
}
