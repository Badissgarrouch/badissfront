import 'package:credit_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ClientController extends GetxController {
  void navigateToProducts();
  void navigateToMerchants();
  void navigateToLogin();
  void showLogoutConfirmation();
// ... autres méthodes abstraites
}

class ClientControllerImp extends ClientController {
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