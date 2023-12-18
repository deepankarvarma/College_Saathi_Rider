
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_saathi_final/common/widgets/loaders/loaders.dart';
import 'package:college_saathi_final/data/repositories/authentication/authentication_repository.dart';
import 'package:college_saathi_final/data/repositories/user/user_repository.dart';
import 'package:college_saathi_final/features/authentication/models/event_model.dart';
import 'package:college_saathi_final/features/authentication/screens/login/user_details.dart';
import 'package:college_saathi_final/features/personalization/models/request_model.dart';
import 'package:college_saathi_final/utils/constants/image_strings.dart';
import 'package:college_saathi_final/utils/constants/sizes.dart';
import 'package:college_saathi_final/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class EventsController extends GetxController {
  RxList<EventsModel> requests = <EventsModel>[].obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      final allRequests = await userRepository.fetchEvents();
      requests(allRequests);
    } catch (e) {
      requests(<EventsModel>[]); // Handle the error as needed
    }
  }
}


