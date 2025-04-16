import 'package:credit_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import '../../core/class/crud.dart';
import '../../core/class/statusrequest.dart';
import '../../data/model/user_model.dart';
import '../../linkapi.dart';

abstract class ClientController extends GetxController {
  void navigateToProducts();
  void navigateToMerchants();
  void navigateToLogin();
  void showLogoutConfirmation();
}

class ClientControllerImp extends ClientController {
  final Crud crud = Crud();
  RxList<UserModel> searchResults = <UserModel>[].obs;
  Rx<StatusRequest> searchStatus = StatusRequest.none.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  final box = GetStorage();

  @override
  void onInit() {
    loadUserData();
    super.onInit();
  }

  void loadUserData() {
    final userData = box.read('user_data') ?? {};
    String userEmail = box.read('current_user') ?? '';
    firstName.value = box.read('${userEmail}_firstName') ?? '';
    lastName.value = box.read('${userEmail}_lastName') ?? '';
    update();
  }

  Future<void> searchUsers(String query) async {
    // 1. Vérification initiale
    if (query.isEmpty || query.length < 2) {
      searchResults.clear();
      searchStatus.value = StatusRequest.none;
      return;
    }

    // 2. Récupération du token avec vérification renforcée
    final token = await _getValidToken();
    if (token == null) {
      await _forceLogout();
      return;
    }

    // 3. Exécution de la recherche
    searchStatus.value = StatusRequest.loading;
    update();

    try {
      final url = '${AppLink.searchUser}?searchTerm=${Uri.encodeComponent(query)}&userType=2';
      final result = await crud.getData(url, headers: {'Authorization': 'Bearer $token'});

      result.fold(
            (failure) => _handleSearchError(failure),
            (response) => _handleSearchResponse(response),
      );
    } catch (e) {
      print('‼️ Search error: $e');
      searchStatus.value = StatusRequest.serverexception;
    } finally {
      update();
    }
  }

  Future<String?> _getValidToken() async {
    var token = box.read('token');
    if (token != null) return token;

    print('⚠️ Attempting token recovery...');
    await Future.delayed(Duration(milliseconds: 100)); // Pause pour le stockage

    token = box.read('token');
    if (token != null) {
      print('🔑 Token recovered');
      return token;
    }

    print('❌ Token recovery failed');
    return null;
  }

  Future<void> _forceLogout() async {
    await box.erase();
    Get.offAllNamed(AppRoute.login);
    Get.snackbar('Session Expired', 'Please login again');
  }
  void _handleSearchError(StatusRequest failure) {
    // Gestion détaillée des erreurs
  }

  void _handleSearchResponse(Map response) {
    // Gestion de la réponse
  }


  @override
  void navigateToProducts() {
    // Implémentez votre navigation vers les produits
  }

  @override
  void navigateToMerchants() {
    // Implémentez votre navigation vers les commerçants
  }

  @override
  void navigateToLogin() {
    Get.offNamed(AppRoute.login);
  }

  @override
  void showLogoutConfirmation() {
    Get.dialog(
      AlertDialog(
        icon: const Icon(Icons.logout, color: Colors.blue, size: 40),
        title: const Text("Déconnexion", style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text("Êtes-vous sûr de vouloir vous déconnecter ?"),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, foregroundColor: Colors.black),
            child: const Text("Annuler"),
            onPressed: () => Get.back(),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, foregroundColor: Colors.black),
            child: const Text("Déconnexion"),
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
