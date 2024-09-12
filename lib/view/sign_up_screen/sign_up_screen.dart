import 'dart:io';
import 'package:book_bank/components/widgets/bbutton.dart';
import 'package:book_bank/firebase/auth.dart';
import 'package:book_bank/generated/assets.dart';
import 'package:book_bank/view/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/widgets/btextfield.dart';
import '../../components/widgets/loading_indicator.dart';
class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final AuthController controller = Get.find<AuthController>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final Rx<File?> file = Rx<File?>(null); // Rx to make the file reactive
  final RxBool obscureText = true.obs; // Reactive password visibility toggle

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: width * 0.04,
                  horizontal: width * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: width * 0.1),
                    // Profile Image Section
                    Obx(() => InkWell(
                      onTap: () async {
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          file.value = File(image.path);
                        }
                      },
                      child: file.value == null
                          ? Image.asset(
                        Assets.imgProfile,
                        width: width * 0.4,
                        height: width * 0.4,
                      )
                          : CircleAvatar(
                        radius: width * 0.22,
                        backgroundImage:
                        FileImage(file.value!),
                      ),
                    )),
                    SizedBox(height: width * 0.1),
                    // Sign Up Text
                    Text(
                      "SIGN UP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.08,
                      ),
                    ),
                    SizedBox(height: width * 0.1),
                    // Name Input Field
                    BTextField(
                      obscureText: false,
                      controller: name,
                      hintText: "Talha Iqbal",
                      labelText: "Name",
                    ),
                    SizedBox(height: width * 0.04),
                    // Email Input Field
                    BTextField(
                      obscureText: false,
                      controller: email,
                      hintText: "xyz01@gmail.com",
                      labelText: "Email",
                    ),
                    SizedBox(height: width * 0.04),
                    // Password Input Field with Toggle
                    Obx(() => BTextField(
                      controller: password,
                      obscureText: obscureText.value,
                      hintText: "pass@11",
                      labelText: "Password",
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(top: width * 0.04),
                        child: InkWell(
                          onTap: () => obscureText.value =
                          !obscureText.value,
                          child: FaIcon(obscureText.value
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash),
                        ),
                      ),
                    )),
                    SizedBox(height: width * 0.04),
                    // Confirm Password Input Field
                    Obx(() => BTextField(
                      obscureText: obscureText.value,
                      controller: confirmPassword,
                      hintText: "pass@11",
                      labelText: "Confirm Password",
                    )),
                    SizedBox(height: width * 0.1),
                    // Sign Up Button
                    BButton(
                      onTap: () async {
                        controller.signUp(
                          name: name.text,
                          email: email.text,
                          password: password.text,
                          confirmPassword: confirmPassword.text,
                          file: file.value!,
                          width: width,
                        );
                      },
                      width: width,
                      title: "SignUp Now",
                    ),
                    SizedBox(height: width * 0.1),
                    // Redirect to Login Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        InkWell(
                          onTap: () => Get.to(LoginScreen()),
                          child: const Text(
                            " Login",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Loading Indicator
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