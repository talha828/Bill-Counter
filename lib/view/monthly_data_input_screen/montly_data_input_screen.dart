import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MonthlyDataInputScreen extends StatefulWidget {
  final String customerId;
  final String customerName;

  MonthlyDataInputScreen(
      {required this.customerId, required this.customerName});

  @override
  _MonthlyDataInputScreenState createState() => _MonthlyDataInputScreenState();
}

class _MonthlyDataInputScreenState extends State<MonthlyDataInputScreen> {
  String? selectedOption;
  String? selectedMonth;
  double previous = 0.0;
  double current = 0.0;
  double total = 0.0;
  final milkController = TextEditingController();
  final daysController = TextEditingController();
  final _preBalanceController = TextEditingController();
  final _curBalanceController = TextEditingController();
  TextEditingController _totalBalanceController = TextEditingController();
  TextEditingController _receviedBalanceController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _fetchBalances();
  }

  Future<void> _fetchBalances() async {
    final customerDoc = await FirebaseFirestore.instance
        .collection('customers')
        .doc(widget.customerId)
        .collection("monthly data")
        .get();
    final dd = customerDoc.docs.last;

    setState(() {
      _curBalanceController.text = (dd['current_balance'] ?? 0.0).toString();
      _preBalanceController.text = (dd['previous_balance'] ?? 0.0).toString();
      _totalBalanceController.text = (dd['total_balance'] ?? 0.0).toString();
      previous = dd['previous_balance'] ?? 0.0;
      current = dd['current_balance'] ?? 0.0;
      total = dd['total_balance'] ?? 0.0;
    });
  }

  Future<void> _updateBalances() async {
    await FirebaseFirestore.instance
        .collection('customers')
        .doc(widget.customerId)
        .collection('monthly data')
        .doc(selectedMonth)
        .update({
      'previous_balance': double.parse(_preBalanceController.text),
      'current_balance': double.parse(_curBalanceController.text),
      'total_balance': double.parse(_totalBalanceController.text),
    });
    await _fetchBalances();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.customerName} - Month Bill'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('customers')
            .doc(widget.customerId)
            .collection('monthly data')
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
              // Dropdown to select adding to the existing month or starting a new one
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

              // If "Add to Existing Month" is selected, show month selector
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

              // Current balances
              TextField(
                onChanged: (text) {
                  setState(() {
                    _totalBalanceController = TextEditingController(text: text);
                  });
                },
                controller: _preBalanceController,
                decoration: InputDecoration(labelText: 'previous Balance'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                onChanged: (text) {
                  int total = int.parse(_preBalanceController.text) +
                      int.parse(_curBalanceController.text);
                  setState(() {
                    _totalBalanceController =
                        TextEditingController(text: total.toString());
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
              TextField(
                onChanged: (text){
                  setState(() {
                    if(text.isNotEmpty){
                      if(double.parse(text) > 0){
                        _totalBalanceController.text = (total - double.parse(text)).toString();
                      }else{
                        _totalBalanceController.text = total.toString();
                      }
                    }else{
                      _totalBalanceController.text = total.toString();
                    }
                  });
                },
                controller: _receviedBalanceController,
                decoration: InputDecoration(labelText: 'total Balance'),
                keyboardType: TextInputType.number,
              ),
              // Input fields for milk and days
              TextField(
                controller: daysController,
                decoration: InputDecoration(labelText: 'Day Count'),
              ),
              TextField(
                controller: milkController,
                decoration: InputDecoration(labelText: 'Milk Quantity'),
              ),

              ElevatedButton(
                onPressed: () async {
                  final docRef = FirebaseFirestore.instance
                      .collection('customers')
                      .doc(widget.customerId)
                      .collection('monthly data')
                      .doc(selectedMonth);

                  // Check if month data exists
                  final doc = await docRef.get();
                  if (doc.exists) {
                    // Update existing month data
                    await docRef.update({
                      'milk_data': FieldValue.arrayUnion(
                          ['(${daysController.text}-${milkController.text})']),
                    });
                  } else {
                    // Create new month data
                    await docRef.set({
                      'milk_data': [
                        '(${daysController.text}-${milkController.text})'
                      ],
                    });
                  }// Update balances for next month
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Data Updated Successfully')),
                  );
                },
                child: Text('Save Data'),
              ),
              ElevatedButton(
                onPressed: () async => _updateBalances(),
                child: Text('update balances'),
              ),
              // List all months with edit/delete options
              Expanded(
                child: months.length > 0
                    ? ListView.builder(
                        itemCount: months.length,
                        itemBuilder: (context, index) {
                          final month = months[index];
                          return ListTile(
                            title: Text(month.id), // Month name
                            subtitle: Text(month['milk_data']
                                .toString()), // Show milk data
                          );
                        },
                      )
                    : ListTile(
                        title: Text(months.last.id), // Month name
                        subtitle: Text(months.last['milk_data']
                            .toString()), // Show milk data
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Edit existing month
                                setState(() {
                                  selectedMonth = months.last.id;
                                  selectedOption = 'Add to Existing Month';
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                // Delete month
                                await FirebaseFirestore.instance
                                    .collection('customers')
                                    .doc(widget.customerId)
                                    .collection('monthly data')
                                    .doc(selectedMonth)
                                    .delete();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Month Deleted')),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
