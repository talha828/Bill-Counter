import 'package:book_bank/components/constant/constant.dart';
import 'package:flutter/material.dart';

class BButton extends StatelessWidget {
  const BButton({
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
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}