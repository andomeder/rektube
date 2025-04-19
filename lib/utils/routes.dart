import 'package:get/get.dart';
import 'package:rektube/views/screens/auth/login.dart';
import 'package:rektube/views/screens/auth/signup.dart';
import 'package:rektube/views/screens/core/explore_screen.dart';
import 'package:rektube/views/screens/core/library_screen.dart';
import 'package:rektube/views/screens/core/navigation_screen.dart';

class AppRoutes {
  static const String login = "/";
  static const String signup = "/signup";
  static const String navigation = "/navigation";
  static const String explore = "/explore";
  static const String library = "/library";



  static List<GetPage> routes = [
    GetPage(name: login, page: () => Login()),
    GetPage(name: signup, page: () => SignUp()),
    GetPage(name: navigation, page: () => Navigation()),
    GetPage(name: explore, page: () => Explore()),
    GetPage(name: library, page: () => Library()),
  ];
}