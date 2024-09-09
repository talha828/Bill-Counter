import 'dart:convert';
import 'dart:io';

import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/components/widgets/loading_indicator.dart';
import 'package:book_bank/helper/helper.dart';
import 'package:book_bank/view/create_customer_screen/create_cusomer_screen.dart';
import 'package:book_bank/view/monthly_data_input_screen/monthly_data_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:book_bank/firebase/auth.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _selectedMonth = DateFormat('MMMM - yyyy').format(DateTime.now().subtract(Duration(days: 30)));
  List<String> _availableMonths = [];
  List<List<int>> milkEntries = [];
  bool isLoading = false;
  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAvailableMonths(); // Load months when the screen starts
  }

  Future<void> _showMonthPickerDialog() async {
    String? selectedMonth = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a month'),
          content: Container(
            height: 200, // Adjust the height based on the number of items
            width: 300,
            child: ListView.separated(
              itemCount: _availableMonths.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_availableMonths[index]),
                  onTap: () {
                    setState(() {
                      _selectedMonth = _availableMonths[index];
                    });
                    Navigator.pop(context); // Close popup
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          ),
        );
      },
    );

    // Update the selected month and refresh the screen
    if (selectedMonth != null) {
      setState(() {
        _selectedMonth = selectedMonth;
      });
    }
  }

  Future<void> _loadAvailableMonths() async {
    final firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection('customers').get();
    Set<String> months = {};

    for (var doc in snapshot.docs) {
      QuerySnapshot monthlyDataSnapshot = await firestore
          .collection('customers')
          .doc(doc.id)
          .collection("monthly data")
          .get();

      monthlyDataSnapshot.docs.forEach((doc) {
        months.add(doc.id); // Add month (doc id) to the set
      });
    }
    setState(() {
      _availableMonths = months.toList();
    });
  }

  setEntriesCount() => setState(() => milkEntries =
      List.generate(Helper.getDaysInMonth(_selectedMonth), (index) => [0]));

  Future<void> _copyCustomerNamesForNewMonth() async {
    setLoading(true);
    try {
      DateTime? pickedDate = await showMonthPicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );

      if (pickedDate != null) {
        setState(() {
          _selectedMonth = DateFormat('MMMM - yyyy').format(pickedDate);
          print("Selected month: $_selectedMonth");
        });

        setEntriesCount();
        final firestore = FirebaseFirestore.instance;
        final customersSnapshot = await firestore.collection('customers').get();

        print("Fetched customers: ${customersSnapshot.docs.length}");
        String _previousMonth = DateFormat('MMMM - yyyy').format(DateTime.now().subtract(Duration(days: 30)));

        for (var doc in customersSnapshot.docs) {
          print("Processing customer: ${doc.id}");

          // Fetch previous month's data
          final documentSnapshot = await firestore
              .collection('customers')
              .doc(doc.id)
              .collection('monthly data')
              .doc(_previousMonth)
              .get();

          // Retrieve amounts safely
          String previousAmount =
               documentSnapshot.data()?['previous_amount']?.toString() ?? '0';
          String receivedAmount =
              documentSnapshot.data()?['received_amount']?.toString() ?? '0';
              print(previousAmount);
          // Calculate new previous amount
          double newPreviousAmount =
              double.parse(previousAmount) - double.parse(receivedAmount);

          // Write data for the new month
          await firestore
              .collection('customers')
              .doc(doc.id)
              .collection("monthly data")
              .doc(_selectedMonth)
              .set({
            "milk_entries": milkEntries.map((entry) => entry[0]).toList(),
            "total_milk": 00,
            "received_amount": 00,
            "previous_amount": int.parse(newPreviousAmount.toStringAsFixed(0)),
            "summary": "${doc['name']}:(0-0):${newPreviousAmount.toStringAsFixed(0)}",
          });

          print(
              "Data written for customer ${doc.id} for month $_selectedMonth");
        }
      }
    } catch (e) {
      print("Error during operation: $e");
    } finally {
      setLoading(false);
      await _loadAvailableMonths();
    }
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
            .doc(_selectedMonth) // Now uses selected month
            .get();

        if (summary.exists &&
            summary.data() != null &&
            summary.data()!.containsKey('summary')) {
          customerData.add(summary['summary'].toString());
        }
      } catch (e) {
        print('Error fetching summary for ${doc.id}: $e');
      }
    }
    return customerData;
  }

  Future<void> fetchAndOpenPdf() async {
    setLoading(true);
    // Define the data to be sent to the API
    final Map<String, dynamic> data = {
      "customer_data": await getCustomerData(),
      "date": "September - 2024",
      "company_name": "ABCD",
      "milk_price_per_liter": 220
    };

    try {
      // API URL
      String url = 'https://flask-api-invoice.onrender.com/api/invoice_pdf';

      // Make the POST request
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Get the directory to save the PDF
        Directory directory = await getTemporaryDirectory();
        String filePath = '${directory.path}/invoice.pdf';

        // Write the PDF bytes to the file
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Open the PDF file
        OpenFile.open(filePath);
        setLoading(false);
      } else {
        setLoading(false);
        print('Failed to fetch PDF. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setLoading(false);
      print('Error: $e');
    }
  }

  void _showDeleteOptions(String customerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Action"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Delete Customer'),
                onTap: () {
                  Navigator.of(context).pop();
                  _deleteCustomer(customerId);
                },
              ),
              ListTile(
                title: Text('Delete Monthly Data'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showMonthlyDataOptions(customerId);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _deleteCustomer(String customerId) async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('customers')
          .doc(customerId)
          .collection("monthly data")
          .doc()
          .delete()
          .then((value) async {
        await firestore.collection('customers').doc(customerId).delete();
      });
      print("Customer Deleted");
    } catch (e) {
      print("Customer not Deleted $e");
    }
  }

  void _showMonthlyDataOptions(String customerId) async {
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
                  _deleteMonthlyData(customerId, month);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Future<void> _deleteMonthlyData(String customerId, String month) async {
    final firestore = FirebaseFirestore.instance;

    try {
      await firestore
          .collection('customers')
          .doc(customerId)
          .collection('monthly data')
          .doc(month)
          .delete();
      print("Monthly data for $month deleted successfully.");
    } catch (e) {
      print("Error deleting monthly data: $e");
    }
  }

// Helper function to parse the milk data
  List<double> parseMilkData(String milkData) {
    List<double> parsedQuantities = [];

    // Regex to extract milk quantities and day ranges
    RegExp regExp = RegExp(r'\(([\d.]+)-(\d+)\)');

    Iterable<RegExpMatch> matches = regExp.allMatches(milkData);

    for (var match in matches) {
      double quantity = double.parse(match.group(1)!);
      int endDay = int.parse(match.group(2)!);

      // Fill parsedQuantities for the given day range
      for (int i = 0; i < endDay; i++) {
        parsedQuantities.add(quantity);
      }
    }

    return parsedQuantities;
  }

// // Function to update customer data for 'August - 2024'
//   Future<void> updateCustomerDataForAugust2024(List<String> customers) async {
//     final firestore = FirebaseFirestore.instance;
//
//     for (String customer in customers) {
//       // Split customer data (example: "Name:(5-7)(4-22):previousAmount")
//       List<String> customerData = customer.split(':');
//       String customerName = customerData[0];
//       String milkEntryData = customerData[1];
//       String previousAmountStr = customerData[2];
//
//       // Parse milk data
//       List<double> parsedMilkQuantities = parseMilkData(milkEntryData);
//
//       // Create a map of milk entries for each day of the month
//       Map<int, double> dayMilkMap = {
//         for (var i = 1; i <=
//             parsedMilkQuantities.length; i++) i: parsedMilkQuantities[i - 1]
//       };
//
//       // Ensure the milk entries cover all 31 days, filling missing days with zero
//       List<double> milkEntriesFilled = List.generate(31, (index) {
//         return dayMilkMap[index + 1] ?? 0.0;
//       });
//         print(milkEntriesFilled);
//       List<List<double>> milkEntries = milkEntriesFilled.map((quantity) {
//         return [quantity];  // Convert each quantity to List<int>
//       }).toList();
//       // Calculate total milk and update previous amount
//       double previousAmount = double.parse(previousAmountStr);
//       double totalMilk = milkEntriesFilled.reduce((a, b) => a + b);
//       double totalPrice = totalMilk * 220;
//       double updatedPreviousAmount = totalPrice + previousAmount;
//
//       // Create the summary
//       String summary = "$customerName:$milkEntryData:$updatedPreviousAmount";
//
//       //Save data to Firebase for 'August - 2024'
//       await firestore.collection('customers').add({
//         'name': customerName,
//       }).then((value) {
//         firestore
//             .collection('customers')
//             .doc(value.id)
//             .collection('monthly data')
//             .doc("August - 2024") // You can replace with _selectedMonth for dynamic month selection
//             .set({
//           "milk_entries": milkEntries.map((entry) => entry[0]).toList(),
//           "total_milk": totalMilk,
//           "received_amount": 0, // Set default value
//           "previous_amount": updatedPreviousAmount,
//           "summary": summary,
//         });
//       }).catchError((error) {
//         print("Error adding customer: $error");
//       });
//     }
//   }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: appThemeColor,
        title: InkWell(
          onTap: () async => isLoading ? {} : await _showMonthPickerDialog(),
          child: Text(
            _selectedMonth.replaceAll("20", ""),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.copy,
              color: Colors.white,
            ),
            onPressed: () async =>
                isLoading ? {} : await _copyCustomerNamesForNewMonth(),
          ),
          IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () => isLoading ? {} : Get.to(AddCustomerScreen()))
        ],
      ),
      body: Stack(
        children: [
          isLoading
              ? Container()
              : StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('customers')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final customers = snapshot.data!.docs;
                    return SingleChildScrollView(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: customers.length,
                        itemBuilder: (context, index) {
                          final customer = customers[index];
                          final customerId = customer.id;
                          final name = customer['name'].toString().toUpperCase();

                          return InkWell(
                            onTap: () => Get.to(
                              MonthlyDataInputScreen(
                                  customerId: customerId,
                                  selectedMonth: _selectedMonth,
                                  customerName: name),
                            ),
                            onLongPress: () => _showDeleteOptions(customerId),
                            child: StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('customers')
                                  .doc(customerId)
                                  .collection('monthly data')
                                  .doc(_selectedMonth)
                                  .snapshots(),
                              builder: (context, milkSnapshot) {
                                if (milkSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return ListTile(
                                    title: Text(name),
                                    subtitle: Text('Loading milk data...'),
                                  );
                                }

                                if (milkSnapshot.hasError) {
                                  return ListTile(
                                    title: Text(name),
                                    subtitle: Text('Error fetching milk data'),
                                  );
                                }

                                final milkDataDocs = milkSnapshot.data;
                                String currentBalance = "00";
                                String receivedBalance = "00";
                                String totalMilk = "00";
                                String milkData = 'xx:(x-x):xx';
                                if (milkDataDocs!.exists) {
                                  final latestMilkData = milkDataDocs.data();
                                  print(latestMilkData);
                                  milkData =
                                      latestMilkData!['summary'].toString();
                                  totalMilk =
                                      latestMilkData['total_milk'].toString();
                                  currentBalance =
                                      latestMilkData['previous_amount']
                                          .toString();
                                  receivedBalance =
                                      latestMilkData['received_amount']
                                          .toString();
                                }

                                return ListTile(
                                  title: Text(name),
                                  subtitle: Text(
                                      '${milkData.split(":")[1].replaceAll("(", " ").replaceAll(")", " ").replaceAll("-", "--")}'),
                                  trailing: Text(
                                    "${double.parse(totalMilk).toStringAsFixed(2)}L - ${ (double.parse(currentBalance)-double.parse(receivedBalance)).toStringAsFixed(0)}",
                                    style: TextStyle(fontSize: width * 0.05),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                      ),
                    );
                  },
                ),
          isLoading
              ? const Positioned.fill(child: LoadingIndicator())
              : Container()
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        onPressed: () async =>  isLoading ? {}:await fetchAndOpenPdf(),
        backgroundColor: appThemeColor,
        label: Row(
          children: [
            const Text(
              "Generate Bill",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            Icon(
              Icons.play_arrow_outlined,
              color: Colors.white,
              size: width * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
