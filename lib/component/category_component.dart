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
    CategoryController categoriesController = Get.put(CategoryController());
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categories...",
              style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 12),
            Container(
              height: size.height * 0.08,
              padding:
                  EdgeInsets.only(left: 30, right: 16, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextFormField(
                controller: categoryNameController,
                style: TextStyle(fontSize: 18),
                validator: (value) =>
                    value!.isEmpty ? "Category is required" : null,
                decoration: InputDecoration(
                  constraints: BoxConstraints.expand(height: 50),
                  border: InputBorder.none,
                  hintText: "Enter your category",
                  hintStyle: TextStyle(fontSize: 18),
                  // contentPadding: EdgeInsets.only(top: 10),
                ),
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 5,
                ),
                itemCount: categoryImage.length,
                itemBuilder: (context, index) => GetBuilder<CategoryController>(
                  builder: (controller) => GestureDetector(
                    onTap: () {
                      categoriesController.changeCategoryImageInx(index);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: categoriesController.categoryIndex == index
                                ? Colors.white
                                : Colors.transparent,
                            width: 2),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(categoryImage[index]),
                          fit: BoxFit.scaleDown,
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
                      categoriesController.categoryIndex != null) {
                    String cateName = categoryNameController.text;
                    String assetPath =
                        categoryImage[categoriesController.categoryIndex!];
                    ByteData byteData = await rootBundle.load(assetPath);
                    Uint8List img = byteData.buffer.asUint8List();
                    categoriesController.insertCategory(
                      cateName,
                      img,
                    );
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please enter category & select image',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                  categoryNameController.clear();
                  categoriesController.categoryImageDefaultValue();
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
