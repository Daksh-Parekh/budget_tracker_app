import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt nsvController = 0.obs;
  PageController pageInx = PageController(initialPage: 0);
  void changeNavIndex(int index) {
    nsvController.value = index;
  }

  void changePageIndex(int inx) {
    pageInx.animateToPage(inx,
        duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
    update();
  }
}
