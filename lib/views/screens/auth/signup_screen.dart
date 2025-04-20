import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rektube/configs/colours.dart';
import 'package:rektube/controllers/auth/signup_controller.dart';
import 'package:rektube/utils/validators.dart';
import 'package:rektube/views/widgets/common/password_field.dart';
import 'package:rektube/views/widgets/common/rektube_button.dart';
import 'package:rektube/views/widgets/common/text_field.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignUpController signUpController = Get.put(SignUpController());
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: colorOnBackground),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            ),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Image.asset(
                      'assets/images/logo-no-background.png',
                      height: 80,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: 28,
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
                          prefixIcon: null,
                          validator:
                              (v) =>
                                  Validators.validateNotEmpty(v, 'First Name'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: myTextField(
                          controller: lastNameController,
                          hintText: "Last Name",
                          prefixIcon: null,
                          validator:
                              (v) =>
                                  Validators.validateNotEmpty(v, 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  myTextField(
                    hintText: "Username",
                    controller: userNameController,
                    prefixIcon: Icons.person_outline,
                    validator:
                        (v) => Validators.validateNotEmpty(v, 'Username'),
                  ),
                  SizedBox(height: 15),
                  myTextField(
                    controller: emailController,
                    hintText: "Email",
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => Validators.validateEmail(v),
                  ),
                  SizedBox(height: 15),
                  PasswordField(
                    hintText: "Password",
                    controller: passwordController,
                    validator: Validators.validatePassword,
                  ),
                  SizedBox(height: 15),
                  PasswordField(
                    hintText: "Confirm Password*",
                    controller: confirmPasswordController,
                    validator:
                        (value) => Validators.validateConfirmPassword(
                          passwordController.text,
                          value,
                        ),
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => rektubeButton(
                      // Signup Button
                      () {
                        // Validate form
                        if (formKey.currentState?.validate() ?? false) {
                          signUpController.signUpUser(
                            ref, // Pass ref
                            firstNameController.text,
                            lastNameController.text,
                            userNameController.text, // Pass username
                            emailController.text,
                            passwordController.text,
                            confirmPasswordController.text,
                          );
                        }
                      },
                      label: "Sign Up",
                      isLoading: signUpController.isLoading.value,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Alredy have an account? ",
                        style: TextStyle(color: colorOnBackground),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: colorOnPrimary,
                            decoration: TextDecoration.underline,
                            decorationColor: colorPrimary,
                            decorationThickness: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
