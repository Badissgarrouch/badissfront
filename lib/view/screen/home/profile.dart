import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:credit_app/conroller/home/profile_controller.dart';

import '../../widget/home/profile/deconnexion/deconnexion.dart';
import '../../widget/home/profile/topsectionn.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController()); // Initialize the controller
    final controller = Get.find<ProfileController>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Obx(() => Scaffold(
      backgroundColor: controller.isDarkMode.value ? Colors.grey[900] : Colors.grey[100],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'My Profile'.tr,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),

              // Top Section
              buildTopSection(context),

              // Lottie Animation
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: SizedBox(
                  height: Get.height * 0.25,
                  child: Lottie.asset(
                    'assets/lotties/contactus.json',
                    fit: BoxFit.contain,
                  ),
                ),
              ),


              buildBottomSection(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    ));
  }
}