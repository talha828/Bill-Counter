import 'package:book_bank/helper/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCustomerController extends GetxController {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final preBalanceController = TextEditingController(text: "0");

  var isLoading = false.obs; // Observing loading state
  var milkEntries = <List<int>>[].obs; // Observing milk entries

  @override
  void onInit() {
    super.onInit();
    setEntriesCount();
  }

  // Method to generate milk entries for the current month
  void setEntriesCount() {
    int daysInMonth = Helper.getDaysInMonth(Helper.getCurrentDateFormatted());
    milkEntries.value = List.generate(daysInMonth, (index) => [0]);
  }

  // Method to save customer data to Firestore
  void saveCustomer() async {
    isLoading.value = true;
    String name = nameController.text;
    String number = phoneNumberController.text.isEmpty ?"+92xxx" :phoneNumberController.text;
    try {
      DocumentReference customerDoc = await FirebaseFirestore.instance.collection('customers').add({
        'name': name,
        'number': number,
      });
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerDoc.id)
          .collection('monthly data')
          .doc(Helper.getCurrentDateFormatted())
          .set({
        "milk_entries": milkEntries.map((entry) => entry[0]).toList(),
        "total_milk": 00,
        "received_amount": 00,
        "previous_amount": double.parse(preBalanceController.text),
        "summary": "$name:(0-0):${preBalanceController.text}",
      });
      Get.back(); // Close the screen after saving
    } catch (e) {
      Get.snackbar("Error", "Failed to save customer data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}