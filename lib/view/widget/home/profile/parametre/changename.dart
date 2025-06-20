import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:credit_app/conroller/home/profile_controller.dart';
import '../../../../../core/function/validinput.dart';
import '../../../auth/customtextfield.dart';

void showNameChangeDialog(BuildContext context) {
  final controller = Get.find<ProfileController>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: controller.isDarkMode.value ? Colors.grey[850] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person, size: 50, color: Colors.blue),
              SizedBox(height: 15),
              Text("Change name".tr,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black)),
              SizedBox(height: 10),
              Text("Update your first and last name".tr,
                  style: TextStyle(fontSize: 14, color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
              SizedBox(height: 20),
              Customtextfield(
                hinttext: 'Enter your new FirstName'.tr,
                labeltext: 'First Name'.tr,
                iconData: Icons.person,
                mycontroller: nameController,
                valid: (val) => validInput(val!, 3, 20, "username"),
                isNumber: false,
              ),
              SizedBox(height: 15),
              Customtextfield(
                hinttext: 'Enter your new LastName'.tr,
                labeltext: 'Last Name'.tr,
                iconData: Icons.person_outline,
                mycontroller: surnameController,
                valid: (val) => validInput(val!, 3, 20, "username"),
                isNumber: false,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final nameError = validInput(nameController.text, 3, 20, "username");
                    final surnameError = validInput(surnameController.text, 3, 20, "username");

                    if (nameError == null && surnameError == null) {
                      if (nameController.text.isEmpty && surnameController.text.isEmpty) {
                        Get.snackbar("Error".tr, "At least one field (first or last name) must be provided".tr,
                            backgroundColor: Colors.red, colorText: Colors.white);
                        return;
                      }
                      await controller.updateUserInfo(nameController.text, surnameController.text);
                      Get.back();
                    } else {
                      Get.snackbar("Error".tr, nameError ?? surnameError ?? "Please correct the errors".tr,
                          backgroundColor: Colors.red, colorText: Colors.white);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    minimumSize: Size(double.infinity, 40),
                  ),
                  child: Text("submit".tr,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Get.back(),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("Close".tr, style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}