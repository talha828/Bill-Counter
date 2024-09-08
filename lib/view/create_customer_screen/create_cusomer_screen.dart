import 'dart:ffi';

import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/components/widgets/btextfield.dart';
import 'package:book_bank/firebase/auth.dart';
import 'package:book_bank/helper/helper.dart';
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
  bool isLoading = false;
  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }


  void _saveCustomer() {
    setLoading(true);
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
        setLoading(false);
        Navigator.of(context).pop();
      }).catchError((e){setLoading(false);});
    });
  }

  setEntriesCount() => setState(() => milkEntries = List.generate(Helper.getDaysInMonth(Auth.getCurrentDateFormatted()), (index) => [0]));
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
        backgroundColor: appThemeColor,
        title:const Text('Create Customer',style: TextStyle(color: Colors.white),),
      ),
      body: Stack(
        children: [
          Padding(
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
        ],
      ),
    );
  }
}
