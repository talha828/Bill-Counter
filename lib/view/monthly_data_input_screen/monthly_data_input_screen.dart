import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/components/widgets/bbutton.dart';
import 'package:book_bank/components/widgets/btextfield.dart';
import 'package:book_bank/components/widgets/loading_indicator.dart';
import 'package:book_bank/model/customer_model.dart';
import 'package:book_bank/model/monthly_data_controller.dart';
import 'package:book_bank/view/edit_customer_screen/edit_customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthlyDataInputScreen extends StatelessWidget {
  final CustomerModel customer;
  final String selectedMonth;

  const MonthlyDataInputScreen({
    super.key,
    required this.customer,
    required this.selectedMonth,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MonthlyDataController>(
      init: MonthlyDataController(customer, selectedMonth),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            backgroundColor: appThemeColor,
            title: Text(
              customer.name.toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () => Get.to(EditCustomerScreen(customer: customer)),
              ),
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Previous Amount Input
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.43,
                          child: BTextField(
                            controller: controller.previousAmountController,
                            hintText: "27000",
                            keyboardType: TextInputType.number,
                            labelText: "Previous Amount",
                            obscureText: false,
                          ),
                        ), // Received Amount Input
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.43,
                          child: BTextField(
                            controller: controller.receivedAmountController,
                            hintText: "1000",
                            keyboardType: TextInputType.number,
                            labelText: "Received Amount",
                            obscureText: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                    BTextField(
                      controller: controller.milkAmountController,
                      hintText: "220",
                      keyboardType: TextInputType.number,
                      labelText: "Milk Price Pre Liter",
                      obscureText: false,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                    // Milk Entries Grid
                    Obx(() {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1.5,
                        ),
                        itemCount: controller.milkEntries.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => controller.refillPreviousEntry(index),
                            onDoubleTap: () => controller.editCell(index),
                            child: Container(
                              margin: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: controller.milkEntries[index][0] == 0
                                        ? appThemeColor.withOpacity(0.5)
                                        : Colors.white,
                                  ),
                                  color: controller.milkEntries[index][0] == 0
                                      ? Colors.white
                                      : appThemeColor.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Day ${index + 1}",
                                        style: TextStyle(
                                            color: controller.milkEntries[index]
                                                        [0] ==
                                                    0
                                                ? Colors.black
                                                : Colors.white)),
                                    Text(
                                        "${controller.milkEntries[index][0]} L",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: controller.milkEntries[index]
                                                        [0] ==
                                                    0
                                                ? Colors.black
                                                : Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.07),
                    // Save Button
                    BButton(
                      onTap: controller.saveData,
                      width: MediaQuery.of(context).size.width,
                      title: "Save Now (${controller.totalMilk}) L",
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Positioned.fill(child: LoadingIndicator());
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ],
          ),
        );
      },
    );
  }
}
