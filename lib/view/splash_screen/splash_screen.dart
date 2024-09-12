import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/model/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/assets.dart';
class SplashScreen extends StatelessWidget {
   SplashScreen({super.key}); // Initialize controller
  final SplashScreenController controller = Get.put(SplashScreenController());


  @override
  Widget build(BuildContext context) {
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
            ), // Empty container if not loading
          ],
        ),
      ),
    );
  }
}