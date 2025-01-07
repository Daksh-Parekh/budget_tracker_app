import 'package:budget_tracker_app/component/category_component.dart';
import 'package:budget_tracker_app/controllers/category_controller.dart';
import 'package:budget_tracker_app/model/category_model.dart';
import 'package:budget_tracker_app/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllCategoryComponent extends StatelessWidget {
  const AllCategoryComponent({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.put(CategoryController());
    categoryController.fetchCategoryData();
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
                        CategoryModel data = allCategoryData[index];
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
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    categoryNameController.text =
                                        allCategoryData[index].name!;
                                    categoryController
                                        .categoryImageDefaultValue();
                                    Get.bottomSheet(
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(22),
                                            topLeft: Radius.circular(22),
                                          ),
                                        ),
                                        child: Form(
                                          key: formKey,
                                          child: Column(
                                            children: [
                                              Text(
                                                "UPDATE CATEGORY",
                                                style: TextStyle(
                                                    fontSize: 20.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10.h),
                                              TextFormField(
                                                controller:
                                                    categoryNameController,
                                                validator: (value) =>
                                                    value!.isEmpty
                                                        ? 'Category is required'
                                                        : null,
                                                decoration: InputDecoration(
                                                  // hintText: ,
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Expanded(
                                                child: GridView.builder(
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                  ),
                                                  itemCount:
                                                      categoryImage.length,
                                                  itemBuilder: (context, inx) =>
                                                      GetBuilder<
                                                          CategoryController>(
                                                    builder: (context) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          categoryController
                                                              .changeCategoryImageInx(
                                                                  inx);
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            border: Border.all(
                                                              color: categoryController
                                                                          .categoryIndex !=
                                                                      null
                                                                  ? categoryController
                                                                              .categoryIndex ==
                                                                          inx
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .transparent
                                                                  : inx ==
                                                                          data
                                                                              .imageIndex
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .transparent,
                                                            ),
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                categoryImage[
                                                                    inx],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              FloatingActionButton.extended(
                                                onPressed: () async {
                                                  if (formKey.currentState!
                                                          .validate() &&
                                                      categoryController
                                                              .categoryIndex !=
                                                          null) {
                                                    String name =
                                                        categoryNameController
                                                            .text;
                                                    String assetPath =
                                                        categoryImage[
                                                            categoryController
                                                                .categoryIndex!];
                                                    ByteData byteData =
                                                        await rootBundle
                                                            .load(assetPath);
                                                    Uint8List img = byteData
                                                        .buffer
                                                        .asUint8List();
                                                    CategoryModel model =
                                                        CategoryModel(
                                                            id: allCategoryData[
                                                                    index]
                                                                .id,
                                                            name: name,
                                                            image: img,
                                                            imageIndex:
                                                                categoryController
                                                                    .categoryIndex!);
                                                    categoryController
                                                        .updateCategory(model);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                label: const Text(
                                                  "Update Category",
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    categoryController.deleteRecord(
                                        allCategoryData[index].id!);
                                  },
                                  icon: Icon(Icons.delete_rounded),
                                ),
                              ],
                            ),
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
