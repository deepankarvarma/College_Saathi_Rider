import 'dart:ffi';

import 'package:college_saathi_final/features/authentication/screens/login/login.dart';
import 'package:college_saathi_final/features/personalization/controllers/user_controller.dart';
import 'package:college_saathi_final/features/personalization/models/request_model.dart';
import 'package:college_saathi_final/features/personalization/screens/profile/change_name.dart';
import 'package:college_saathi_final/features/personalization/screens/profile/section_heading.dart';
import 'package:college_saathi_final/features/personalization/screens/profile/t_circular_image.dart';
import 'package:college_saathi_final/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:college_saathi_final/tapp_bar.dart';
import 'package:college_saathi_final/utils/constants/image_strings.dart';
import 'package:college_saathi_final/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserDetails extends StatelessWidget {
  final RequestModel request;
  const UserDetails({required this.request, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: const TAppBar(title: Text('Rider Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Profile Picture
              const SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TCircularImage(image: TImages.user, width: 80, height: 80),
                  ],
                ),
              ),

              // Details
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              const TSectionHeading(
                  title: 'Personal Information for ', showActionButton: false),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TProfileMenu(
                    title: 'Name',
                    value: '${request.id}',
                    onPressed: () {}),
              
              TProfileMenu(
                    title: 'Email',
                    value: '${request.id}',
                    onPressed: () {}),
              
              TProfileMenu(
                    title: 'Phone Number',
                    value: '${request.id}',
                    onPressed: () {}),
              
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const TSectionHeading(
                  title: 'Ride Information', showActionButton: false),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TProfileMenu(
                    title: 'Source',
                    value: '${request.source}',
                    onPressed: () {}),
              
              TProfileMenu(
                    title: 'Destination',
                    value: '${request.destination}',
                    onPressed: () {}),
              
              TProfileMenu(title: 'Amount', value: '10', onPressed: () {}),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green,
                    side: const BorderSide(color: Colors.green), // Set the background color to green
                  ),
                  child: const Text('Complete Ride'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
