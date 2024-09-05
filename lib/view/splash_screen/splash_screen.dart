import  'dart:async';

import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/firebase/auth.dart';
import 'package:book_bank/view/get_start_screen/get_start_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/assets.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;
  @override
  void initState() {
    _checkCredentialsAndLogin();
    super.initState();
  }
  void _checkCredentialsAndLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString("email");
    String? savedPassword = prefs.getString("password");


    if (savedEmail != null && savedPassword != null) {
      Auth.login(
        email: savedEmail,
        password: savedPassword,
        width: 350,
        setLoading: (bool value) {
          setState(() {
            isLoading = value;
          });
        },
      );
    } else {
      Timer(const Duration(seconds: 2), () => Get.to(const GetStartScreen()));
    }
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: appThemeColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              Assets.logoLogo,
              scale: 2.5,
            ),
          ],
        ),
      ),
    );
  }
}
