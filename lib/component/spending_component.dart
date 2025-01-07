import 'package:budget_tracker_app/controllers/category_controller.dart';
import 'package:budget_tracker_app/controllers/spending_controller.dart';
import 'package:budget_tracker_app/model/category_model.dart';
import 'package:budget_tracker_app/model/spending_model.dart';
import 'package:budget_tracker_app/utils/extensions/my_extension.dart';
import 'package:budget_tracker_app/utils/helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

TextEditingController descController = TextEditingController();
TextEditingController amountController = TextEditingController();

GlobalKey<FormState> spendFormKey = GlobalKey<FormState>();

class SpendingComponent extends StatelessWidget {
  const SpendingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    SpendingController controllers = Get.put(SpendingController());
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GetBuilder<SpendingController>(
        builder: (ctx) {
          return Form(
            key: spendFormKey,
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
                10.h,
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
                10.h,
                Row(
                  children: [
                    Text(
                      "Mode",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.w,
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
                10.h,
                Row(
                  children: [
                    Text(
                      "Date",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.w,
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
                10.h,
                Expanded(
                  child: FutureBuilder(
                    future: DBHelper.dbHelper.fetchCategory(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<CategoryModel> category = snapshot.data ?? [];

                        return GridView.builder(
                          itemCount: category.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              controllers.spendImageIndex(
                                id: category[index].id!,
                                index: index,
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                // color: Colors.amber,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: index == controllers.spendingImgIndex
                                        ? Colors.black
                                        : Colors.transparent),
                                image: DecorationImage(
                                  image: MemoryImage(category[index].image!),
                                ),
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
                FloatingActionButton.extended(
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
          );
        },
      ),
    );
  }
}
