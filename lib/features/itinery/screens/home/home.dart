import 'package:college_saathi_final/features/personalization/controllers/home_controller.dart';
import 'package:college_saathi_final/utils/constants/sizes.dart';
import 'package:college_saathi_final/utils/constants/text_strings.dart';
import 'package:college_saathi_final/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                key: controller.homeFormKey,
                child: Column(
                  children: [                  
                      
                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.makeRequest(),
                        child: const Text(TTexts.check),
                      ),
                    )
                  ],
                ),
              ),
              
              ],
            ),
        ),
      ),
    );
  }
}