import 'package:college_saathi_final/data/services/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}
