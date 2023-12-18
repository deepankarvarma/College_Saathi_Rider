import 'package:college_saathi_final/data/repositories/user/user_repository.dart';
import 'package:college_saathi_final/features/personalization/models/request_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RequestController extends GetxController {
  // Other existing code...

  RxList<RequestModel> requests = <RequestModel>[].obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  // Fetch all requests
  Future<void> fetchRequests() async {
    try {
      final allRequests = await userRepository.fetchRequests(); // Adjust the method name accordingly
      requests(allRequests);
    } catch (e) {
      requests(<RequestModel>[]); // Handle the error as needed
    }
  }

  // Other existing code...
}
