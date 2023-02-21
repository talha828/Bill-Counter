import 'package:book_bank/components/constant/constant.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      child: const Center(
        child: CircularProgressIndicator(
          color: appThemeColor,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
