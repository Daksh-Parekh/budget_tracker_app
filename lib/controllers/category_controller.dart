import 'package:get/get.dart';

class CategoryController extends GetxController {
  int? categoryIndex;
  void changeCategoryImageInx(int inx) {
    categoryIndex = inx;
    update();
  }

  void categoryImageDefaultValue() {
    categoryIndex = null;
    update();
  }
}
