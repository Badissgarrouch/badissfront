import 'package:credit_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

abstract class CommercantController extends GetxController {
  void navigateToProducts();
  void navigateToMerchants();
  void navigateToLogin();
  void showLogoutConfirmation();
// ... autres méthodes abstraites
}

class CommercantControllerImp extends CommercantController {


  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  final box = GetStorage();

  @override
  void onInit() {
    loadUserData();
    super.onInit();
  }
  void loadUserData() {
    String userEmail = box.read('current_user') ?? '';

    firstName.value = box.read('${userEmail}_firstName') ?? '';
    lastName.value = box.read('${userEmail}_lastName') ?? '';
    update(); // Important pour notifier les changements
  }
  @override
  void navigateToProducts() {

  }

  @override
  void navigateToMerchants() {

  }
  @override
  void navigateToLogin() {
    Get.offNamed(AppRoute.login);
  }
  void showLogoutConfirmation() {
    Get.dialog(
      AlertDialog(
        icon: const Icon(Icons.logout, color: Colors.blue, size: 40),
        title: const Text("Déconnexion", style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text("Êtes-vous sûr de vouloir vous déconnecter ?"),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,foregroundColor: Colors.black),
            child:  Text("Annuler",),
            onPressed: () => Get.back(),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,foregroundColor: Colors.black),
            child:  Text("Déconnexion"),
            onPressed: () {
              Get.back();
              navigateToLogin();
            },
          ),
        ],
      ),
    );
  }


}