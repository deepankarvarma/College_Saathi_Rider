import 'package:college_saathi_final/common/widgets/loaders/loaders.dart';
import 'package:college_saathi_final/data/repositories/user/user_repository.dart';
import 'package:college_saathi_final/data/services/network_manager.dart';
import 'package:college_saathi_final/features/authentication/controllers/signup/requests_controller.dart';
import 'package:college_saathi_final/features/authentication/screens/login/requests.dart';
import 'package:college_saathi_final/features/personalization/controllers/user_controller.dart';
import 'package:college_saathi_final/utils/constants/image_strings.dart';
import 'package:college_saathi_final/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final controller = Get.put(UserController());
  
  final RxBool isToggleOn = true.obs;
  GlobalKey<FormState> homeFormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
    // Call the function to update availability when the app starts
    updateAvailabilityOnAppStart();
  }

  Future<void> updateAvailabilityOnAppStart() async {
    try {
      // Update availability to true in the "Drivers" collection
      final userRepository = Get.put(UserRepository());
      await userRepository.updateAvailabilityStatus({'Availability': true});

      // Optionally, update the Rx User value if needed
      // userController.user.value.availability = true;

      // Log success or show a message if needed
      print('Availability updated on app start: true');
    } catch (e) {
      // Handle errors if any
      print('Error updating availability on app start: $e');
    }
  }
  Future<void> makeRequest() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...', TImages.appleLogo);
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form Validation
      if (!homeFormKey.currentState!.validate()) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Check if availability is true
    final userRepository = Get.put(UserRepository());
    bool userAvailability = await userRepository.getUserAvailability();

    // Check if user's availability is true
    if (!userAvailability) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      // Show Error Message
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'Turn on Availability first before making a request',
      );
      return;
    }
      // Remove Loader
      TFullScreenLoader.stopLoading();
      // Show Success Message
      // TLoaders.successSnackBar(
      //     title: 'Congratulations', message: 'Your request has been sent');


    //   RequestController requestController = RequestController.instance;
    // await requestController.fetchRequest();
    
    // Navigate to the requests page
    Get.to(() => RequestsPage());
      // Move to Verify Email Screen
  
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      // Show some error
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> toggleSwitch() async{
    isToggleOn.value = !isToggleOn.value;
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are updating your information...', TImages.docerAnimation);
      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form Validation
      if (!homeFormKey.currentState!.validate()) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }
      // Update user's first name and last name in firebase
      Map<String, dynamic> status = {
        'Availability': isToggleOn.value,
        
      };
      final userRepository = Get.put(UserRepository());
      await userRepository.updateAvailabilityStatus(status);

      // Update the Rx User value
      // userController.user.value.firstName = firstName.text.trim();
      // userController.user.value.lastName = lastName.text.trim();
// Remove Loader
      TFullScreenLoader.stopLoading();
// Show Success Message
      TLoaders.successSnackBar(
          title: 'Availability Change', message: 'Your availability has been updated. ');

// Move to previous screen.
      // Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
  }

