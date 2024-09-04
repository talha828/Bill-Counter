import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class BillGenerationScreen extends StatelessWidget {

  // Assuming this function is within the bill generation logic
  Future<void> generateInvoicesForAllCustomers() async {
    final customersSnapshot = await FirebaseFirestore.instance.collection('customers').get();
    final customersSnapshotmonth = await FirebaseFirestore.instance.collection('customers').doc().collection("monthly_data").get();
    final customers = customersSnapshot.docs;

    final customerData = customers.map((customer) {
      return {
        'name': customer['name'],
        'milk_data': customer['monthly_data'], // Assuming you have a sub-collection or similar structure
        'current_balance': customer['current_balance'],
      };
    }).toList();

    final response = await http.post(
      Uri.parse('https://flask-api-invoice.onrender.com/generate-invoices'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'customers': customerData,
        'date': 'August - 2024', // Adjust as needed
        'company': 'Your Company Name', // Adjust as needed
        'milk_price_per_liter': 220,
      }),
    );

    if (response.statusCode == 200) {
      final pdfUrls = jsonDecode(response.body)['pdf_urls'];

      for (var i = 0; i < customers.length; i++) {
        final customerId = customers[i].id;
        final pdfUrl = pdfUrls[i];

        // Save PDF URL to Firestore
        await FirebaseFirestore.instance.collection('customers').doc(customerId).update({
          'invoice_pdf_url': pdfUrl,
        });

        // Download the PDF to local storage
        final pdfResponse = await http.get(Uri.parse(pdfUrl));
        if (pdfResponse.statusCode == 200) {
          final directory = await getApplicationDocumentsDirectory();
          final file = File('${directory.path}/invoice_$customerId.pdf');
          await file.writeAsBytes(pdfResponse.bodyBytes);
          // Handle success, e.g., show a confirmation to the user
        } else {
          // Handle PDF download failure
        }
      }
    } else {
      // Handle API request failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Invoices for All Customers'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async =>generateInvoicesForAllCustomers(),
          child: Text('Generate Invoices'),
        ),
      ),
    );
  }
}
