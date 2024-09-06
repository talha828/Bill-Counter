import 'dart:ffi';

import 'package:book_bank/components/widgets/btextfield.dart';
import 'package:book_bank/firebase/auth.dart';
import 'package:book_bank/view/sign_up_screen/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddCustomerScreen extends StatefulWidget {
  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {

  final _nameController = TextEditingController();
  final _preBalanceController = TextEditingController();
  List<List<int>> milkEntries = [];
  int getDaysInMonth(String monthYear) {
    List<String> parts = monthYear.split(' - ');
    String monthName = parts[0];
    int year = int.parse(parts[1]);

    Map<String, int> monthMap = {
      'January': 1,
      'February': 2,
      'March': 3,
      'April': 4,
      'May': 5,
      'June': 6,
      'July': 7,
      'August': 8,
      'September': 9,
      'October': 10,
      'November': 11,
      'December': 12
    };

    int month = monthMap[monthName]!;

    DateTime firstDayOfNextMonth = DateTime(year, month + 1, 1);
    int daysInMonth = firstDayOfNextMonth.subtract(Duration(days: 1)).day;

    return daysInMonth;
  }

  void _saveCustomer() {
    final String name = _nameController.text;
    FirebaseFirestore.instance.collection('customers').add({
      'name': name,
    }).then((value) {
      FirebaseFirestore.instance
          .collection('customers')
          .doc(value.id)
          .collection('monthly data')
          .doc(Auth.getCurrentDateFormatted())
          .set({
        "milk_entries": milkEntries.map((entry) => entry[0]).toList(),
        "total_milk": 00,
        "previous_amount": _preBalanceController.text,
        "summary": "aa:(0-0):00",
      }).then((_){
        Navigator.of(context).pop();
      });
    });
  }

  setEntriesCount(){
    setState(() {
      int daysInSelectedMonth = getDaysInMonth(Auth.getCurrentDateFormatted());
      milkEntries = List.generate(daysInSelectedMonth, (index) => [0]);
    });
  }
  @override
  void initState() {
    setEntriesCount();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BTextField(
              controller: _nameController,
              hintText: 'Hamza',
              labelText: "Customer Name",
              obscureText: false,
            ),
            SizedBox(height: width * 0.04),
            BTextField(
              hintText: "1000",
              labelText: "Previous Balance",
              obscureText: false,
              controller: _preBalanceController,
            ),

            SizedBox(height: width * 0.15),
            Bbutton(
              width: width,
              onTap: _saveCustomer,
              title: 'Save Customer',
            ),
          ],
        ),
      ),
    );
  }
}
