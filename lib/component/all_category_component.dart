import 'package:budget_tracker_app/component/category_component.dart';
import 'package:budget_tracker_app/controllers/category_controller.dart';
import 'package:budget_tracker_app/model/category_model.dart';
import 'package:budget_tracker_app/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllCategoryComponent extends StatelessWidget {
  const AllCategoryComponent({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.put(CategoryController());
    // categoryController.fetchCategoryData();
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter category to Search",
              suffixIcon: Icon(Icons.search_rounded),
            ),
            onChanged: (value) {
              categoryController.searchedCategoryData(value);
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: GetBuilder<CategoryController>(builder: (context) {
              return FutureBuilder(
                future: categoryController.allCategory,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error"),
                    );
                  } else if (snapshot.hasData) {
                    List<CategoryModel> allCategoryData = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: allCategoryData.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              foregroundImage: MemoryImage(
                                allCategoryData[index].image!,
                                scale: 0.5,
                              ),
                            ),
                            title: Text("${allCategoryData[index].name}"),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
