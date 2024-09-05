import 'dart:ffi';

import 'package:book_bank/firebase/auth.dart';
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
  final _curBalanceController = TextEditingController();
  TextEditingController _totalBalanceController = TextEditingController();


  void _saveCustomer() {
    final String name = _nameController.text;
    final double preBalance = double.parse(_preBalanceController.text);
    final double curBalance = double.parse(_curBalanceController.text);
    final double totalBalance = double.parse(_totalBalanceController.text);

    FirebaseFirestore.instance.collection('customers').add({
      'name': name,
    }).then((value) {

      FirebaseFirestore.instance.collection('customers').doc(value.id).collection("monthly data").doc(Auth.getCurrentDateFormatted()).set({
        'previous_balance': preBalance,
        'current_balance': curBalance,
        'total_balance': totalBalance,
        'milk_data': "(0-0)",
      }).then((_){
        Navigator.of(context).pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Customer Name'),
            ),
            TextField(
              onChanged: (text){
                setState(() {
                  _totalBalanceController = TextEditingController(text: text);
                });
              },
              controller: _preBalanceController,
              decoration: InputDecoration(labelText: 'previous Balance'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              onChanged: (text){
                int total = int.parse(_preBalanceController.text) + int.parse(_curBalanceController.text);
                setState(() {
                  _totalBalanceController = TextEditingController(text: total.toString());
                });
              },
              controller: _curBalanceController,
              decoration: InputDecoration(labelText: 'current Balance'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _totalBalanceController,
              decoration: InputDecoration(labelText: 'total Balance'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveCustomer,
              child: Text('Save Customer'),
            ),
          ],
        ),
      ),
    );
  }
}
