import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rektube/configs/colours.dart';
import 'package:rektube/configs/themes.dart';
import 'package:rektube/controllers/auth/auth_controller.dart';
import 'package:rektube/views/screens/auth/login_screen.dart';
import 'package:rektube/utils/routes.dart';
import 'package:rektube/views/screens/core/navigation_screen.dart';
import 'package:rektube/views/widgets/common/loading_indicator.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await GetStorage.init();
//   runApp(GetMaterialApp(
//     home: LoginScreen(),
//     getPages: AppRoutes.routes,
//     initialRoute: '/',
//     debugShowCheckedModeBanner: false,
//   ));
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // final db = AppDatabase.instance; // Optional DB pre-init

  // Ensure you have ProviderScope at the root
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the auth state provided by AuthController
    final authState = ref.watch(authControllerProvider);

    return GetMaterialApp(
      title: 'Rektube',
      theme: darkTheme,
      // Conditionally display screens based on the AsyncValue state
      home: authState.when(
        data: (user) {
          // If data is available, check if user is null (logged out) or not (logged in)
          print("MyApp build: Auth state data - User: ${user?.username ?? 'null'}");
          return user != null ? const NavigationScreen() : const LoginScreen();
        },
        loading: () {
          // Show loading indicator while checking initial auth state
          print("MyApp build: Auth state loading");
          // Use a full scaffold during initial load for better appearance
          return const Scaffold(
             backgroundColor: colorBackground, // Use theme background
             body: Center(child: LoadingIndicator())
          );
        },
        error: (error, stackTrace) {
          // Show an error message if auth state resolution fails
          print("MyApp build: Auth state error - $error");
          return Scaffold(
            backgroundColor: colorBackground,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Error initializing app: $error",
                  style: const TextStyle(color: colorError),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
      getPages: AppRoutes.routes,
      initialRoute: null, // Let 'home' handle the initial screen logic
      debugShowCheckedModeBanner: false,
    );
  }
}