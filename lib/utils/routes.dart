import 'package:get/get.dart';
import 'package:rektube/views/screens/auth/login_screen.dart';
import 'package:rektube/views/screens/auth/signup_screen.dart';
import 'package:rektube/views/screens/core/dashboard_screen.dart';
import 'package:rektube/views/screens/core/explore_screen.dart';
import 'package:rektube/views/screens/core/library_screen.dart';
import 'package:rektube/views/screens/core/navigation_screen.dart';
import 'package:rektube/views/screens/player/player_screen.dart';
import 'package:rektube/views/screens/settings/settings_screen.dart';

class AppRoutes {
  static const String login = "/login";
  static const String signup = "/signup";
  static const String navigation = "/navigation";
  static const String dashboard = "/dashboard";
  static const String explore = "/explore";
  static const String library = "/library";
  static const String player = "/player";
  static const String settings = "/settings";

  static const String initial = login;



  static List<GetPage> routes = [
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: signup, page: () => const SignUpScreen()),
    GetPage(name: navigation, page: () => const NavigationScreen()),
    GetPage(name: dashboard, page: () => const DashboardScreen()),
    GetPage(name: explore, page: () => const ExploreScreen()),
    GetPage(name: library, page: () => const LibraryScreen()),
    GetPage(name: player, page: () => const PlayerScreen()),
    GetPage(name: settings, page: () => const SettingsScreen()),
  ];
}