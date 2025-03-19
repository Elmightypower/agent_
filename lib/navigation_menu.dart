import 'package:agentshipr/screens/home/home.dart';
import 'package:agentshipr/screens/orders/order_page.dart';
import 'package:agentshipr/screens/profile/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 70,
          elevation: 12,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.changeIndex(index),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Accueil"),
            NavigationDestination(icon: Icon(Iconsax.activity5), label: "Opérations"),
            NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
          ],
        ),
      ),
      body: Obx(
            () => controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    Home(),
    OrdersPage(),
    ProfilePage(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
