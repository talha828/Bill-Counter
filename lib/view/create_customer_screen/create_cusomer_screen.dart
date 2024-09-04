import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCustomerScreen extends StatefulWidget {
  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _nameController = TextEditingController();
  final _initialBalanceController = TextEditingController();

  void _saveCustomer() {
    final String name = _nameController.text;
    final double initialBalance = double.parse(_initialBalanceController.text);

    FirebaseFirestore.instance.collection('customers').add({
      'name': name,
      'initial_balance': initialBalance,
      'current_balance': initialBalance,
    }).then((_) {
      Navigator.of(context).pop();
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
              controller: _initialBalanceController,
              decoration: InputDecoration(labelText: 'Initial Balance'),
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
