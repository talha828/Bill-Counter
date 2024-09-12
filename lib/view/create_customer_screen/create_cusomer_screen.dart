import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/components/widgets/bbutton.dart';
import 'package:book_bank/components/widgets/btextfield.dart';
import 'package:book_bank/components/widgets/loading_indicator.dart';
import 'package:book_bank/model/create_customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AddCustomerScreen extends StatelessWidget {
   AddCustomerScreen({super.key});

  final CreateCustomerController controller = Get.put(CreateCustomerController());
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(), // Using GetX navigation
        ),
        backgroundColor: appThemeColor,
        title: const Text('Create Customer', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BTextField(
                  controller: controller.nameController,
                  hintText: 'Hamza',
                  labelText: "Customer Name",
                  obscureText: false,
                ),
                SizedBox(height: width * 0.04),
                BTextField(
                  controller: controller.preBalanceController,
                  hintText: "1000",
                  labelText: "Previous Balance",
                  obscureText: false,
                ),
                SizedBox(height: width * 0.15),
                Obx(() => BButton(
                  width: width,
                  onTap: controller.saveCustomer,
                  title: controller.isLoading.value
                      ? 'Saving...'
                      : 'Save Customer',
                )),
              ],
            ),
          ),
          Obx(() => controller.isLoading.value
              ? const Positioned.fill(child: LoadingIndicator())
              : Container())
        ],
      ),
    );
  }
}