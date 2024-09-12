import 'dart:async';

import 'package:book_bank/firebase/auth.dart';
import 'package:book_bank/view/get_start_screen/get_start_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  var isLoading = false.obs; // Reactive loading state

  @override
  void onInit() {
    super.onInit();
    _checkCredentialsAndLogin();
  }
  final controller = Get.put(AuthController());

  // Method to check stored credentials and perform auto-login
  Future<void> _checkCredentialsAndLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString("email");
    String? savedPassword = prefs.getString("password");

    if (savedEmail != null && savedPassword != null) {
      isLoading.value = true;
      controller.login(
        email: savedEmail,
        password: savedPassword,
        width: 350,
      );
    } else {
      Timer(const Duration(seconds: 2), () => Get.off(const GetStartScreen()));
    }
  }
}