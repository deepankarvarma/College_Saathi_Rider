import 'package:college_saathi_final/features/personalization/controllers/vendors_controller.dart';
import 'package:college_saathi_final/tapp_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Vendors extends StatelessWidget {
  // Reference to the RequestController
  final VendorsController requestController = Get.put(VendorsController());
  final controller = Get.put(VendorsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Vendors'),showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () {
            if (requestController.requests.isEmpty) {
              return const Center(
                child: Text(
                  'No Vendors Available',
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
                        '${request.name}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Modify the following lines based on your RequestModel structure
                      Text('Location: ${request.location}'),
                      const SizedBox(height: 8),
                      Text('Type: ${request.type}'),
                      const SizedBox(height: 8),
                      Text('Phone: ${request.phone}'),
                      // Add more fields as needed
                      
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