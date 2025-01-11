import 'package:budget_tracker_app/controllers/category_controller.dart';
import 'package:budget_tracker_app/controllers/spending_controller.dart';
import 'package:budget_tracker_app/model/category_model.dart';
import 'package:budget_tracker_app/model/spending_model.dart';
import 'package:budget_tracker_app/utils/extensions/my_extension.dart';
import 'package:budget_tracker_app/utils/helper/db_helper.dart';
import 'package:budget_tracker_app/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

TextEditingController descController = TextEditingController();
TextEditingController amountController = TextEditingController();

GlobalKey<FormState> spendFormKey = GlobalKey<FormState>();

class SpendingComponent extends StatelessWidget {
  const SpendingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    SpendingController controllers = Get.put(SpendingController());
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GetBuilder<SpendingController>(
        builder: (ctx) {
          return SingleChildScrollView(
            child: Form(
              key: spendFormKey,
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.6,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          color: Color.fromARGB(255, 157, 169, 253)
                              .withOpacity(0.5),
                          offset: Offset(7, 7),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: descController,
                          maxLines: 2,
                          validator: (value) =>
                              value!.isEmpty ? "Description is required" : null,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Enter description',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        8.he,
                        TextFormField(
                          controller: amountController,
                          validator: (value) =>
                              value!.isEmpty ? "Amount is required" : null,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Amount',
                            hintText: 'Enter amount',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        6.he,
                        Row(
                          children: [
                            10.wi,
                            Text(
                              "Mode",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            10.wi,
                            DropdownButton(
                              value: controllers.modeSelection,
                              hint: Text("Select"),
                              items: [
                                DropdownMenuItem(
                                  value: "online",
                                  child: Text("Online"),
                                ),
                                DropdownMenuItem(
                                  value: "offline",
                                  child: Text("Offline"),
                                ),
                              ],
                              onChanged: controllers.changeMode,
                            ),
                          ],
                        ),
                        // 2.he,
                        Row(
                          children: [
                            12.wi,
                            Text(
                              "Date",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            10.wi,
                            IconButton(
                              onPressed: () async {
                                DateTime? date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2027),
                                );

                                if (date != null) {
                                  controllers.changeDate(date);
                                }
                              },
                              icon: Icon(Icons.calendar_month_rounded),
                            ),
                            if (controllers.dateTime != null)
                              Text(
                                  "${controllers.dateTime?.day}/${controllers.dateTime?.month}/${controllers.dateTime?.year}")
                            else
                              Text("DD/MM/YYYY"),
                          ],
                        ),
                        1.he,
                        SizedBox(
                          height: size.height * 0.2,
                          child: FutureBuilder(
                            future: DBHelper.dbHelper.fetchCategory(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<CategoryModel> category =
                                    snapshot.data ?? [];

                                return GridView.builder(
                                  itemCount: category.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4),
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      controllers.spendImageIndex(
                                        id: category[index].id!,
                                        index: index,
                                      );
                                    },
                                    child: Container(
                                      height: size.height * 0.06,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: index ==
                                                    controllers.spendingImgIndex
                                                ? Colors.black
                                                : Colors.transparent),
                                        image: DecorationImage(
                                            image: MemoryImage(
                                              category[index].image!,
                                            ),
                                            fit: BoxFit.scaleDown),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.037,
                  ),
                  FloatingActionButton.extended(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (spendFormKey.currentState?.validate() != null &&
                          controllers.modeSelection != null &&
                          controllers.dateTime != null &&
                          controllers.spendingImgIndex != null) {
                        controllers.addSpendingRecord(
                          model: SpendingModel(
                            id: 0,
                            desc: descController.text,
                            amount: num.parse(amountController.text),
                            mode: controllers.modeSelection!,
                            date:
                                "${controllers.dateTime?.day}/${controllers.dateTime?.month}/${controllers.dateTime?.year}",
                            categoryId: controllers.categoryId!,
                          ),
                        );
                      } else {
                        Get.snackbar(
                          'FAILED',
                          'ALL Information required...',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }

                      descController.clear();
                      amountController.clear();
                      controllers.assignDefaultValue();
                    },
                    label: Text("Add Spends"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
