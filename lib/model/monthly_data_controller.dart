import 'package:book_bank/helper/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthlyDataController extends GetxController {
  final String customerId;
  final String selectedMonth;
  final String customerName;

  final previousAmountController = TextEditingController();
  final receivedAmountController = TextEditingController();
  RxBool isLoading = false.obs;
  RxList<List<double>> milkEntries = <List<double>>[].obs;
  RxDouble totalMilk = 0.0.obs;
  RxDouble milkPrice = 0.0.obs;

  MonthlyDataController(this.customerId, this.selectedMonth, this.customerName);

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
        .collection('customers')
        .doc(customerId)
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
    String summary =
        "$customerName:${groupedEntries.join('')}:${int.parse((double.parse(previousAmountController.text)-double.parse(receivedAmountController.text.toString())).toStringAsFixed(0))}";

    try {
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .collection('monthly data')
          .doc(selectedMonth)
          .update({
        "milk_entries": milkEntries.map((entry) => entry[0]).toList(),
        "total_milk": totalMilk.value,
        "received_amount": double.parse(receivedAmountController.text).toString(),
        "previous_amount": double.parse(previousAmountController.text).toString(),
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
    Get.defaultDialog(
      title: "Edit Milk Quantity for Day ${index + 1}",
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Milk Quantity (Liters)'),
      ),
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
