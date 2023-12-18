import 'package:college_saathi_final/features/authentication/controllers/signup/requests_controller.dart';
import 'package:college_saathi_final/tapp_bar.dart';
import 'package:college_saathi_final/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestsPage extends StatelessWidget {
  // Reference to the RequestController
  final RequestController requestController = Get.put(RequestController());
  final controller = Get.put(RequestController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('User Requests'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () {
            // Check if data is still loading
            if (requestController.requests.isEmpty) {
              return Center(
                child: Text(
                  'No Booking Requests',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              );
            }
  
            // Use the fetched requests data
            return ListView.builder(
              itemCount: requestController.requests.length,
              itemBuilder: (context, index) {
                final request = requestController.requests[index];

                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueAccent, // Adjust border color
                      width: 2.0, // Adjust border thickness
                    ),
                    borderRadius:
                        BorderRadius.circular(12), // Adjust border radius
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Request from ${request.firstName} ${request.lastName}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Modify the following lines based on your RequestModel structure
                      Text('Source: ${request.source}'),
                      SizedBox(height: 8),
                      Text('Destination: ${request.destination}'),
                      // Add more fields as needed
                      const SizedBox(
                        height: TSizes.spaceBtwSections / 2,
                      ),
                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller.fetchRequests();
                            if (controller.requests.isNotEmpty) {
                              controller.showAcceptRequestPopup(
                                  controller.requests.first);
                            }
                          },
                          child: const Text('Accept'),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
