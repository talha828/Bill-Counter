import 'package:book_bank/view/main_screen/main_screen.dart';
import 'package:book_bank/view/sign_up_screen/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validation_plus/validate.dart';

import '../../components/constant/constant.dart';
import 'package:book_bank/generated/assets.dart';
import 'package:flutter/material.dart';

import '../../components/widgets/btextfield.dart';
import '../../components/widgets/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String hintText = "xyz01@gmail.com";
  String labelText = "Email";
  bool obscureText = true;
  bool isLoading=false;
  setLoading(bool value){
    setState(() {
      isLoading=value;
    });
  }

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
                //height:height -10,
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
                    BTextField(
                      controller: password,
                      hintText: "pass@11",
                      labelText: "Password",
                      obscureText: obscureText,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(top: width * 0.04),
                        child: InkWell(
                            onTap: () => setState(() {
                                  obscureText = obscureText ? false : true;
                                }),
                            child: FaIcon(obscureText
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash)),
                      ),
                    ),
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
                    ElevatedButton(
                        onPressed: () {
                          if (Validate.isValidEmail(email.text)) {
                            if (Validate.isValidPassword(password.text)) {
                              setLoading(true);
                              FirebaseAuth auth = FirebaseAuth.instance;
                              auth
                                  .signInWithEmailAndPassword(
                                      email: email.text, password: password.text)
                                  .then((value) async {
                                    setLoading(false);
                                final prefs = await SharedPreferences.getInstance();
                                prefs.setString("email", email.text);
                                prefs.setString("password", password.text);
                                Get.to(const MainScreen());
                              }).catchError((e) {
                                setLoading(false);
                                Get.snackbar("Login Failed",
                                    "Please check your email and password",
                                    duration: const Duration(seconds: 5),
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: EdgeInsets.symmetric(
                                        vertical: width * 0.05,
                                        horizontal: width * 0.05));
                              });
                            } else {
                              Get.snackbar("Incorrect password",
                                  "Min 6 and Max 12   At least one uppercase characterAt least one lowercase characterAt least one numberAt least one special character [@#!%?]",
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: EdgeInsets.symmetric(
                                      vertical: width * 0.05,
                                      horizontal: width * 0.05));
                            }
                          } else {
                            Get.snackbar(
                                "Invalid Email", "Please Provide Valid Email",
                                duration: const Duration(seconds: 5),
                                snackPosition: SnackPosition.BOTTOM,
                                margin: EdgeInsets.symmetric(
                                    vertical: width * 0.05,
                                    horizontal: width * 0.05));
                          }
                        },
                        child: const Text("Login Now")),
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
                          onTap: () => Get.to(const SignUpScreen()),
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
            isLoading
                ? const Positioned.fill(child: LoadingIndicator())
                : Container()
          ],
        ),
      ),
    );
  }
}
