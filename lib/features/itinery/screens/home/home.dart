import 'package:college_saathi_final/features/personalization/controllers/home_controller.dart';
import 'package:college_saathi_final/features/personalization/screens/profile/section_heading.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: controller.homeFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Expanded(
                        //   child: controller.isToggleOn
                        //       ? TextFormField(
                        //           controller: controller.isToggleOn,
                        //           validator: (value) => TValidator.validateEmptyText(
                        //             'Source',
                        //             value,
                        //           ),
                        //           expands: false,
                        //           decoration: const InputDecoration(
                        //             labelText: TTexts.tContinue,
                        //             prefixIcon: Icon(Iconsax.location),
                        //           ),
                        //         )
                        //       : Text(
                        //           'Toggle is off',
                        //           style: TextStyle(fontSize: 16),
                        //         ),
                        // ),
                        const Padding(
                          padding:  EdgeInsets.all(8.0),
                          child:  TSectionHeading(
                          title: 'Toggle Availability Status', showActionButton: false),
                        ),
                        const SizedBox(
                          width: TSizes.spaceBtwInputFields*4,
                        ),
                        Obx(()=> Switch(
                            value: controller.isToggleOn.value,
                            onChanged: (value) {
                              controller.toggleSwitch();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
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
