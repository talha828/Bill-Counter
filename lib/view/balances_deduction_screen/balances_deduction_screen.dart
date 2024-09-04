import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BalanceDeductionScreen extends StatefulWidget {
  final String customerId;
  final String customerName;
  final double currentBalance;

  BalanceDeductionScreen({required this.customerId, required this.customerName, required this.currentBalance});

  @override
  _BalanceDeductionScreenState createState() => _BalanceDeductionScreenState();
}

class _BalanceDeductionScreenState extends State<BalanceDeductionScreen> {
  final _amountReceivedController = TextEditingController();

  void _deductBalance() async {
    final double amountReceived = double.parse(_amountReceivedController.text);

    final newBalance = widget.currentBalance - amountReceived;

    FirebaseFirestore.instance.collection('customers').doc(widget.customerId).update({
      'current_balance': newBalance,
    }).then((_) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deduct Balance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Customer: ${widget.customerName}'),
            Text('Current Balance: ${widget.currentBalance}'),
            TextField(
              controller: _amountReceivedController,
              decoration: InputDecoration(labelText: 'Amount Received'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deductBalance,
              child: Text('Deduct Balance'),
            ),
          ],
        ),
      ),
    );
  }
}
