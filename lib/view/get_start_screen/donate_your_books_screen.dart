import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/constant/constant.dart';
import '../../generated/assets.dart';
import '../login_screen/login_screen.dart';

class DonateYourBooksScreen extends StatefulWidget {
  const DonateYourBooksScreen({Key? key}) : super(key: key);

  @override
  State<DonateYourBooksScreen> createState() => _DonateYourBooksScreenState();
}

class _DonateYourBooksScreenState extends State<DonateYourBooksScreen> {
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
            Get.to(const LoginScreen());
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
                "Donate Your Books",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.07),
              ),
              const Text(
                "Clear your bookshelf and make a difference by donating your books through our app. Easy, convenient, and for a good cause.Make an impact by donating your books through our app - it's simple, convenient, and helps spread the joy of reading to others.",
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
