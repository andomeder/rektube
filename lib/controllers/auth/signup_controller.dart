import 'package:get/get.dart';
import 'package:rektube/providers/repository_providers.dart';
import 'package:rektube/repositories/auth_repository.dart'; // AuthRepository is needed
import 'package:rektube/utils/exceptions.dart';
import 'package:rektube/utils/helpers.dart';
import 'package:rektube/utils/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rektube/utils/validators.dart'; // Use validators defined previously

final signUpControllerProvider = Provider((ref) => SignUpController());

class SignUpController extends GetxController {
  // Reactive variable for loading state
  var isLoading = false.obs;


  Future<void> signUpUser(
    WidgetRef ref,
    String firstName,
    String lastName,
    String username,
    String email,
    String password,
    String confirmPassword, 
  ) async {

    // Local Validation 
    final validationError = _validateAllFields(firstName, lastName, username, email, password, confirmPassword);
    if (validationError != null) {
      showSnackbar("Validation Error", validationError, isError: true);
      return; 
    }


    isLoading.value = true;

    try {
      final authRepo = ref.read(authRepositoryProvider);

      final user = await authRepo.signUp(
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        username: username.trim(),
        email: email.trim().toLowerCase(),
        password: password.trim(),
      );

      // Signup Successful
      Get.offAllNamed(AppRoutes.navigation);

    } on AuthException catch (e) {
      showSnackbar("Signup Failed", e.message, isError: true);
    } on DatabaseException catch (e) {
       showSnackbar("Signup Error", e.message, isError: true);
    } on NetworkException catch (e) {
       showSnackbar("Network Error", e.message, isError: true);
    } catch (e) {
       print("Signup Controller Error: $e");
       showSnackbar("Error", "An unexpected error occurred during sign up.", isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  String? _validateAllFields(String firstName, String lastName, String username, String email, String password, String confirmPassword) {
     final errors = [
        Validators.validateNotEmpty(firstName, 'First Name'),
        Validators.validateNotEmpty(lastName, 'Last Name'),
        Validators.validateNotEmpty(username, 'Username'),
        Validators.validateEmail(email),
        Validators.validatePassword(password),
        Validators.validateConfirmPassword(password, confirmPassword)
     ].where((e) => e != null).toList(); 

     return errors.isEmpty ? null : errors.join('\n');
  }
}