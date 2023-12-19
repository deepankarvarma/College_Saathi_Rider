import 'package:college_saathi_final/features/authentication/screens/login/ridehistory.dart';
import 'package:college_saathi_final/features/itinery/screens/home/home.dart';
import 'package:college_saathi_final/features/personalization/screens/profile/profile.dart';
import 'package:college_saathi_final/utils/constants/colors.dart';
import 'package:college_saathi_final/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/personalization/screens/profile/events.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: dark ? Colors.black : Colors.white,
          indicatorColor: dark
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            // NavigationDestination(icon: Icon(Iconsax.shop), label: 'Ride History'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'College Events'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomePage(),
    
     EventsPage(),
    const ProfileScreen(),
  ];
}
