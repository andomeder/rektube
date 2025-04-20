import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  // --- Start Initialization ---
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables FIRST
  try {
    await dotenv.load(fileName: ".env"); // Specify filename if needed
    print(".env file loaded successfully.");
  } catch (e) {
    print("Error loading .env file: $e");
  }

  // Initialize GetStorage
  await GetStorage.init();
  print("GetStorage initialized.");

  // Run the app within Riverpod's ProviderScope
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
          print("MyApp build: Auth state data - User: ${user?.username ?? 'null'}");
          return user != null ? const NavigationScreen() : const LoginScreen();
        },
        loading: () {
          print("MyApp build: Auth state loading");
          return const Scaffold(
             backgroundColor: colorBackground, // Use theme background
             body: Center(child: LoadingIndicator())
          );
        },
        error: (error, stackTrace) {
          // Show a more informative error message
          print("MyApp build: Auth state error - $error\nStack trace:\n$stackTrace");
          return Scaffold(
            backgroundColor: colorBackground, // Use theme color
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column( // Use column for better layout
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: colorError, size: 50),
                    const SizedBox(height: 10),
                    const Text(
                       "Error Initializing Application",
                       style: TextStyle(color: colorOnBackground, fontSize: 18, fontWeight: FontWeight.bold),
                       textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      // Show a user-friendly message or the specific error
                      "Could not initialize authentication state. Please check logs or restart the app.\n\nError: $error",
                      style: const TextStyle(color: colorHint), // Use hint color for details
                      textAlign: TextAlign.center,
                    ),
                  ],
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