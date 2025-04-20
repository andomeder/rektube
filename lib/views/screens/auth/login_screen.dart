import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rektube/configs/colours.dart';
import 'package:rektube/controllers/auth/login_controller.dart';
import 'package:rektube/utils/routes.dart';
import 'package:rektube/views/widgets/common/password_field.dart';
import 'package:rektube/views/widgets/rektube_button.dart';
import 'package:rektube/views/widgets/common/text_field.dart';

var store = GetStorage();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    String username = store.read("username") ?? "";
    //String password = store.read("password") ?? "";
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    userNameController.text = username;
    return Scaffold(
      backgroundColor: colorBackground,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/logo-no-background.png', height: 100, width: 100,),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: colorPrimary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                myTextField(
                  hintText: "Enter Username",
                  controller: userNameController,
                ),
                SizedBox(height: 10),
                PasswordField(
                  hintText: "Enter Password",
                  controller: passwordController,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: rektubeButton(
                    () async {
                      bool isValid = loginController.validateLogin(
                        userNameController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if (isValid) {
                        loginController.showSuccessSnackbar(
                          "Welcome ${userNameController.text.trim()}",
                          "Welcome to Rektube",
                        );
                        Get.offAndToNamed(AppRoutes.navigation);
                      }
                    },
                    label: "Login",
                    color: colorPrimary,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: colorOnPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //Get.toNamed("/signup");
                          Get.toNamed(AppRoutes.signup);
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: colorOnPrimary,
                            decoration: TextDecoration.underline,
                            decorationColor: colorPrimary,
                            decorationThickness: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Text("Forgot Password?",
                          style: TextStyle(
                            color: colorOnPrimary,
                            decoration: TextDecoration.underline,
                            decorationColor: colorPrimary,
                            decorationThickness: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          )),
                      onTap: () {
                        print("Forgot Password tapped");
                        Get.snackbar("Info", "Forgot Password functionality is not available yet", 
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.amber,
                        colorText: colorOnPrimary
                        );
                      }
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
