import 'dart:developer';

import 'package:budget_tracker_app/component/all_category_component.dart';
import 'package:budget_tracker_app/component/all_spendings_component.dart';
import 'package:budget_tracker_app/component/category_component.dart';
import 'package:budget_tracker_app/component/spending_component.dart';
import 'package:budget_tracker_app/controllers/category_controller.dart';
import 'package:budget_tracker_app/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController control = Get.put(NavigationController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        title: Text(
          "Budget Tracker Page",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Color(0xff1937FE).withOpacity(0.45),
      ),
      backgroundColor: Color(0xff1937FE).withOpacity(0.4),
      body: PageView(
        controller: control.pageInx,
        onPageChanged: (value) {
          control.changeNavIndex(value);
        },
        children: [
          AllSpendingsComponent(),
          SpendingComponent(),
          AllCategoryComponent(),
          CategoryComponent(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: control.nsvController.value,
          backgroundColor: Color(0xff1937FE).withOpacity(0.45),
          elevation: 5,
          fixedColor: Colors.white,
          onTap: (value) {
            control.changeNavIndex(value);
            control.changePageIndex(value);
            log('${control.nsvController}');
          },
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14,
          unselectedFontSize: 10,
          unselectedIconTheme: IconThemeData(
            color: Colors.grey,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                // color: Colors.black,
              ),
              label: 'All Spending',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money_rounded), label: 'Spending'),
            BottomNavigationBarItem(
                icon: Icon(Icons.inbox_rounded), label: 'All Category'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_rounded), label: 'Category'),
          ],
        ),
      ),
    );
  }
}
