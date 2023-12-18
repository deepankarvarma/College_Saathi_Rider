import 'package:college_saathi_final/common/widgets/loaders/loaders.dart';
import 'package:college_saathi_final/data/repositories/user/user_repository.dart';
import 'package:college_saathi_final/data/services/network_manager.dart';
import 'package:college_saathi_final/features/personalization/controllers/user_controller.dart';
import 'package:college_saathi_final/features/personalization/screens/profile/profile.dart';
import 'package:college_saathi_final/utils/constants/image_strings.dart';
import 'package:college_saathi_final/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class updateNameController extends GetxController {
  static updateNameController get instance => Get.find();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  // init user data when home screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  // Fetch User Record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
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
      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Update user's first name and last name in firebase
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      // Update the Rx User value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();
// Remove Loader
      TFullScreenLoader.stopLoading();
// Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your name has been updated. ');

// Move to previous screen.
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
