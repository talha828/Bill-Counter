import 'package:book_bank/generated/assets.dart';
import 'package:book_bank/view/get_start_screen/trade_your_books_screen.dart';
import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:flutter/material.dart';

import '../../components/constant/constant.dart';

class GetStartScreen extends StatefulWidget {
  const GetStartScreen({Key? key}) : super(key: key);

  @override
  State<GetStartScreen> createState() => _GetStartScreenState();
}

class _GetStartScreenState extends State<GetStartScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                CircularClipRoute<void>(
                  reverseCurve: Curves.easeInOutCirc,
                  curve: Curves.easeInCirc,
                  transitionDuration: const Duration(milliseconds: 700),
                  expandFrom: context,
                  builder: (_) => const TradeYourBooksScreen(),
                ));
          },
          child: const Icon(
            Icons.arrow_forward_ios_outlined,
            color: appThemeColor,
          ),
        ),
        body: Container(
          color: appThemeColor.withOpacity(0.7),
          padding: EdgeInsets.symmetric(
              vertical: width * 0.04, horizontal: width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                Assets.imgTrade,
                scale: 4,
              ),
              Text(
                "Welcome To Book Bank",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.07),
              ),
              const Text(
                "Welcome to our book bank app! Trade your books with fellow book lovers from around the world. Create an account, upload your books, and start exchanging. Happy reading!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: width * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
