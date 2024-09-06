import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/firebase/auth.dart';
import 'package:book_bank/view/create_customer_screen/create_cusomer_screen.dart';
import 'package:book_bank/view/monthly_data_input_screen/montly_data_input_screen.dart';
import 'package:book_bank/view/monthly_data_input_screen/new_input.dart';
import 'package:book_bank/view/montly_bill_generation_screen/monthly_bill_generation_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appThemeColor,
        centerTitle: true,
        leading: Container(),
        title: Text(
          Auth.getCurrentDateFormatted(),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCustomerScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('customers').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final customers = snapshot.data!.docs;

          return ListView.separated(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final customer = customers[index];
              final customerId = customer.id;
              final name = customer['name'].toString().toUpperCase();

              return StreamBuilder<QuerySnapshot>(
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
                    final latestMilkData = milkDataDocs.last;
                    milkData = latestMilkData['summary'].toString();
                    totalMilk = latestMilkData['total_milk'].toString();
                    currentBalance =
                        latestMilkData['previous_amount'].toString();
                  }

                  return ListTile(
                    onTap: () => Get.to(
                      MilkEntryScreen(
                        customerId: customerId,
                        customerName: name,
                        selectedMonth: Auth.getCurrentDateFormatted(),
                        //TODO : Have to do something
                      ),
                    ),
                    leading: Text(
                      "${totalMilk}L",
                      style: TextStyle(
                          fontSize: width * 0.05, fontWeight: FontWeight.w100),
                    ),
                    title: Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        '${milkData.split(":")[1].replaceAll("(", " ").replaceAll(")", " ").replaceAll("-", "--")}'),
                    trailing: Text(
                      currentBalance,
                      style: TextStyle(fontSize: width * 0.05),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        onPressed: () => BillGenerationScreen(),
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
