

import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/components/widgets/bbutton.dart';
import 'package:book_bank/helper/helper.dart';
import 'package:book_bank/model/customer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthlyDataController extends GetxController {
  final CustomerModel customer;
  final String selectedMonth;


  final previousAmountController = TextEditingController();
  final receivedAmountController = TextEditingController();
  final milkAmountController = TextEditingController();
  RxBool isLoading = false.obs;
  RxList<List<double>> milkEntries = <List<double>>[].obs;
  RxDouble totalMilk = 0.0.obs;
  RxDouble milkPrice = 0.0.obs;

  MonthlyDataController(this.customer, this.selectedMonth);

  @override
  void onInit() {
    super.onInit();
    int daysInSelectedMonth = Helper.getDaysInMonth(selectedMonth);
    milkEntries.value = List.generate(daysInSelectedMonth, (index) => [0]);
    fetchData();
  }

  void calculateTotal() {
    totalMilk.value =
        double.parse(milkEntries.fold(0.0, (double sum, entry) => sum + entry[0]).toStringAsFixed(2));
  }

  // Fetch data from Firebase
  void fetchData() async {
    isLoading.value = true;
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection(email)
        .doc(customer.id)
        .collection('monthly data')
        .doc(selectedMonth)
        .get();
    var userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    var userData = userDoc.data();
    if (userData != null) {
      milkPrice.value =
          double.parse(userData['milk_price'].toString() ?? "210");
    }
    if (document.exists) {
      previousAmountController.text =
          (double.parse(document.get('previous_amount').toString()))?.toStringAsFixed(2)  ?? '0';
      receivedAmountController.text =
          double.parse(document.get('received_amount').toString())?.toStringAsFixed(2) ?? '0';
      totalMilk.value = double.parse(document.get('total_milk').toString());
      List<dynamic> entries = document.get('milk_entries') ?? [];
      String summary = document.get('summary');
      milkAmountController.text = summary.split(":").last;
      milkEntries.value = List.generate(
          entries.length, (i) => [double.parse(entries[i].toStringAsFixed(2))]);
      calculateTotal();
    }
    isLoading.value = false;
  }

  // Save data to Firebase
  void saveData() async {
    isLoading.value = true;
    List<String> groupedEntries = _groupMilkEntries();
    String summary = "${customer.name}:${groupedEntries.join('')}:${int.parse((double.parse(previousAmountController.text)-double.parse(receivedAmountController.text.toString())).toStringAsFixed(0))}:${milkAmountController.text}";

    try {
      await FirebaseFirestore.instance
          .collection(email)
          .doc(customer.id)
          .collection('monthly data')
          .doc(selectedMonth)
          .update({
        "milk_entries": milkEntries.map((entry) => entry[0]).toList(),
        "total_milk": totalMilk.value,
        "received_amount": double.parse((receivedAmountController.text ?? 0).toString()).toString(),
        "previous_amount": double.parse((previousAmountController.text ?? 0).toString()).toString(),
        "summary": summary,
      });
      Get.snackbar("Success", "Data saved successfully!");
    } catch (error) {
      Get.snackbar("Error", "Failed to save data: $error");
    } finally {
      isLoading.value = false;
      Get.back();
    }
  }

  // Group milk entries for summary
  List<String> _groupMilkEntries() {
    List<String> groupedEntries = [];
    double currentQuantity = milkEntries[0][0];
    int startDay = 1;
    int count = 1;

    for (int i = 1; i < milkEntries.length; i++) {
      if (milkEntries[i][0] == currentQuantity) {
        count++;
      } else {
        groupedEntries.add("($currentQuantity-${startDay + count - 1})");
        currentQuantity = milkEntries[i][0];
        startDay = 1;
        count = 1;
      }
    }
    groupedEntries.add("($currentQuantity-${startDay + count - 1})");
    return groupedEntries;
  }

  // Refill the previous entry on single tap
  void refillPreviousEntry(int index) {
    if (index > 0) {
      milkEntries[index][0] = milkEntries[index - 1][0];
      Get.forceAppUpdate();
      calculateTotal();
    }
  }

  // Edit a specific cell
  void editCell(int index) {
    TextEditingController controller =
    TextEditingController(text: milkEntries[index][0].toString());

    // List of predefined values
    final List<String> values = ['0.5', '1', '1.5', '2'];

    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.only(right: 20,left: 20,bottom: 20,top: 20),
      titleStyle: const TextStyle(fontSize: 18),
      title: "Quantity for Day ${index + 1}",
      content: Column(
        children: [
          TextField(
            style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(border: InputBorder.none),
          ),
          const SizedBox(height: 16), // Add some spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: values.map((value) {
              return GestureDetector(
                onTap: ()=> controller.text = value,
                child: SizedBox(
                  width: 50,
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: appThemeColor.withOpacity(0.5)
                        ),
                        color: Colors.white ,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(value,
                              style: const TextStyle(
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            ).toList(),
          ),
        ],
      ),
      confirmTextColor: Colors.white,
      onConfirm: () {
        if (controller.text.isNum) {
          if (double.parse(controller.text) > 25) {
            milkEntries[index][0] = double.parse(
                (double.tryParse(controller.text)! / milkPrice.value)
                    .toStringAsFixed(2)); // Convert price to milk quantity
            calculateTotal();
            Get.back();
          } else {
            milkEntries[index][0] = double.tryParse(controller.text) ?? 0;
            calculateTotal();
            Get.back();
          }
        }
      },
    );
  }
}
