import 'dart:convert';
import 'dart:io';

import 'package:book_bank/helper/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' ;
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class MainScreenController extends GetxController {
  var selectedMonth = DateFormat('MMMM - yyyy').format(DateTime.now().subtract(const Duration(days: 15))).obs;
  var availableMonths = <String>[].obs;
  var milkEntries = <List<int>>[].obs;
  var isLoading = false.obs;
  var customersList = <QueryDocumentSnapshot>[].obs;
  var filteredCustomers = <QueryDocumentSnapshot>[].obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCustomers();
    _loadAvailableMonths(); // Load months when the screen starts
  }

  void setLoading(bool value) {
    isLoading(value);
  }

  Future<void> showMonthPickerDialog(BuildContext context) async {
    String? selectedMonthResult = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a month'),
          content: SizedBox(
            height: 200,
            width: 300,
            child: ListView.separated(
              itemCount: availableMonths.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(availableMonths[index]),
                  onTap: () {
                    isLoading.value = true;
                    selectedMonth.value = availableMonths[index];
                    isLoading.value = false;
                    Navigator.pop(context);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
        );
      },
    );

    if (selectedMonthResult != null) {
      selectedMonth.value = selectedMonthResult;
    }
  }

  Future<void> _loadAvailableMonths() async {
    final firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection('customers').get();
    Set<String> months = {};

    for (int i=0;i<5;i++) {
      QuerySnapshot monthlyDataSnapshot = await firestore
          .collection('customers')
          .doc(snapshot.docs[i].id)
          .collection("monthly data")
          .get();

      monthlyDataSnapshot.docs.forEach((doc) {
        months.add(doc.id); // Add month (doc id) to the set
      });
    }
    availableMonths.assignAll(months.toList());
  }

  void setEntriesCount() {
    milkEntries.assignAll(List.generate(
        Helper.getDaysInMonth(selectedMonth.value), (index) => [0]));
  }
  String getPreviousMonth(String selectedMonth) {
    // Split the input to extract the month and year
    List<String> parts = selectedMonth.split(" - ");
    String currentMonth = parts[0]; // "September"
    int currentYear = int.parse(parts[1]); // 2024

    // Parse the current month using DateFormat to get the month index
    DateTime currentDate = DateFormat("MMMM").parse(currentMonth);
    int monthIndex = currentDate.month;

    // Calculate the previous month and adjust the year if needed
    int previousMonthIndex = monthIndex - 1;
    int previousYear = currentYear;

    // If it's January, go to December of the previous year
    if (previousMonthIndex == 0) {
      previousMonthIndex = 12;
      previousYear--;
    }

    // Create a DateTime object for the previous month
    DateTime previousDate = DateTime(previousYear, previousMonthIndex);

    // Format the previous month back to "Month - Year"
    String previousMonthFormatted = DateFormat('MMMM').format(previousDate);
    return "$previousMonthFormatted - $previousYear";
  }
  Future<void> copyCustomerNamesForNewMonth(BuildContext context) async {
    setLoading(true);
    try {
      DateTime? pickedDate = await showMonthPicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );

      if (pickedDate != null) {
        selectedMonth.value = DateFormat('MMMM - yyyy').format(pickedDate);
        setEntriesCount();
        final firestore = FirebaseFirestore.instance;
        final customersSnapshot = await firestore.collection('customers').get();
        double milkPrice = 0.0;
        String previousMonth =  getPreviousMonth(selectedMonth.value);
        var userDoc = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
        var userData = userDoc.data();
        if (userData != null) {
          milkPrice = double.parse(userData['milk_price'].toString() ?? "0");
        }
        for (var doc in customersSnapshot.docs) {
          final documentSnapshot = await firestore
              .collection('customers')
              .doc(doc.id)
              .collection('monthly data')
              .doc(previousMonth)
              .get();

          String previousAmount =
              documentSnapshot.data()?['previous_amount']?.toString() ?? '0';
          String receivedAmount = documentSnapshot.data()?['received_amount']?.toString() ?? '0';
          double totalMilk = double.parse(documentSnapshot.data()?['total_milk']?.toString() ?? '0');

          double newPreviousAmount =
              double.parse(previousAmount) - double.parse(receivedAmount);

          await firestore
              .collection('customers')
              .doc(doc.id)
              .collection("monthly data")
              .doc(selectedMonth.value)
              .set({
            "milk_entries": milkEntries.map((entry) => entry[0]).toList(),
            "total_milk": 00,
            "received_amount": 00,
            "previous_amount": ((totalMilk * milkPrice) + newPreviousAmount).toStringAsFixed(0),
            "summary": "${doc['name']}:(0-0):${newPreviousAmount.toStringAsFixed(0)}",
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during operation: $e");
      }
    } finally {
      setLoading(false);
      _loadAvailableMonths();
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCustomerMonthlyDataStream(String customerId) {
    final firestore = FirebaseFirestore.instance;
    return firestore
        .collection('customers')
        .doc(customerId)
        .collection("monthly data")
        .doc(selectedMonth.value)
        .snapshots();
  }


  Future<List<String>> getCustomerData() async {
    final firestore = FirebaseFirestore.instance;
    List<String> customerData = [];

    QuerySnapshot snapshot = await firestore.collection('customers').get();

    for (var doc in snapshot.docs) {
      try {
        DocumentSnapshot<Map<String, dynamic>> summary = await firestore
            .collection('customers')
            .doc(doc.id)
            .collection("monthly data")
            .doc(selectedMonth.value)
            .get();

        if (summary.exists && summary.data() != null && summary.data()!.containsKey('summary')) {
          customerData.add(summary['summary'].toString());
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching summary for ${doc.id}: $e');
        }
      }
    }
    return customerData;
  }
  Future<void> fetchCustomers() async {
    isLoading(true);
    try {
      final snapshot = await FirebaseFirestore.instance.collection('customers').get();
      customersList.value = snapshot.docs;
      filteredCustomers.value = customersList;
    } finally {
      isLoading(false);
    }
  }
  void filterCustomers(String query) {
    if (query.isEmpty) {
      filteredCustomers.value = customersList;
    } else {
      filteredCustomers.value = customersList
          .where((customer) =>
          customer['name'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<void> fetchAndOpenPdf(BuildContext context,String selectedMonth) async {
    print("Start function");
    setLoading(true);
    var userDoc = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    var userData = userDoc.data();
    String name = "Yousaf Meo";
    String milkPrice = "220";
      if(userData != null){
         name = userData?['name'] ?? '';
         milkPrice = userData?['milk_price'].toString() ?? "0";
      }

    final Map<String, dynamic> data = {
      "customer_data": await getCustomerData(),
      "date": selectedMonth,
      "company_name": name,
      "milk_price_per_liter": double.parse(milkPrice)
    };

    try {
      String url = 'https://flask-api-invoice.onrender.com/api/invoice_pdf';
      print("send request");
      print(data.toString());
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      print("get response");
      if (response.statusCode == 200) {
        Directory directory = await getTemporaryDirectory();
        String filePath = '${directory.path}/invoice.pdf';
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        OpenFile.open(filePath);
      } else {
        if (kDebugMode) {
          print('Failed to fetch PDF. Status code: ${response.statusCode}');
        }
        Get.snackbar("Error", "Failed to fetch PDF: ${response.reasonPhrase}");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteCustomer(String customerId) async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('customers').doc(customerId).delete();
      if (kDebugMode) {
        print("Customer Deleted");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Customer not Deleted $e");
      }
    }
  }

  void showDeleteOptions(String customerId ,BuildContext context ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose Action"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Delete Customer'),
                onTap: () {
                  Navigator.of(context).pop();
                  deleteCustomer(customerId);
                },
              ),
              ListTile(
                title: const Text('Delete Monthly Data'),
                onTap: () {
                  Navigator.of(context).pop();
                  showMonthlyDataOptions(customerId,context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showMonthlyDataOptions(String customerId,BuildContext context) async {
    final firestore = FirebaseFirestore.instance;

    // Fetch the months for this customer
    QuerySnapshot monthlyDataSnapshot = await firestore
        .collection('customers')
        .doc(customerId)
        .collection('monthly data')
        .get();

    List<String> months =
    monthlyDataSnapshot.docs.map((doc) => doc.id).toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Month to Delete"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: months.map((month) {
              return ListTile(
                title: Text(month),
                onTap: () {
                  Navigator.of(context).pop();
                  deleteMonthlyData(customerId, month);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Future<void> deleteMonthlyData(String customerId, String month) async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('customers').doc(customerId).collection('monthly data').doc(month).delete();
      if (kDebugMode) {
        print("Monthly data for $month deleted successfully.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting monthly data: $e");
      }
    }
  }
}
