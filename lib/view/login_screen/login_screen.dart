import 'package:book_bank/components/widgets/bbutton.dart';
import 'package:book_bank/firebase/auth.dart';
import 'package:book_bank/generated/assets.dart';
import 'package:book_bank/view/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../components/constant/constant.dart';
import '../../components/widgets/btextfield.dart';
import '../../components/widgets/loading_indicator.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final controller = Get.find<AuthController>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final String hintText = "xyz01@gmail.com";
  final String labelText = "Email";
  final RxBool obscureText = true.obs;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: height - 30,
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.04, horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: width * 0.04,
                    ),
                    Image.asset(
                      Assets.imgLogin2,
                      scale: 4,
                    ),
                    SizedBox(
                      height: width * 0.1,
                    ),
                    Text(
                      "Login",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: width * 0.08),
                    ),
                    SizedBox(
                      height: width * 0.1,
                    ),
                    BTextField(
                        obscureText: false,
                        controller: email,
                        hintText: hintText,
                        labelText: labelText),
                    SizedBox(
                      height: width * 0.05,
                    ),
                    Obx(() => BTextField(
                      controller: password,
                      obscureText: obscureText.value,
                      hintText: "pass@11",
                      labelText: "Password",
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(top: width * 0.04),
                        child: InkWell(
                          onTap: () => obscureText.value =
                          !obscureText.value,
                          child: FaIcon(obscureText.value
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash),
                        ),
                      ),
                    )),
                    SizedBox(
                      height: width * 0.06,
                    ),
                    //BTextField(controller: controller, hintText: "pass @11", labelText: "Password"),
                    const Text(
                      "Forget Password?",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: appThemeColor),
                    ),
                    SizedBox(
                      height: width * 0.1,
                    ),
                    BButton(
                      onTap: () => controller.login(
                          email: email.text,
                          password: password.text,
                          width: width,
                          ),
                      title: "Login Now",
                      width: width,
                    ),
                    SizedBox(
                      height: width * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Create an Account?",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.grey),
                        ),
                        InkWell(
                          onTap: () => Get.to(SignUpScreen()),
                          child: const Text(
                            " SignUp",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.blueAccent,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              if (controller.isLoading.isTrue) {
                return const Positioned.fill(child: LoadingIndicator());
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}
