import 'package:book_bank/view/get_start_screen/donate_your_books_screen.dart';
import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:flutter/material.dart';

import '../../components/constant/constant.dart';
import '../../generated/assets.dart';

class TradeYourBooksScreen extends StatefulWidget {
  const TradeYourBooksScreen({Key? key}) : super(key: key);

  @override
  State<TradeYourBooksScreen> createState() => _TradeYourBooksScreenState();
}

class _TradeYourBooksScreenState extends State<TradeYourBooksScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: appThemeColor,
          onPressed: () {
            Navigator.push(
              context,
              CircularClipRoute<void>(
                transitionDuration: const Duration(seconds: 1),
                expandFrom: context,
                builder: (_) => const DonateYourBooksScreen(),
              ),
            );
          },
          child: const Icon(Icons.arrow_forward_ios_outlined),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.04, horizontal: width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                Assets.imgShare,
                scale: 4,
              ),
              Text(
                "Trade Your Books",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: width * 0.07),
              ),
              const Text(
                "Looking for a way to refresh your book collection without breaking the bank? Look no further than our book trading app. With just a few clicks, you can upload the books you no longer need, and browse through the extensive selection of titles offered by fellow bookworms around the world.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
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
