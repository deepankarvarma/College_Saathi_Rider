

import 'package:college_saathi_final/features/personalization/controllers/user_controller.dart';
import 'package:college_saathi_final/features/personalization/screens/profile/important_contacts.dart';
import 'package:college_saathi_final/features/personalization/screens/profile/vendors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:college_saathi_final/features/personalization/controllers/home_controller.dart';
import 'package:college_saathi_final/features/personalization/screens/profile/section_heading.dart';
import 'package:college_saathi_final/utils/constants/sizes.dart';
import 'package:college_saathi_final/utils/constants/text_strings.dart';
import 'package:college_saathi_final/utils/validators/validation.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final UserController userController = Get.find<UserController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // ClipPath Background
            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                color: Colors.blue, // Set your desired background color
                height: MediaQuery.of(context).size.height * 0.35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: TSizes.appBarHeight),

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Obx(() {
                      final user = userController.user.value;
                      return TSectionHeading(
                        title:
                            'Welcome ${user.firstName},',
                        
                        textColor: Colors.white,     // Use the user's name dynamically
                        showActionButton: false,
                        
                      );
                    }),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  // Carousel
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 250,
                      enlargeCenterPage: true,
                    ),
                    items: [
                      _buildCurvedImage(
                          'https://www.collegebatch.com/static/clg-gallery/thapar-institute-of-engineering-technology-patiala-214568.jpg'),
                      _buildCurvedImage(
                          'https://lmtsm.thapar.edu/assets/front/img/glogiftbanner.jpg'),
                      _buildCurvedImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnS-bNnBZKHaHnP8b9n9SFZqURVVWB2fe2KA&usqp=CAU'),
                      _buildCurvedImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTifVGJefJXoUqcR0P4quZ3Zh1uxJQHweauKA&usqp=CAU'),
                      _buildCurvedImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnPM5r9G6EgoTiAItUzU6sJeYlmIjX2XdOGA&usqp=CAU'),
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),
                  Form(
                    key: controller.homeFormKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TSectionHeading(
                                title: 'Toggle Availability Status',
                                showActionButton: false,
                              ),
                            ),
                            const SizedBox(
                              width: TSizes.spaceBtwInputFields * 4,
                            ),
                            Obx(() => Switch(
                                  value: controller.isToggleOn.value,
                                  onChanged: (value) {
                                    controller.toggleSwitch();
                                  },
                                )),
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
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems * 1.5),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: ()=> Get.to(()=> ImportantContacts()),
                            child: const Text('Important Contacts'),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems * 1.5),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: ()=> Get.to(()=> Vendors()),
                            child: const Text('Vendor Details'),
                          ),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        const Divider(),

                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                                'Made by CPG : 80 (College Saathi)',
                                style: TextStyle(color: Colors.green)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCurvedImage(String imageUrl) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
    child: Image.network(
      imageUrl,
      fit: BoxFit.cover,
    ),
  );
}

// Custom Clip Path for Background
class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
