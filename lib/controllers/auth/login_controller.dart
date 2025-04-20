import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rektube/configs/colours.dart';
import 'package:rektube/configs/constants.dart';
import 'package:rektube/providers/repository_providers.dart';
import 'package:rektube/utils/exceptions.dart';
import 'package:rektube/utils/helpers.dart';
import 'package:rektube/utils/routes.dart';


final LoginControllerProvider = Provider((ref) => LoginController());
class LoginController extends GetxController {
  var isLoading = false.obs;
  var username = "".obs;

  final _getStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Load the last successful username from secure storage when the controller is initialized
    username.value = _getStorage.read(storageUsernameKey) ?? '';
    print("LoginController initialized. Last username: ${username.value}");
  }

  /// Attempts to log the user in using the provided credentials.
  Future<void> loginUser(WidgetRef ref, String usernameOrEmail, String password) async {
    // Basic local validation (can be done in UI with Form key as well)
    if (usernameOrEmail.isEmpty || password.isEmpty) {
      showSnackbar("Input Error", "Please enter both username/email and password", isError: true);
      return;
    }

    isLoading.value = true;

    try {
      // Access the AuthRepository to perform the login using Reverpod's reader from teh provided ref
      final authRepo = ref.read(authRepositoryProvider);

      //Call teh repository's login method  
      final user = await authRepo.login(usernameOrEmail: usernameOrEmail.trim(), password: password.trim());

      // --- Login successful ---
      // Save the username to secure storage
      await _getStorage.write(storageUsernameKey, user!.username);
      // Update the username in the controller
      username.value = user!.username;
      // Update the UI to show the user's profile
      Get.offAndToNamed(AppRoutes.navigation);
    } on AuthException catch (e) {
      showSnackbar("Login Failed", e.message, isError: true);
    } on NetworkException catch (e) {
      showSnackbar("Network Error", e.message, isError: true);
    } catch (e) {
      print("Login Controller Error: $e");
       showSnackbar("Error", "An unexpected error occurred during login.", isError: true);
    } finally {
      isLoading.value = false;
    }
  }
}