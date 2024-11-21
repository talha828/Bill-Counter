import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/components/widgets/loading_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerSelectionScreen extends StatefulWidget {
  final String selectedMonth;
  final Function(List<String>) onSelectedCustomers;

  CustomerSelectionScreen(
      {required this.selectedMonth, required this.onSelectedCustomers});

  @override
  _CustomerSelectionScreenState createState() =>
      _CustomerSelectionScreenState();
}

class _CustomerSelectionScreenState extends State<CustomerSelectionScreen> {
  List<String> customers = [];
  List<String> selectedCustomers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  Future<List<String>> fetchCustomers() async {
    final firestore = FirebaseFirestore.instance;
    List<String> customerData = [];

    QuerySnapshot snapshot = await firestore.collection('customers').get();

    for (var doc in snapshot.docs) {
      try {
        DocumentSnapshot<Map<String, dynamic>> summary = await firestore
            .collection('customers')
            .doc(doc.id)
            .collection("monthly data")
            .doc(widget.selectedMonth)
            .get();

        if (summary.exists &&
            summary.data() != null &&
            summary.data()!.containsKey('summary')) {
          customerData.add(summary['summary'].toString());
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching summary for ${doc.id}: $e');
        }
      }
    }
    customers.addAll(customerData);
    setState(() {
      isLoading = false;
    });
    print(customerData.length);
    return customerData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: appThemeColor,
        onPressed: () {
          widget.onSelectedCustomers(selectedCustomers);
          Navigator.pop(context);
        },
        label: const Text(
          'Generate Invoice',
          style: TextStyle(color: Colors.white),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: appThemeColor,
        title: const Text(
          'Select Customers',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(child: LoadingIndicator())
          : ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 0,
                );
              },
              itemCount: customers.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedCustomers.contains(customers[index]);
                return ListTile(
                  trailing: Text(
                    customers[index].split(":").last.toUpperCase(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  title: Text(customers[index].split(":").first.toUpperCase()),
                  subtitle: Text(customers[index].split(":")[1].toUpperCase()),
                  tileColor: isSelected
                      ? appThemeColor.withOpacity(0.2)
                      : Colors.transparent,
                  onTap: () {
                    setState(
                      () {
                        if (isSelected) {
                          selectedCustomers.remove(customers[index]);
                        } else {
                          selectedCustomers.add(customers[index]);
                        }
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
