import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/components/widgets/bbutton.dart';
import 'package:book_bank/components/widgets/btextfield.dart';
import 'package:book_bank/components/widgets/loading_indicator.dart';
import 'package:book_bank/model/monthly_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MonthlyDataInputScreen extends StatelessWidget {
  final String customerId;
  final String selectedMonth;
  final String customerName;

  const MonthlyDataInputScreen({
    super.key,
    required this.customerId,
    required this.selectedMonth,
    required this.customerName,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MonthlyDataController>(
      init: MonthlyDataController(customerId, selectedMonth, customerName),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back,color: Colors.white,)),
              backgroundColor: appThemeColor,
              title: Text(customerName.toUpperCase(),style: const TextStyle(color: Colors.white),)),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Previous Amount Input
                    BTextField(
                      controller: controller.previousAmountController,
                      hintText: "27000",
                      labelText: "Previous Amount",
                      obscureText: false,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                    // Received Amount Input
                    BTextField(
                      controller: controller.receivedAmountController,
                      hintText: "1000",
                      labelText: "Received Amount",
                      obscureText: false,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                    // Milk Entries Grid
                    Obx((){
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          childAspectRatio: 1,
                        ),
                        itemCount: controller.milkEntries.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => controller.refillPreviousEntry(index),
                            onDoubleTap: () => controller.editCell(index),
                            child: Container(
                              color: controller.milkEntries[index][0] == 0
                                  ? Colors.white
                                  : appThemeColor.withOpacity(0.5),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Day ${index + 1}",
                                        style: TextStyle(
                                            color: controller.milkEntries[index][0] == 0
                                                ? Colors.black
                                                : Colors.white)),
                                    Text("${controller.milkEntries[index][0]} L",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: controller.milkEntries[index][0] == 0
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
                    SizedBox(height: MediaQuery.of(context).size.width * 0.04),
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
