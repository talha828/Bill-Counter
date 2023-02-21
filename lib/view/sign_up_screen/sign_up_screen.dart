import 'dart:io';

import 'package:book_bank/generated/assets.dart';
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
                          final XFile? image =
                              await _picker.pickImage(source: ImageSource.gallery);
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
                      "Sign Up",
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
                    InkWell(
                      onTap: () => showCountryPicker(
                        context: context,
                        showPhoneCode:
                            true, // optional. Shows phone code before the country name.
                        onSelect: (country) {
                          print('Select country: ${country.displayName}');
                          countryText = country.displayName;
                        },
                      ),
                      child: IgnorePointer(
                          ignoring: true,
                          child: BTextField(
                              obscureText: false,
                              controller: country,
                              hintText: "Talha Iqbal",
                              labelText: countryText)),
                    ),
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
                    ElevatedButton(
                        onPressed: () async {
                          if (flag == false) {
                            if (Validate.isValidEmail(email.text)) {
                              if (countryText != 'Select Your Country') {
                                if (Validate.isValidPassword(password.text)) {
                                  if (password.text == confirmPassword.text) {
                                    setLoading(true);
                                    FirebaseAuth auth = FirebaseAuth.instance;
                                    await auth
                                        .createUserWithEmailAndPassword(
                                            email: email.text,
                                            password: password.text)
                                        .then((value) async {
                                      var database = FirebaseFirestore.instance
                                          .collection("users");
                                      await database.doc().set({
                                        "name": name.text,
                                        "email": email.text,
                                        "country": countryText,
                                        "password": password.text,
                                        "image": Blob(file.readAsBytesSync()),
                                      }).then((value) async {
                                        setLoading(false);
                                        final prefs =
                                            await SharedPreferences.getInstance();
                                        prefs.setString("email", email.text);
                                        prefs.setString("password", password.text);
                                        Get.to(const MainScreen());
                                      }).catchError((e) {
                                        setLoading(false);
                                        Get.snackbar("Data Storing Fail",
                                            "Something went wrong,please check your internet connection",
                                            duration: const Duration(seconds: 5),
                                            snackPosition: SnackPosition.BOTTOM,
                                            margin: EdgeInsets.symmetric(
                                                vertical: width * 0.05,
                                                horizontal: width * 0.05));
                                      });
                                    }).catchError((e) {
                                      setLoading(false);
                                      Get.snackbar("Authentication Fail",
                                          "Something went wrong,please check your internet connection",
                                          duration: const Duration(seconds: 5),
                                          snackPosition: SnackPosition.BOTTOM,
                                          margin: EdgeInsets.symmetric(
                                              vertical: width * 0.05,
                                              horizontal: width * 0.05));
                                    });
                                  } else {
                                    Get.snackbar("password not match",
                                        "Fill correct password",
                                        duration: const Duration(seconds: 5),
                                        snackPosition: SnackPosition.BOTTOM,
                                        margin: EdgeInsets.symmetric(
                                            vertical: width * 0.05,
                                            horizontal: width * 0.05));
                                  }
                                } else {
                                  Get.snackbar("Incorrect password",
                                      "Min 6 and Max 12 characters At least one uppercase characterAt least one lowercase characterAt least one numberAt least one special character [@#!%?]",
                                      duration: const Duration(seconds: 5),
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin: EdgeInsets.symmetric(
                                          vertical: width * 0.05,
                                          horizontal: width * 0.05));
                                }
                              } else {
                                Get.snackbar(
                                    "Select Country", "Please select your country",
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
                          } else {
                            Get.snackbar(
                                "Image Not Found", "Please Select Your Image",
                                duration: const Duration(seconds: 5),
                                snackPosition: SnackPosition.BOTTOM,
                                margin: EdgeInsets.symmetric(
                                    vertical: width * 0.05,
                                    horizontal: width * 0.05));
                          }
                        },
                        child: const Text("SignUp Now")),
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
                          onTap: () => Get.to(const SignUpScreen()),
                          child: const Text(
                            " SignIp",
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
