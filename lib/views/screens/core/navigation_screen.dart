import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rektube/configs/colours.dart';
import 'package:rektube/controllers/core/navigation_controller.dart';
import 'package:rektube/views/screens/core/dashboard_screen.dart';
import 'package:rektube/views/screens/core/explore_screen.dart';
import 'package:rektube/views/screens/core/library_screen.dart';
import 'package:rektube/views/widgets/player/mini_player.dart';

final NavigationController navigationController = Get.put(
  NavigationController(),
);
List<Widget> screens = [DashboardScreen(), ExploreScreen(), LibraryScreen()];

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: colorBackground,

      body: Column(
        children: [
          Expanded(
            child: Obx(() => screens[navigationController.selectedIndex.value]),
          ),
          const MiniPlayer(),
        ],
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.list_outlined), label: 'Library')
      ],
      //backgroundColor: colorBackground,
      //selectedItemColor: colorPrimary,
      //unselectedItemColor: colorOnPrimary,
      currentIndex: navigationController.selectedIndex.value,
      onTap: (index) => navigationController.changeIndex(index),)),
      //body: Obx(() => screens[navigationController.selectedIndex.value]),
    );
  }
}
