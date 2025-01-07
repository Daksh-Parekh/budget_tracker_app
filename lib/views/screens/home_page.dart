import 'dart:developer';

import 'package:budget_tracker_app/component/all_category_component.dart';
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
        title: Text("Budget Tracker Page"),
      ),
      body: PageView(
        controller: control.pageInx,
        onPageChanged: (value) {
          control.changeNavIndex(value);
        },
        children: [
          Center(
            child: Text("All Spendings"),
          ),
          SpendingComponent(),
          AllCategoryComponent(),
          CategoryComponent(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: control.nsvController.value,
          onDestinationSelected: (value) {
            control.changeNavIndex(value);
            control.changePageIndex(value);
            log('${control.nsvController}');
          },
          destinations: [
            NavigationDestination(
                icon: Icon(Icons.attach_money_rounded), label: 'All Spending'),
            NavigationDestination(
                icon: Icon(Icons.currency_rupee), label: 'Spending'),
            NavigationDestination(
                icon: Icon(Icons.inbox_rounded), label: 'All Category'),
            NavigationDestination(
                icon: Icon(Icons.category_rounded), label: 'Category'),
          ],
        ),
      ),
    );
  }
}
