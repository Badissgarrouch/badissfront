import 'package:credit_app/core/constant/routes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import '../../core/class/crud.dart';
import '../../core/class/statusrequest.dart';
import '../../data/datasource/remote/home/search.dart';
import '../../linkapi.dart';

abstract class SendClientController extends GetxController{
  goToSendclient(SearchModel user);
  goToSendcommercant(SearchModel user);
  sendInvitation();
  deleteInvitation();
  checkinvitation();
}

class SendClientControllerImp extends SendClientController{
  final Rx<SearchModel?> selectedUser = Rx<SearchModel?>(null);
  final Rx<StatusRequest> status = StatusRequest.none.obs;
  final RxBool hasSentInvitation = false.obs;
  final box = GetStorage();
  final Crud crud = Crud();
  @override
  void goToSendclient(SearchModel user) {
    Get.toNamed(AppRoute.sendclientInvitation,arguments: user);
    selectedUser.value = user;
  }
  @override
  void goToSendcommercant(SearchModel user) {
    Get.toNamed(AppRoute.sendInvitation,arguments: user);
    selectedUser.value = user;
  }
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      selectedUser.value = Get.arguments as SearchModel;
    }
  }

  @override
  void onReady() {
    super.onReady();
    checkinvitation(); // Appelé quand l'écran est prêt
  }

  Future<void> checkinvitation() async {
    status.value = StatusRequest.loading;
    try {
      final token = await box.read('token');
      final senderId = await box.read('userId');
      final receiverId = selectedUser.value?.id;

      if (token == null || senderId == null || receiverId == null) return;

      final response = await crud.postData(
        AppLink.checkinvit,
        {'receiverId': receiverId},
        headers: {'Authorization': 'Bearer $token'},
      );

      response.fold(
            (failure) => hasSentInvitation.value = false,
            (response) => hasSentInvitation.value = response['hasInvitation'] ?? false,
      );
    } catch (e) {
      debugPrint('Error checking invitation: $e');
      hasSentInvitation.value = false;
    } finally {
      status.value = StatusRequest.none;
    }
  }

  @override
  Future<void> sendInvitation() async {
    status.value = StatusRequest.loading;

    try {
      print(await box.read('token'));
      print(await box.read('userId'));

      final token = await box.read('token');
      final senderId = await box.read('userId');

      if (selectedUser.value == null || token == null || senderId == null) {
        throw Exception('Missing required data');
      }

      final response = await crud.postData(
        AppLink.invitUser,
        {
          'receiverId': selectedUser.value!.id,
          'message': 'Invitation à collaborer'
        },
        headers: {'Authorization': 'Bearer $token'},
      );

      response.fold(
            (failure) {
          status.value = StatusRequest.fail;
          Get.defaultDialog(
              title: 'Erreur',
              middleText: 'Invitation déja existe entre vous',
              textConfirm: 'OK',
              onConfirm: () {
                Get.back(); // ferme le dialog
                Get.back(); // retourne à l'écran précédent
              });
        },
            (response) {
          status.value = StatusRequest.success;
          hasSentInvitation.value = true;
          Get.defaultDialog(
              title: 'Succès',
              middleText: 'Invitation envoyée avec succès',
              textConfirm: 'OK',
              onConfirm: () async {
                Get.back();
                await Future.delayed(Duration(milliseconds: 300)); // ferme le dialog
                Get.back(); // retourne à l'écran précédent
              }
          );
        },
      );
    } catch (e) {
      status.value = StatusRequest.serverexception;
      Get.snackbar('Erreur', 'Une erreur est survenue: ${e.toString()}');
    }
  }
  @override
  Future<void> deleteInvitation() async {
    status.value = StatusRequest.loading;
    try {
      final token = await box.read('token');
      final receiverId = selectedUser.value?.id;

      if (token == null || receiverId == null) {
        throw Exception('Données manquantes');
      }

      final response = await crud.postData(
        AppLink.deleteinvit,
        {'receiverId': receiverId},
        headers: {'Authorization': 'Bearer $token'},
      );

      response.fold(
            (failure) {
          status.value = StatusRequest.fail;
          Get.snackbar('Erreur', 'Échec de la suppression de l\'invitation');
        },
            (response) {
          hasSentInvitation.value = false;
          status.value = StatusRequest.success;
          Get.defaultDialog(
            title: 'Succès',
            middleText: 'Invitation supprimée avec succès',
            textConfirm: 'OK',
            onConfirm: () => Get.back(),
          );
        },
      );
    } catch (e) {
      status.value = StatusRequest.serverexception;
      Get.snackbar('Erreur', 'Erreur lors de la suppression: ${e.toString()}');
    }
  }
}