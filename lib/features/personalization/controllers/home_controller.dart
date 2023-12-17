import 'package:college_saathi_final/common/widgets/loaders/loaders.dart';
import 'package:college_saathi_final/data/repositories/user/user_repository.dart';
import 'package:college_saathi_final/data/services/network_manager.dart';
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

      // Register user in the Firebase Authentication & Save user data in the Firebase
      // final userCredential = await AuthenticationRepository.instance
      //     .registerWithEmailAndPassword(
      //         email.text.trim(), password.text.trim());

      // Save Authenticated user data in the Firebase Firestore
      // final newUser = RequestModel(
      //   id: controller.user.value.id,
      //   source: from.text.trim(),
      //   destination: to.text.trim(),
      //   isAccepted: false,

      // );

      // final userRepository = Get.put(RequestRepository());
      // await userRepository.saveUserRecord(newUser);
      // Remove Loader
      TFullScreenLoader.stopLoading();
      // Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your request has been sent');

      // Move to Verify Email Screen
      //Get.to(() => VerifyEmailScreen(email: email.text.trim()));
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
          'We are updating your information...', TImages.acerlogo);
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

