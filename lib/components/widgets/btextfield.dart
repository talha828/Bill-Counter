import 'package:flutter/material.dart';

import '../constant/constant.dart';

class BTextField extends StatelessWidget {
   BTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    this.suffixIcon,
    this.keyboardType
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String labelText;
   bool  obscureText=false;
   Widget? suffixIcon;
   TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      obscureText:obscureText,
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide:  BorderSide(color: Colors.teal)),
          hintText: hintText,
          labelText:labelText,
          suffixIcon:suffixIcon,
          suffixStyle: const TextStyle(color: appThemeColor)),
    );
  }
}
