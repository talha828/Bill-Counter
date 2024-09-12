import 'dart:io';
import 'dart:typed_data';

import 'package:book_bank/view/login_screen/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validation_plus/validate.dart';

import '../view/main_screen/main_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  // Method for signing up a user
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required File file,
    required double width,
  }) async {
    if (!file.existsSync()) {
      _showSnackbar(
        "Image Not Found",
        "Please Select Your Image",
        width,
      );
      return;
    }

    if (!Validate.isValidEmail(email)) {
      _showSnackbar(
        "Invalid Email",
        "Please Provide a Valid Email",
        width,
      );
      return;
    }

    if (!Validate.isValidPassword(password)) {
      _showSnackbar(
        "Incorrect Password",
        "Password must be 6-12 characters long, include an uppercase letter, a lowercase letter, a number, and a special character [@#!%?]",
        width,
      );
      return;
    }

    if (password != confirmPassword) {
      _showSnackbar(
        "Password Mismatch",
        "Please Confirm Your Password",
        width,
      );
      return;
    }

    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        "name": name,
        "email": email,
        "milk_price": 220,
        "image": Blob(file.readAsBytesSync()),
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", email);
      await prefs.setString("password", password);

      Get.offAll(MainScreen());
    } catch (e) {
      _handleAuthError(e, width);
    } finally {
      isLoading.value = false;
    }
  }

  // Method for logging in a user
  Future<void> login({
    required String email,
    required String password,
    required double width,
  }) async {
    if (!Validate.isValidEmail(email)) {
      _showSnackbar(
        "Invalid Email",
        "Please Provide a Valid Email",
        width,
      );
      return;
    }

    if (!Validate.isValidPassword(password)) {
      _showSnackbar(
        "Incorrect Password",
        "Password must be 6-12 characters long, include an uppercase letter, a lowercase letter, a number, and a special character [@#!%?]",
        width,
      );
      return;
    }

    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password).catchError((e){
        _showSnackbar("Login Failed", "Please try to login again after few time", width);
        Get.offAll(LoginScreen());
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", email);
      await prefs.setString("password", password);

      Get.offAll(MainScreen());
    } catch (e) {
      _handleAuthError(e, width);
    } finally {
      isLoading.value = false;
    }
  }

  // Helper method to display a GetX snackbar
  void _showSnackbar(String title, String message, double width) {
    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.symmetric(
        vertical: width * 0.05,
        horizontal: width * 0.05,
      ),
    );
  }

  // Helper method to handle authentication errors
  void _handleAuthError(dynamic error, double width) {
    String errorMessage = "Something went wrong, please try again.";
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case "user-not-found":
          errorMessage = "No user found for that email.";
          break;
        case "wrong-password":
          errorMessage = "Incorrect password provided.";
          break;
        case "email-already-in-use":
          errorMessage = "This email is already in use.";
          break;
        default:
          errorMessage = error.message ?? errorMessage;
      }
    }
    _showSnackbar("Authentication Failed", errorMessage, width);
  }

  Future<void> updateProfile(String name,
  String email,
      Uint8List? imageFile,) async {
    isLoading.value = true;
    try {
      // Get the user's UID
      String uid = FirebaseAuth.instance.currentUser!.uid;

      // Initialize an empty image URL




      // Update user data in Firestore
      Map<String, dynamic> updateData = {
        'name': name,
        'email': email,
        "image": Blob(imageFile!),
      };

      // Update the user's Firestore document
      await FirebaseFirestore.instance.collection('users').doc(uid).update(updateData);

      // Notify the user of success
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      // Handle errors
      Get.snackbar('Error', 'Failed to update profile: $e');
    } finally {
      // Hide the loading indicator
      isLoading.value = false;
    }
  }
}
