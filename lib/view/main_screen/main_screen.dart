import 'package:book_bank/view/product_from_screen/product_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../onboard_screen/onbaord_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){Get.to(const OnboardScreen());},child: const Icon(Icons.arrow_forward_ios_outlined),),
      appBar: AppBar(
        title:const Text("Happy FYP :)"),
      actions: [
        InkWell(
          onTap: (){
            Get.to(FormProduct());
          },
          child:const  Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.add),
          ),
        )
      ],
      ),
      drawer: const Drawer(),
      body: Container(),
    ));
  }
}
