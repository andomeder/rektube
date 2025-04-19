import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rektube/configs/colours.dart';
import 'package:rektube/controllers/auth/signup_controller.dart';
import 'package:rektube/utils/routes.dart';
import 'package:rektube/views/widgets/password_field.dart';
import 'package:rektube/views/widgets/rektube_button.dart';
import 'package:rektube/views/widgets/text_field.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.put(SignUpController());
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/images/logo-no-background.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: myTextField(
                        controller: firstNameController,
                        hintText: "First Name",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: myTextField(
                        controller: lastNameController,
                        hintText: "Last Name",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                myTextField(
                  controller: emailController,
                  hintText: "Enter Email",
                  prefixIcon: Icons.email,
                ),
                SizedBox(height: 10),
                PasswordField(
                  hintText: "Enter Password",
                  controller: passwordController,
                ),
                SizedBox(height: 10),
                PasswordField(
                  hintText: "Confirm Password",
                  controller: confirmPasswordController,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: rektubeButton(
                    () async {
                      bool isValid = signUpController.validateSignup(
                        firstNameController.text.trim(),
                        lastNameController.text.trim(),
                        userNameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        confirmPasswordController.text.trim(),
                      );
        
                      if (isValid) {
                        Get.snackbar(
                          "Success",
                          "Sign Up details validated",
                          backgroundColor: Colors.green,
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: mainColor,
                          margin: EdgeInsets.all(10),
                          borderRadius: 8,
                        );
                        Get.offAndToNamed(AppRoutes.navigation);
                      }
                    },
                    label: "Sign Up",
                    color: secondaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Alredy have an account? ",
                        style: TextStyle(
                          color: extraColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: extraColor,
                            decoration: TextDecoration.underline,
                            decorationColor: secondaryColor,
                            decorationThickness: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
