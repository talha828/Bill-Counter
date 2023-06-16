import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validation_plus/validate.dart';

import '../screens/homescreen/homescreen2.dart';
import '../view/main_screen/main_screen.dart';

class Auth {
  static signUp(
      {required String name,
      required String email,
      required String country,
      required String password,
      required String confirmPassword,
      required File file,
      required bool flag,
      required double width,
      var setLoading}) async {
    if (flag == false) {
      if (Validate.isValidEmail(email)) {
        if (country != 'Select Your Country') {
          if (Validate.isValidPassword(password)) {
            if (password == confirmPassword) {
              setLoading(true);
              FirebaseAuth auth = FirebaseAuth.instance;
              await auth
                  .createUserWithEmailAndPassword(
                      email: email, password: password)
                  .then((value) async {
                var database = FirebaseFirestore.instance.collection("users");
                await database.doc().set({
                  "name": name,
                  "email": email,
                  "country": country,
                  "password": password,
                  "image": Blob(file.readAsBytesSync()),
                }).then((value) async {
                  setLoading(false);
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString("email", email);
                  prefs.setString("password", password);
                  Get.to( homescreen2());
                }).catchError((e) {
                  setLoading(false);
                  Get.snackbar("Data Storing Fail",
                      "Something went wrong,please check your internet connection",
                      duration: const Duration(seconds: 5),
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.symmetric(
                          vertical: width * 0.05, horizontal: width * 0.05));
                });
              }).catchError((e) {
                setLoading(false);
                Get.snackbar("Authentication Fail",
                    "Something went wrong,please check your internet connection",
                    duration: const Duration(seconds: 5),
                    snackPosition: SnackPosition.BOTTOM,
                    margin: EdgeInsets.symmetric(
                        vertical: width * 0.05, horizontal: width * 0.05));
              });
            } else {
              Get.snackbar("password not match", "Fill correct password",
                  duration: const Duration(seconds: 5),
                  snackPosition: SnackPosition.BOTTOM,
                  margin: EdgeInsets.symmetric(
                      vertical: width * 0.05, horizontal: width * 0.05));
            }
          } else {
            Get.snackbar("Incorrect password",
                "Min 6 and Max 12 characters At least one uppercase characterAt least one lowercase characterAt least one numberAt least one special character [@#!%?]",
                duration: const Duration(seconds: 5),
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.symmetric(
                    vertical: width * 0.05, horizontal: width * 0.05));
          }
        } else {
          Get.snackbar("Select Country", "Please select your country",
              duration: const Duration(seconds: 5),
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.symmetric(
                  vertical: width * 0.05, horizontal: width * 0.05));
        }
      } else {
        Get.snackbar("Invalid Email", "Please Provide Valid Email",
            duration: const Duration(seconds: 5),
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.symmetric(
                vertical: width * 0.05, horizontal: width * 0.05));
      }
    } else {
      Get.snackbar("Image Not Found", "Please Select Your Image",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.symmetric(
              vertical: width * 0.05, horizontal: width * 0.05));
    }
  }

  static login(
      {required String email,
      required String password,
      var setLoading,
      required double width}) {
    if (Validate.isValidEmail(email)) {
      if (Validate.isValidPassword(password)) {
        setLoading(true);
        FirebaseAuth auth = FirebaseAuth.instance;
        auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          setLoading(false);
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("email", email);
          prefs.setString("password", password);
          Get.to( homescreen2());
        }).catchError((e) {
          setLoading(false);
          Get.snackbar("Login Failed", "Please check your email and password",
              duration: const Duration(seconds: 5),
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.symmetric(
                  vertical: width * 0.05, horizontal: width * 0.05));
        });
      } else {
        Get.snackbar("Incorrect password",
            "Min 6 and Max 12   At least one uppercase characterAt least one lowercase characterAt least one numberAt least one special character [@#!%?]",
            duration: const Duration(seconds: 5),
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.symmetric(
                vertical: width * 0.05, horizontal: width * 0.05));
      }
    } else {
      Get.snackbar("Invalid Email", "Please Provide Valid Email",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.symmetric(
              vertical: width * 0.05, horizontal: width * 0.05));
    }
  }
}
