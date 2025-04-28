import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rektube/configs/colours.dart';
import 'package:rektube/controllers/auth/login_controller.dart';
import 'package:rektube/utils/routes.dart';
import 'package:rektube/utils/validators.dart';
import 'package:rektube/views/widgets/common/password_field.dart';
import 'package:rektube/views/widgets/common/rektube_button.dart';
import 'package:rektube/views/widgets/common/text_field.dart';

var store = GetStorage();

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoginController loginController = Get.put(LoginController());
    //String username = store.read("username") ?? "";
    //String password = store.read("password") ?? "";

    TextEditingController userNameController = TextEditingController(
      text: loginController.username.value,
    );
    TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    //userNameController.text = username;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 40.0,
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Image.asset(
                      'assets/images/logo-no-background.png',
                      height: 100,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  myTextField(
                    hintText: "Username or Email",
                    controller: userNameController,
                    prefixIcon: Icons.alternate_email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => Validators.validateNotEmpty(value, 'Username or Email'),
                  ),
                  const SizedBox(height: 15),
                  PasswordField(
                    hintText: "Password",
                    controller: passwordController,
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: () {
                      print("Forgot Password tapped");
                      Get.snackbar(
                        "Info",
                        "Forgot Password functionality is not available yet",
                      );
                    }, child: Text("Forgot Password?")),
                  ),
                  const SizedBox(height: 25),
                  Obx(() => rektubeButton(() {
                    if (formKey.currentState?.validate() ?? false) {
                      loginController.loginUser(
                        ref,
                        userNameController.text.trim(),
                        passwordController.text.trim(),
                      );}
                  }, label: "Login", isLoading: loginController.isLoading.value)),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: colorOnBackground,
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
