import 'package:book_bank/view/get_start_screen/create_pdf_invoice_screen.dart';
import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:flutter/material.dart';

import '../../components/constant/constant.dart';
import '../../generated/assets.dart';

class CreateAndSaveCustomerScreen extends StatefulWidget {
  const CreateAndSaveCustomerScreen({Key? key}) : super(key: key);

  @override
  State<CreateAndSaveCustomerScreen> createState() => _CreateAndSaveCustomerScreenState();
}

class _CreateAndSaveCustomerScreenState extends State<CreateAndSaveCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: appThemeColor,
          onPressed: () {
            Navigator.push(
              context,
              CircularClipRoute<void>(
                transitionDuration: const Duration(seconds: 1),
                expandFrom: context,
                builder: (_) => const CreatePDFInvoiceScreen(),
              ),
            );
          },
          child: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.04, horizontal: width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                Assets.imgShare,
                scale: 4,
              ),
              Text(
                "Create And Save Customer",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: width * 0.07),
              ),
              const Text(
                "Easily create and save customer profiles with just a few clicks. Store essential information securely and access it anytime. Simplify your customer management and keep everything organized!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
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
