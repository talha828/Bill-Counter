import 'package:book_bank/helper/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  MonthlyDataController(this.customerId, this.selectedMonth, this.customerName);

  @override
  void onInit() {
    super.onInit();
    int daysInSelectedMonth = Helper.getDaysInMonth(selectedMonth);
    milkEntries.value = List.generate(daysInSelectedMonth, (index) => [0]);
    fetchData();
  }

  // Function to calculate total milk
  void calculateTotal() {
    totalMilk.value = milkEntries.fold(0.0, (double sum, entry) => sum + entry[0]);
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

    if (document.exists) {
      previousAmountController.text = document.get('previous_amount')?.toString() ?? '0';
      receivedAmountController.text = document.get('received_amount')?.toString() ?? '0';
      List<dynamic> entries = document.get('milk_entries') ?? [];
      milkEntries.value = List.generate(entries.length, (i) => [double.parse(entries[i].toString())]);
      calculateTotal();
    }
    isLoading.value = false;
  }

  // Save data to Firebase
  void saveData() async {
    isLoading.value = true;
    List<String> groupedEntries = _groupMilkEntries();
    String summary = "$customerName:${groupedEntries.join('')}:${int.parse(previousAmountController.text)}";

    try {
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .collection('monthly data')
          .doc(selectedMonth)
          .update({
        "milk_entries": milkEntries.map((entry) => entry[0]).toList(),
        "total_milk": totalMilk.value,
        "received_amount": receivedAmountController.text,
        "previous_amount": previousAmountController.text,
        "summary": summary,
      });
      Get.snackbar("Success", "Data saved successfully!");
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.back();
      });
    } catch (error) {
      Get.snackbar("Error", "Failed to save data: $error");
    } finally {
      isLoading.value = false;
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
        startDay = i + 1;
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
      calculateTotal();
    }
  }

  // Edit a specific cell
  void editCell(int index) {
    TextEditingController controller = TextEditingController(text: milkEntries[index][0].toString());
    Get.defaultDialog(
      title: "Edit Milk Quantity for Day ${index + 1}",
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Milk Quantity (Liters)'),
      ),
      onConfirm: () {
        milkEntries[index][0] = double.tryParse(controller.text) ?? 0;
        calculateTotal();
        Get.back();
      },
    );
  }
}