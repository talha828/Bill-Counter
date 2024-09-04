import 'dart:io';

import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/firebase/auth.dart';
import 'package:book_bank/generated/assets.dart';
import 'package:book_bank/view/login_screen/login_screen.dart';
import 'package:book_bank/view/main_screen/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validation_plus/validate.dart';

import '../../components/widgets/btextfield.dart';
import '../../components/widgets/loading_indicator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String hintText = "xyz01@gmail.com";
  String labelText = "Email";
  String countryText = 'Select Your Country';
  bool obscureText = true;
  bool flag = true;
  File file = File("sss");
  bool isLoading = false;
  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void Function()? onTap = () {};
  String title = "SignUp Now";

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
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.04, horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: width * 0.1,
                    ),
                    InkWell(
                        onTap: () async {
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            file = File(image!.path);
                            flag = false;
                          });
                        },
                        child: flag
                            ? Image.asset(
                                Assets.imgProfile,
                                width: width * 0.4,
                                height: width * 0.4,
                              )
                            : CircleAvatar(
                                radius: width * 0.22,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.memory(
                                      file.readAsBytesSync(),
                                      fit: BoxFit.fill,
                                    )))),
                    SizedBox(
                      height: width * 0.1,
                    ),
                    Text(
                      "SIGN UP",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: width * 0.08),
                    ),
                    SizedBox(
                      height: width * 0.1,
                    ),
                    BTextField(
                        obscureText: false,
                        controller: name,
                        hintText: "Talha Iqbal",
                        labelText: "Name"),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    BTextField(
                        obscureText: false,
                        controller: email,
                        hintText: "xzy01@gmail.com",
                        labelText: "Email"),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    BTextField(
                      obscureText: obscureText,
                      controller: password,
                      hintText: "pass@11",
                      labelText: "Password",
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
                      height: width * 0.04,
                    ),
                    BTextField(
                        obscureText: obscureText,
                        controller: confirmPassword,
                        hintText: "pass@11",
                        labelText: "Confirm Password"),
                    SizedBox(
                      height: width * 0.1,
                    ),
                    Bbutton(
                        onTap: ()async=>Auth.signUp(
                            name: name.text,
                            email: email.text,
                            password: password.text,
                            confirmPassword: confirmPassword.text,
                            file: file,
                            flag: flag,
                            width: width,
                            setLoading: (bool value) {
                              setState(() {
                                isLoading = value;
                              });
                            }),
                        width: width,
                        title: title),
                    SizedBox(
                      height: width * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.grey),
                        ),
                        InkWell(
                          onTap: () => Get.to(const LoginScreen()),
                          child: const Text(
                            " Login",
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

class Bbutton extends StatelessWidget {
  const Bbutton({
    super.key,
    required this.onTap,
    required this.width,
    required this.title,
  });

  final void Function()? onTap;
  final double width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: width * 0.04),
        decoration: BoxDecoration(
            color: appThemeColor, borderRadius: BorderRadius.circular(10)),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
