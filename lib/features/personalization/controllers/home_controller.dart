  import 'package:college_saathi_final/common/widgets/loaders/loaders.dart';
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

  final from = TextEditingController();
  
  final to = TextEditingController();
  GlobalKey<FormState> homeFormKey = GlobalKey<FormState>();
  
  Future<void> makeRequest() async{
    try{
    
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
          title: 'Congratulations',
          message: 'Your request has been sent');

      // Move to Verify Email Screen
      //Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    }catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      // Show some error
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}