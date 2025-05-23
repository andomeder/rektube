import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:media_kit/media_kit.dart';
import 'package:rektube/configs/colours.dart';
import 'package:rektube/configs/themes.dart';
import 'package:rektube/controllers/auth/auth_controller.dart';
import 'package:rektube/controllers/player/player_controller.dart';
import 'package:rektube/controllers/settings/theme_controller.dart';
import 'package:rektube/providers/repository_providers.dart';
import 'package:rektube/views/screens/auth/login_screen.dart';
import 'package:rektube/utils/routes.dart';
import 'package:rektube/views/screens/core/navigation_screen.dart';
import 'package:rektube/views/widgets/common/loading_indicator.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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
  //WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  MediaKit.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env"); 
    print(".env file loaded successfully.");
  } catch (e) {
    print("Error loading .env file: $e");
  }

  // Initialize GetStorage
  await GetStorage.init();
  print("GetStorage initialized.");

  Get.put<ThemeController>(ThemeController());
  print("ThemeController registered with GetX.");

  //Create the Riverpod container
  final container = ProviderContainer();

  // Instantiate PlayerRepository using the container
  final playerRepository = container.read(playerRepositoryProvider);

  // Instantiate and register PlayerController using GetX, passing the repository
  Get.put<PlayerController>(PlayerController(playerRepository));
  print("PlayerController registered registered with GetX.");



  FlutterNativeSplash.remove();
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}



class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeController themeController = Get.find<ThemeController>();
    final authState = ref.watch(authControllerProvider);

    return Obx (() => GetMaterialApp(
      title: 'Rektube',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeController.themeMode,
      home: authState.when(
        data: (user) {
          print(
            "MyApp build: Auth state data - User: ${user?.username ?? 'null'}",
          );
          return user != null ? const NavigationScreen() : const LoginScreen();
        },
        loading: () {
          print("MyApp build: Auth state loading");
          return const Scaffold(
            backgroundColor: colorBackground,
            body: Center(child: LoadingIndicator()),
          );
        },
        error: (error, stackTrace) {
          print(
            "MyApp build: Auth state error - $error\nStack trace:\n$stackTrace",
          );
          return Scaffold(
            backgroundColor: colorBackground, 
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  // Use column for better layout
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: colorError,
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Error Initializing Application",
                      style: TextStyle(
                        color: colorOnBackground,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Could not initialize authentication state. Please check logs or restart the app.\n\nError: $error",
                      style: const TextStyle(
                        color: colorHint,
                      ),
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
    ));
  }
}
