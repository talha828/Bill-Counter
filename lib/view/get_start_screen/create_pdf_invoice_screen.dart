import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/constant/constant.dart';
import '../../generated/assets.dart';
import '../login_screen/login_screen.dart';

class CreatePDFInvoiceScreen extends StatefulWidget {
  const CreatePDFInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<CreatePDFInvoiceScreen> createState() => _CreatePDFInvoiceScreenState();
}

class _CreatePDFInvoiceScreenState extends State<CreatePDFInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: Colors.white,
          onPressed: () {
            Get.to(LoginScreen());
          },
          child: const Icon(
            Icons.arrow_forward_ios_outlined,
            color: appThemeColor,
          ),
        ),
        body: Container(
          color: appThemeColor.withOpacity(0.7),
          padding: EdgeInsets.symmetric(
              vertical: width * 0.04, horizontal: width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                Assets.imgGift,
                scale: 4,
              ),
              Text(
                "Create PDF Invoice",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.07),
              ),
              const Text(
                "Generate professional invoices quickly and effortlessly. Input your customer details, itemize services or products, and instantly create a polished PDF invoice. Save time and keep your records organized with ease",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: width * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
