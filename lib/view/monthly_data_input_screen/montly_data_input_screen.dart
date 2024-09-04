import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MonthlyDataInputScreen extends StatefulWidget {
  final String customerId;
  final String customerName;

  MonthlyDataInputScreen({required this.customerId, required this.customerName});

  @override
  _MonthlyDataInputScreenState createState() => _MonthlyDataInputScreenState();
}

class _MonthlyDataInputScreenState extends State<MonthlyDataInputScreen> {
  String? selectedOption;
  String? selectedMonth;
  final milkController = TextEditingController();
  final daysController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Monthly Data for ${widget.customerName}'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('customers')
            .doc(widget.customerId)
            .collection('monthly_data')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final months = snapshot.data!.docs;
          List<String> options = ['Start New Month'];

          if (months.isNotEmpty) {
            options.insert(0, 'Add to Existing Month');
          }

          return Column(
            children: [
              DropdownButton<String>(
                hint: Text('Select Option'),
                value: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                    if (value == 'Add to Existing Month') {
                      selectedMonth = months.last.id;
                    } else {
                      selectedMonth = null;
                    }
                  });
                },
                items: options.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
              ),
              if (selectedOption == 'Add to Existing Month')
                DropdownButton<String>(
                  hint: Text('Select Month to Edit'),
                  value: selectedMonth,
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value;
                    });
                  },
                  items: months.map((month) {
                    return DropdownMenuItem(
                      value: month.id,
                      child: Text(month.id), // Month as ID
                    );
                  }).toList(),
                ),
              TextField(
                controller: daysController,
                decoration: InputDecoration(labelText: 'Day Count'),
              ),
              TextField(
                controller: milkController,
                decoration: InputDecoration(labelText: 'Milk Quantity'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Save data to Firestore
                  String month = selectedMonth ?? DateTime.now().month.toString();
                  FirebaseFirestore.instance
                      .collection('customers')
                      .doc(widget.customerId)
                      .collection('monthly_data')
                      .doc(month)
                      .update({
                    'milk_data': FieldValue.arrayUnion([
                      '(${daysController.text}-${milkController.text})'
                    ]),
                  })
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Data Updated Successfully')),
                    );
                  });
                },
                child: Text('Save Data'),
              ),
            ],
          );
        },
      ),
    );
  }
}
