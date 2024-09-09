import 'package:book_bank/generated/assets.dart';
import 'package:book_bank/view/get_start_screen/create_and_save_customer_screen.dart';
import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:flutter/material.dart';

import '../../components/constant/constant.dart';

class GetStartScreen extends StatefulWidget {
  static const String id = 'getstartscreen';
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
                  builder: (_) => const CreateAndSaveCustomerScreen(),
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
                "Welcome To Bill Counter",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.07),
              ),
              const Text(
                "Welcome to our Milk Billing app! Easily manage your customers' milk deliveries and generate PDF invoices with just a few taps. Track daily milk quantities, calculate totals, and store everything securely in Firestore. Simplify your billing process today!",
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




// The code you provided is for the GetStartScreen widget, which is a stateful widget in Flutter. Let's go through the code and explain it in detail:
//
// The GetStartScreen widget extends the StatefulWidget class, indicating that it has mutable state.
// The _GetStartScreenState class is the associated state class for the GetStartScreen widget. It extends the State class and overrides the build method, which is responsible for creating the widget's UI.
// In the build method, the MediaQuery class is used to obtain the width of the device's screen.
// The SafeArea widget ensures that the content is displayed within the safe area of the device, avoiding any notches or system UI elements.
// The Scaffold widget is a container for the app's layout structure and provides functionality like app bars, floating action buttons, etc.
// The floatingActionButton property of the Scaffold widget defines a floating action button that triggers a navigation to the TradeYourBooksScreen when pressed. The animation for the navigation is achieved using the CircularClipRoute package.
// The body property of the Scaffold widget contains the main content of the screen.
// The Container widget serves as the background of the screen. It has a semi-transparent color using the appThemeColor variable from the constant.dart file and padding specified.
// Inside the Container, a Column widget is used to arrange the child widgets vertically with equal spacing.
// The Image.asset widget displays an image loaded from the Assets.imgTrade asset. The scale property is set to 4, indicating that the image should be scaled by a factor of 4.
// The Text widget displays the "Welcome To Book Bank" text in the center. It has a custom style defined with white color, bold font weight, and font size calculated based on the screen width.
// The second Text widget displays a welcome message for the app, explaining its purpose. It has a white color and is centered.
// The final SizedBox widget adds some empty space at the bottom of the screen.
// Overall, the code sets up a screen with a background color, an image, and some text to welcome users to the Book Bank app. It also includes a floating action button that triggers navigation to the TradeYourBooksScreen when pressed.