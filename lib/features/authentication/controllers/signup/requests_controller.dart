import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_saathi_final/common/widgets/loaders/loaders.dart';
import 'package:college_saathi_final/data/repositories/authentication/authentication_repository.dart';
import 'package:college_saathi_final/data/repositories/user/user_repository.dart';
import 'package:college_saathi_final/features/authentication/screens/login/user_details.dart';
import 'package:college_saathi_final/features/itinery/screens/home/home.dart';
import 'package:college_saathi_final/features/personalization/models/request_model.dart';
import 'package:college_saathi_final/navigation_menu.dart';
import 'package:college_saathi_final/utils/constants/image_strings.dart';
import 'package:college_saathi_final/utils/constants/sizes.dart';
import 'package:college_saathi_final/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      final allRequests = await userRepository.fetchRequests();
      requests(allRequests);
    } catch (e) {
      requests(<RequestModel>[]); // Handle the error as needed
    }
  }

  void showAcceptRequestPopup(RequestModel request) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Accept Request',
      middleText:
          'Are you sure you want to accept this ride request? The ride cannot be cancelled afterwards.',
      confirm: ElevatedButton(
        onPressed: () async {
          acceptRequest(request);
          Navigator.of(Get.overlayContext!)
              .pop(); // Close the dialog after accepting
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          side: const BorderSide(color: Colors.green),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text('Accept'),
        ),
      ), // ElevatedButton
      cancel: OutlinedButton(
        child: const Text('Back'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ), // OutlinedButton
    );
  }

// ...
  void completeRequest(RequestModel request) async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);

      String driverId = request.id;

      DocumentSnapshot driverSnapshot = await FirebaseFirestore.instance
          .collection('Requests')
          .doc(driverId)
          .get();

      if (driverSnapshot.exists) {
        // Generate a unique identifier for the completed request
        String requestId = DateTime.now().toUtc().toIso8601String();

        // Explicitly cast to Map<String, dynamic>
        Map<String, dynamic> requestData =
            driverSnapshot.data() as Map<String, dynamic>;

        // Create a new document in the "History" collection with a unique identifier
        await FirebaseFirestore.instance
            .collection('History')
            .doc(driverId)
            .collection('CompletedRequests')
            .doc(requestId)
            .set(requestData);

        // Remove the document from the "Requests" collection
        await FirebaseFirestore.instance
            .collection('Requests')
            .doc(driverId)
            .delete();

        // Close loading dialog
        TFullScreenLoader.stopLoading();

        // Show success message or perform any other necessary actions
        // Assuming you want to show a success message
        TLoaders.successSnackBar(
            title: 'Success', message: 'Ride Completed successfully');
        Get.offAll(() => const NavigationMenu());
      }
    } catch (e) {
      // Close loading dialog
      TFullScreenLoader.stopLoading();

      // Show error message
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void acceptRequest(RequestModel request) async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);

      String driverId = FirebaseAuth.instance.currentUser?.uid ?? '';

      DocumentSnapshot driverSnapshot = await FirebaseFirestore.instance
          .collection('Drivers')
          .doc(driverId)
          .get();

      if (driverSnapshot.exists) {
        // Get driver details
        String driverName =
            driverSnapshot['FirstName'] + ' ' + driverSnapshot['LastName'];
        String driverPhone = driverSnapshot['PhoneNumber'];

        // Get the user ID from the request
        String userId = request.id; // Assuming the request ID is the user ID

        // Update Request document in Firestore
        await FirebaseFirestore.instance
            .collection('Requests')
            .doc(request.id)
            .update({
          'Driver Id': driverId,
          'Driver Phone No': driverPhone,
          'Driver Name': driverName,
          'User Id': userId, // New field
          'Is Accepted': true,
        });

        // Close loading dialog
        TFullScreenLoader.stopLoading();

        // Show success message or perform any other necessary actions

        // Assuming you want to show a success message
        TLoaders.successSnackBar(
            title: 'Success', message: 'Request accepted successfully');
        Get.offAll(() => UserDetails(request: request));
      } else {
        // Close loading dialog
        TFullScreenLoader.stopLoading();

        // Show error message if driver details are not found
        TLoaders.warningSnackBar(
            title: 'Oh Snap!', message: 'Driver details not found');
      }
    } catch (e) {
      // Close loading dialog
      TFullScreenLoader.stopLoading();

      // Show error message
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}


  // Other existing code...

