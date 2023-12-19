import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../../authentication/models/vendors_model.dart';

class VendorsController extends GetxController {
  RxList<VendorsModel> requests = <VendorsModel>[].obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      final allRequests = await userRepository.fetchVendors();
      requests(allRequests);
    } catch (e) {
      requests(<VendorsModel>[]); // Handle the error as needed
    }
  }
}