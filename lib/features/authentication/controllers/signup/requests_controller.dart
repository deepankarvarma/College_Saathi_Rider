import 'package:college_saathi_final/common/widgets/loaders/loaders.dart';
import 'package:college_saathi_final/data/repositories/authentication/authentication_repository.dart';
import 'package:college_saathi_final/data/repositories/user/user_repository.dart';
import 'package:college_saathi_final/data/services/network_manager.dart';
import 'package:college_saathi_final/features/authentication/models/user_model.dart';
import 'package:college_saathi_final/features/authentication/screens/login/login.dart';
import 'package:college_saathi_final/features/personalization/models/request_model.dart';
import 'package:college_saathi_final/features/personalization/screens/profile/re_authenticate_login_form.dart';
import 'package:college_saathi_final/utils/constants/image_strings.dart';
import 'package:college_saathi_final/utils/constants/sizes.dart';
import 'package:college_saathi_final/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class RequestController extends GetxController {
  static RequestController get instance => Get.find();

  
  Rx<RequestModel> user = RequestModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  // final hidePassword = true.obs;
  // final verifyEmail = TextEditingController();
  // final verifyPassword = TextEditingController();
  // GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
    fetchRequest();
  }

  // Fetch user record
  Future<void> fetchRequest() async {
    try {
      
      final user = await userRepository.fetchRequestDetails();
      this.user(user);
    } catch (e) {
      user(RequestModel.empty());
    } 
  }

  
}
