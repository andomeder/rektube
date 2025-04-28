import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
    username.value = _getStorage.read(storageUsernameKey) ?? '';
    print("LoginController initialized. Last username: ${username.value}");
  }

  Future<void> loginUser(WidgetRef ref, String usernameOrEmail, String password) async {
    if (usernameOrEmail.isEmpty || password.isEmpty) {
      showSnackbar("Input Error", "Please enter both username/email and password", isError: true);
      return;
    }

    isLoading.value = true;

    try {
      final authRepo = ref.read(authRepositoryProvider);

      final user = await authRepo.login(usernameOrEmail: usernameOrEmail.trim(), password: password.trim());

      // Login successful
      await _getStorage.write(storageUsernameKey, user.username);
      username.value = user.username;
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