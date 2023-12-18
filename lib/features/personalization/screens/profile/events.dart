import 'package:college_saathi_final/features/authentication/controllers/signup/events_controller.dart';
import 'package:college_saathi_final/features/authentication/controllers/signup/requests_controller.dart';
import 'package:college_saathi_final/tapp_bar.dart';
import 'package:college_saathi_final/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsPage extends StatelessWidget {
  // Reference to the RequestController
  final EventsController requestController = Get.put(EventsController());
  final controller = Get.put(EventsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('College Events'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () {
            if (requestController.requests.isEmpty) {
              return const Center(
                child: Text(
                  'No Events Available',
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
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
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
                        '${request.ename}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Modify the following lines based on your RequestModel structure
                      Text('Starting On: ${request.sdate}'),
                      const SizedBox(height: 8),
                      Text('Ending On: ${request.edate}'),
                      // Add more fields as needed
                      const SizedBox(height: 8),
                      // Modify the following lines based on your RequestModel structure
                      Text('Location: ${request.location}'),
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
