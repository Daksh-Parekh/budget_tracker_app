import 'package:budget_tracker_app/component/all_category_component.dart';
import 'package:budget_tracker_app/component/spending_component.dart';
import 'package:budget_tracker_app/controllers/spending_controller.dart';
import 'package:budget_tracker_app/model/category_model.dart';
import 'package:budget_tracker_app/model/spending_model.dart';
import 'package:budget_tracker_app/utils/extensions/my_extension.dart';
import 'package:budget_tracker_app/utils/helper/db_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

TextEditingController spendDescEditController = TextEditingController();
TextEditingController spendAmtEditController = TextEditingController();
GlobalKey<FormState> spendEditKey = GlobalKey<FormState>();

class AllSpendingsComponent extends StatelessWidget {
  const AllSpendingsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    SpendingController allSpendController = Get.put(SpendingController());
    allSpendController.getSpendingRecord();
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          GetBuilder<SpendingController>(builder: (context) {
            return FutureBuilder(
              future: allSpendController.allSpends,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<SpendingModel> allSpendsData = snapshot.data ?? [];
                  return Expanded(
                    child: ListView.builder(
                      itemCount: allSpendsData.length,
                      itemBuilder: (context, index) => Slidable(
                        endActionPane: ActionPane(
                          motion: DrawerMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                allSpendController
                                    .deleteSpendRecord(allSpendsData[index].id);
                              },
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.all(16),
                              borderRadius: BorderRadius.circular(12),
                              label: "Delete",
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                spendDescEditController.text =
                                    allSpendsData[index].desc;
                                spendAmtEditController.text =
                                    allSpendsData[index].amount.toString();
                                String modeEdit = allSpendsData[index].mode;
                                String editDate = allSpendsData[index].date;
                                // allSpendController.assignDefaultValue();
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
                                      key: spendEditKey,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            //Desc
                                            TextFormField(
                                              controller:
                                                  spendDescEditController,
                                              maxLines: 2,
                                              validator: (value) => value!
                                                      .isEmpty
                                                  ? "Description is required"
                                                  : null,
                                              decoration: InputDecoration(
                                                labelText: 'Description',
                                                hintText: 'Enter description',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            10.he,
                                            //Amount
                                            TextFormField(
                                              controller:
                                                  spendAmtEditController,
                                              validator: (value) =>
                                                  value!.isEmpty
                                                      ? "Amount is required"
                                                      : null,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText: 'Amount',
                                                hintText: 'Enter amount',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            10.he,
                                            //Mode
                                            Row(
                                              children: [
                                                Text(
                                                  "Mode",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                10.wi,
                                                DropdownButton(
                                                  value: modeEdit,
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
                                                  onChanged: allSpendController
                                                      .changeMode,
                                                ),
                                              ],
                                            ),
                                            10.he,
                                            //Date
                                            GetBuilder<SpendingController>(
                                                builder: (context) {
                                              return Row(
                                                children: [
                                                  Text(
                                                    "Date",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  10.wi,
                                                  IconButton(
                                                    onPressed: () async {
                                                      DateTime? date =
                                                          await showDatePicker(
                                                        context: Get.context!,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(2000),
                                                        lastDate:
                                                            DateTime(2027),
                                                      );

                                                      if (date != null) {
                                                        allSpendController
                                                            .changeDate(date);
                                                      }
                                                    },
                                                    icon: Icon(Icons
                                                        .calendar_month_rounded),
                                                  ),
                                                  if (allSpendController
                                                          .dateTime !=
                                                      null)
                                                    Text(
                                                        "${allSpendController.dateTime?.day}/${allSpendController.dateTime?.month}/${allSpendController.dateTime?.year}")
                                                  else
                                                    Text("$editDate"),
                                                ],
                                              );
                                            }),
                                            FloatingActionButton.extended(
                                              onPressed: () {
                                                if (spendEditKey.currentState!
                                                        .validate() &&
                                                    allSpendController
                                                            .modeSelection !=
                                                        null &&
                                                    allSpendController
                                                            .dateTime !=
                                                        null) {
                                                  allSpendController
                                                      .updateSpendingRecord(
                                                    SpendingModel(
                                                      id: allSpendsData[index]
                                                          .id,
                                                      desc:
                                                          spendDescEditController
                                                              .text,
                                                      amount: num.parse(
                                                          spendAmtEditController
                                                              .text),
                                                      mode: allSpendController
                                                          .modeSelection!,
                                                      date:
                                                          "${allSpendController.dateTime?.day}/${allSpendController.dateTime?.month}/${allSpendController.dateTime?.year}",
                                                      categoryId:
                                                          allSpendsData[index]
                                                              .categoryId,
                                                    ),
                                                  );
                                                  spendDescEditController
                                                      .clear();
                                                  spendAmtEditController
                                                      .clear();
                                                  // allSpendController
                                                  //     .assignDefaultValue();

                                                  Get.back();
                                                  // Navigator.pop(context);
                                                } else {
                                                  Get.snackbar(
                                                    'Failed',
                                                    '${spendDescEditController.text},${spendAmtEditController.text},${allSpendController.modeSelection},${allSpendController.dateTime}',
                                                    backgroundColor:
                                                        Colors.green,
                                                    colorText: Colors.white,
                                                  );
                                                }
                                              },
                                              label: Text("SAVE"),
                                            ),
                                            // FloatingActionButton.extended(
                                            //   onPressed: () async {
                                            //     if (formKey.currentState!
                                            //             .validate() &&
                                            //         categoryController
                                            //                 .categoryIndex !=
                                            //             null) {
                                            //       String name =
                                            //           categoryNameController.text;
                                            //       String assetPath =
                                            //           categoryImage[
                                            //               categoryController
                                            //                   .categoryIndex!];
                                            //       ByteData byteData =
                                            //           await rootBundle
                                            //               .load(assetPath);
                                            //       Uint8List img = byteData.buffer
                                            //           .asUint8List();
                                            //       CategoryModel model =
                                            //           CategoryModel(
                                            //               id:
                                            //                   allCategoryData[
                                            //                           index]
                                            //                       .id,
                                            //               name: name,
                                            //               image: img,
                                            //               imageIndex:
                                            //                   categoryController
                                            //                       .categoryIndex!);
                                            //       categoryController
                                            //           .updateCategory(model);
                                            //       Navigator.pop(context);
                                            //     }
                                            //   },
                                            //   label: const Text(
                                            //     "Update Category",
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.all(16),
                              borderRadius: BorderRadius.circular(12),
                              label: "Edit",
                            ),
                          ],
                        ),
                        child: Container(
                          height: 120.h,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(6),
                          alignment: Alignment(-1, 0.5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 157, 169, 253)
                                    .withOpacity(0.5),
                                blurRadius: 6,
                                offset: Offset(6, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                leading: FutureBuilder(
                                  future: allSpendController.fetchCategory(
                                      allSpendsData[index].categoryId),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Image.memory(
                                        snapshot.data!.image!,
                                        height: 50,
                                      );
                                    }
                                    return CircularProgressIndicator();
                                  },
                                ),
                                title: Text(
                                  allSpendsData[index].desc.tcase,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  "₹ ${allSpendsData[index].amount}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                trailing: ActionChip(
                                  color: WidgetStateProperty.all(
                                    allSpendsData[index].mode == 'online'
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  onPressed: () {},
                                  autofocus: true,
                                  label: Text(
                                    "${allSpendsData[index].mode.tcase}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(-0.22, -0.5),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Date : ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "${allSpendsData[index].date}",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
            );
          }),
        ],
      ),
    );
  }
}
