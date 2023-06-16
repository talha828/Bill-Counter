import  'dart:async';

import 'package:book_bank/view/get_start_screen/get_start_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/assets.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
} // ye hai tumhari screen , wo main screen homescreen wahan route karna hai route laga diya hai likn splash screen say code agaye nahi ja rha hai
  // get start  per nh ja raha?
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () => Get.to(const GetStartScreen()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              Assets.logoLogo,
              scale: 1.7,
            ),
          ],
        ),
      ),
    );
  }
}
