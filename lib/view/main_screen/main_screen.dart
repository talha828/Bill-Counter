import 'package:book_bank/view/balances_deduction_screen/balances_deduction_screen.dart';
import 'package:book_bank/view/create_customer_screen/create_cusomer_screen.dart';
import 'package:book_bank/view/monthly_data_input_screen/montly_data_input_screen.dart';
import 'package:book_bank/view/montly_bill_generation_screen/monthly_bill_generation_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Milk Billing App'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
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

          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final customer = customers[index];
              final customerId = customer.id;
              final name = customer['name'];
              final currentBalance = customer['current_balance'];

              return FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('customers')
                    .doc(customerId)
                    .collection('monthly_data')
                    .get(),
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
                  String milkData = 'No milk data available';
                  if (milkDataDocs.isNotEmpty) {
                    final latestMilkData = milkDataDocs.last;
                    milkData = latestMilkData['milk_data'].toString();
                  }

                  return ListTile(
                    title: Text(name),
                    subtitle: Text('Milk: $milkData, Remaining: \$${currentBalance.toStringAsFixed(2)}'),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'input_data') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MonthlyDataInputScreen(
                                customerId: customerId,
                                customerName: name,
                              ),
                            ),
                          );
                        } else if (value == 'deduct_balance') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BalanceDeductionScreen(
                                customerId: customerId,
                                customerName: name,
                                currentBalance: currentBalance,
                              ),
                            ),
                          );
                        } else if (value == 'generate_bill') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BillGenerationScreen(),
                            ),
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'input_data',
                          child: Text('Input Monthly Data'),
                        ),
                        PopupMenuItem<String>(
                          value: 'deduct_balance',
                          child: Text('Deduct Balance'),
                        ),
                        PopupMenuItem<String>(
                          value: 'generate_bill',
                          child: Text('Generate Bill'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
