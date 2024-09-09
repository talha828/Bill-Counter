import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/components/widgets/btextfield.dart';
import 'package:book_bank/components/widgets/loading_indicator.dart';
import 'package:book_bank/view/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MonthlyDataInputScreen extends StatefulWidget {
  final String customerId;
  final String selectedMonth; // in "July - 2024" format
  final String customerName;

  const MonthlyDataInputScreen({
    super.key,
    required this.customerId,
    required this.selectedMonth,
    required this.customerName,
  });

  @override
  State<MonthlyDataInputScreen> createState() => _MonthlyDataInputScreenState();
}

class _MonthlyDataInputScreenState extends State<MonthlyDataInputScreen> {
  final TextEditingController _previousAmount = TextEditingController();
  final TextEditingController _receivedAmount = TextEditingController();
  List<List<double>> milkEntries = [];
  double totalMilk = 0;
  int previousAmount = 0;
  String summary = "";

  bool isSwiping = false;
  double swipeValue = 0;

  // Function to calculate the total milk
  void calculateTotal() {
    setState(() {
      totalMilk = milkEntries.fold(0, (double sum, entry) => double.parse((sum + entry[0]).toString()));
    });
  }

  bool isLoading = false;
  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  // Handle swipe fill
  void handleSwipe(int index) {
    if (isSwiping) {
      setState(() {
        milkEntries[index][0] = swipeValue;
        calculateTotal();
      });
    }
  }

  // Function to save data to Firebase
  void saveData() {
    setLoading(true);
    String name = widget.customerName;
    List<String> groupedEntries = [];
    int previousAmount = this.previousAmount;

    // Group consecutive similar entries
    double currentQuantity = milkEntries[0][0];
    int startDay = 1;
    int count = 1;

    for (int i = 1; i < milkEntries.length; i++) {
      if (milkEntries[i][0] == currentQuantity) {
        count++;
      } else {
        groupedEntries.add("($currentQuantity-${startDay + count - 1})");
        currentQuantity = milkEntries[i][0];
        startDay = 1;
        count = 1;
      }
    }

    // Handle the final group
    groupedEntries.add("($currentQuantity-${startDay + count - 1})");

    // Create summary string
    String summary =
        "$name:${groupedEntries.join('')}:${int.parse(_previousAmount.text) - int.parse(_previousAmount.text)}";

    // Save to Firebase
    FirebaseFirestore.instance
        .collection('customers')
        .doc(widget.customerId)
        .collection('monthly data')
        .doc(widget.selectedMonth)
        .update({
      "milk_entries": milkEntries.map((entry) => entry[0]).toList(),
      "total_milk": totalMilk,
      "received_amount": _receivedAmount.text,
      "previous_amount": _previousAmount.text,
      "summary": summary,
    }).then((_) {
      setLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data saved successfully!')));
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.pop(context);
      });
    }).catchError((error) {
      setLoading(false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to save data: $error')));
    });
  }

  // Fetch data from Firebase on screen load
  void fetchData() async {
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('customers')
        .doc(widget.customerId)
        .collection('monthly data')
        .doc(widget.selectedMonth)
        .get();

    if (document.exists) {
      setState(() {
        _previousAmount.text =
            (document.get('previous_amount') ?? 0).toString();
        _receivedAmount.text =
            (document.get('received_amount') ?? 0).toString();
        List<dynamic> entries = document.get('milk_entries') ?? [];
        milkEntries = List.generate(entries.length, (i) => [double.parse(entries[i].toString())]);
        calculateTotal();
      });
    }
  }

  // Function to get the number of days in a month
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

    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime firstDayOfNextMonth = DateTime(year, month + 1, 1);
    int daysInMonth = firstDayOfNextMonth.subtract(const Duration(days: 1)).day;

    return daysInMonth;
  }

  @override
  void initState() {
    super.initState();
    int daysInSelectedMonth = getDaysInMonth(widget.selectedMonth);
    milkEntries = List.generate(daysInSelectedMonth, (index) => [0]);
    fetchData();
  }

  // Function to edit a specific cell
  void editCell(int index) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller =
            TextEditingController(text: milkEntries[index][0].toString());
        return AlertDialog(
          title: Text("Edit Milk Quantity for Day ${index + 1}"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(labelText: 'Milk Quantity (Liters)'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  milkEntries[index][0] = double.tryParse(controller.text) ?? 0;
                  calculateTotal();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Function to refill the previous entry on a single tap
  void refillPreviousEntry(int index) {
    if (index > 0) {
      setState(() {
        milkEntries[index][0] = milkEntries[index - 1][0];
        calculateTotal();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customerName.toUpperCase()),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Previous Amount Input
                  BTextField(
                      controller: _previousAmount,
                      hintText: "27000",
                      labelText: "Previous Amount",
                      obscureText: false),
                  SizedBox(height: width * 0.04),
                  BTextField(
                      controller: _receivedAmount,
                      hintText: "1000",
                      labelText: "Received Amount",
                      obscureText: false),
                  SizedBox(height: width * 0.04),


                  // Milk Entries Grid (Editable Cells)
                  GridView.builder(
                    physics:const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // Two rows
                      childAspectRatio: 1, // Adjust height to make rows taller
                    ),
                    itemCount: milkEntries.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () =>
                            refillPreviousEntry(index), // Refill on single tap
                        onDoubleTap: () =>
                            editCell(index), // Edit on double tap
                        child: Container(
                          color: milkEntries[index][0] == 0
                              ? Colors.white
                              : appThemeColor.withOpacity(0.5),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Day ${index + 1}",
                                  style: TextStyle(
                                      color: milkEntries[index][0] == 0
                                          ? Colors.black
                                          : Colors.black),
                                ), // Show the date
                                Text(
                                  "${milkEntries[index][0]} L",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: milkEntries[index][0] == 0
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: width * 0.04,),
                  Bbutton(
                      onTap: saveData,
                      width: width,
                      title: "Save Now  ( $totalMilk ) L"),
                ],
              ),
            ),
          ),
          isLoading
              ? const Positioned.fill(child: LoadingIndicator())
              : Container()
        ],
      ),
    );
  }
}
