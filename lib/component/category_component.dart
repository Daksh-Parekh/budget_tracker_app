import 'package:budget_tracker_app/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

List<String> categoryImage = [
  'asset/images/deposit.png',
  'asset/images/giftbox.png',
  'asset/images/healthcare.png',
  'asset/images/salary.png',
  'asset/images/video.png',
  'asset/images/wallet.png',
  'asset/images/menu.png',
];
GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController categoryNameController = TextEditingController();

class CategoryComponent extends StatelessWidget {
  const CategoryComponent({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.put(CategoryController());

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categories...",
              style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: categoryNameController,
              validator: (value) =>
                  value!.isEmpty ? "Category is required" : null,
              decoration: InputDecoration(
                labelText: "Category",
                hintText: "Enter your category",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.blueAccent.shade100, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: categoryImage.length,
                itemBuilder: (context, index) => GetBuilder<CategoryController>(
                  builder: (controller) => GestureDetector(
                    onTap: () {
                      categoryController.changeCategoryImageInx(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: categoryController.categoryIndex == index
                                ? Colors.black
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(categoryImage[index]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  if (formKey.currentState!.validate() &&
                      categoryController.categoryIndex != null) {
                    String cateName = categoryNameController.text;
                    String assetPath =
                        categoryImage[categoryController.categoryIndex!];
                    ByteData byteData = await rootBundle.load(assetPath);
                    Uint8List img = byteData.buffer.asUint8List();
                    categoryController.insertCategory(cateName, img);
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please enter category & select image',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                  categoryNameController.clear();
                  categoryController.categoryImageDefaultValue();
                  // categoryController.ass
                },
                label: Text("Add"),
                icon: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
