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
  String _selectedMonth =
      Auth.getCurrentDateFormatted(); // Default current month
  List<String> _availableMonths = []; // Will hold available months in Firestore
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

  setEntriesCount() => setState(() => milkEntries = List.generate(
      Helper.getDaysInMonth(_selectedMonth), (index) => [0]));

  Future<void> _copyCustomerNamesForNewMonth() async {
    setLoading(true);
    DateTime? pickedDate = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedMonth = DateFormat('MMMM - yyyy').format(pickedDate);
        print(_selectedMonth);
      });

      setEntriesCount();
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('customers').get().then((value) async {
        print("Fetched customers: ${value.docs.length}");
        for (var doc in value.docs) {
          print("Processing customer: ${doc.id}");
          await firestore
              .collection('customers')
              .doc(doc.id)
              .collection("monthly data")
              .doc(_selectedMonth)
              .set({
            "milk_entries": milkEntries.map((entry) => entry[0]).toList(),
            "total_milk": 00,
            "previous_amount": 00,
            "summary": "aa:(0-0):00",
          }).then((_) {
            print("Data written for customer ${doc.id} for month $_selectedMonth");
          }).catchError((e) {
            print("Error writing data for ${doc.id}: $e");
            setLoading(false);
          });
        }
      }).catchError((e) {
        print("Error fetching customers: $e");
        setLoading(false);
      });

      setLoading(false);
    }else{
      setLoading(false);
    }
    await _loadAvailableMonths();
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
    try{
      await firestore
          .collection('customers')
          .doc(customerId).delete();
      print("Customer Deleted");
    }catch (e){
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

    List<String> months = monthlyDataSnapshot.docs.map((doc) => doc.id).toList();

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


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: appThemeColor,
        title: InkWell(
          onTap: () async => isLoading?{}:await _showMonthPickerDialog(),
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
            onPressed: () async => isLoading?{}:await _copyCustomerNamesForNewMonth(),
          ),
          IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () =>isLoading?{}: Get.to(AddCustomerScreen()))
        ],
      ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('customers').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final customers = snapshot.data!.docs;
              return ListView.separated(
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
                    onLongPress: ()=>_showDeleteOptions(customerId),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('customers')
                          .doc(customerId)
                          .collection('monthly data')
                          .snapshots(),
                      builder: (context, milkSnapshot) {
                        if (milkSnapshot.connectionState == ConnectionState.waiting) {
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

                        final milkDataDocs = milkSnapshot.data!.docs;
                        String currentBalance = "Loading";
                        String totalMilk = "Loading";
                        String milkData = 'No milk data available';
                        if (milkDataDocs.isNotEmpty) {

                          final latestMilkData = milkDataDocs.where((element)=>element.id == _selectedMonth || element.id.isNotEmpty).toList();
                            milkData =latestMilkData[0].id == _selectedMonth? latestMilkData[0]['summary'].toString() : "xx:(x-x):xx";
                            totalMilk =latestMilkData[0].id == _selectedMonth?
                                latestMilkData[0]['total_milk'].toString():"xx";
                            currentBalance =latestMilkData[0].id == _selectedMonth?
                                latestMilkData[0]['previous_amount'].toString():"xx";
                        }

                        return ListTile(
                          title: Text(name),
                          subtitle: Text(
                              '${milkData.split(":")[1].replaceAll("(", " ").replaceAll(")", " ").replaceAll("-", "--")}'),
                          trailing: Text(
                            "${totalMilk}L - ${currentBalance}",
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
