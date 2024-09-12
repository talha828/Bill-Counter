import 'dart:io';
import 'dart:typed_data';
import 'package:book_bank/components/constant/constant.dart';
import 'package:book_bank/components/widgets/bbutton.dart';
import 'package:book_bank/firebase/auth.dart';
import 'package:book_bank/generated/assets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/widgets/btextfield.dart';
import '../../components/widgets/loading_indicator.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final controller = Get.find<AuthController>(); // Controller for auth logic
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController milkPrice = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Uint8List? imageFile;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Fetch user data when the screen is initialized
    fetchUserData();
  }



  Future<void> fetchUserData() async {
    controller.isLoading.value = true;
    var userDoc = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    var userData = userDoc.data();
    if (userData != null) {
      name.text = userData['name'] ?? '';
      email.text = userData['email'] ?? '';
      milkPrice.text = userData['milk_price'].toString() ?? "0";
      // Handle profile image
      if (userData['image'] != null) {
        imageFile = userData['image']?.bytes;
        setState(() {});
      }
    }
    controller.isLoading.value = false;
  }

  Future<void> updateProfile() async {
    await controller.updateProfile(
      name.text,
      email.text,
      imageFile,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height-20;

    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
            leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back,color: Colors.white,)),
            backgroundColor: appThemeColor,
            title: Text("Edit Profile",style: const TextStyle(color: Colors.white),)),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: width * 0.04, horizontal: width * 0.04),
              child: Container(
                height: height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: width * 0.1),
                    InkWell(
                      onTap: () async {
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          setState(() {
                            var file = File(image.path);
                            imageFile = file.readAsBytesSync();
                          });
                        }
                      },
                      child: CircleAvatar(
                        radius: width * 0.22,
                        backgroundColor: Colors.grey,
                        backgroundImage: imageFile != null
                            ? MemoryImage(imageFile!)
                            : const AssetImage(Assets.imgProfile) as ImageProvider,
                      ),
                    ),
                    SizedBox(height: width * 0.1),
                    BTextField(
                      obscureText: false,
                      controller: name,
                      hintText: "Your Name",
                      labelText: "Name",
                    ),
                    SizedBox(height: width * 0.04),
                    BTextField(
                      obscureText: false,
                      controller: email,
                      hintText: "Your Email",
                      labelText: "Email",
                    ),
                    SizedBox(height: width * 0.04),
                    BTextField(
                      obscureText: false,
                      controller: milkPrice,
                      hintText: "220",
                      labelText: "Milk Price (L)",
                    ),
                    SizedBox(height: width * 0.3),
                    BButton(
                      onTap: updateProfile,
                      width: width,
                      title: "Update Profile",
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              if (controller.isLoading.isTrue) {
                return const Positioned.fill(child: LoadingIndicator());
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}
