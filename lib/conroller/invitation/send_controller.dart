// SendControllerImp
import 'package:credit_app/core/constant/routes.dart';
import 'package:credit_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import '../../core/class/crud.dart';
import '../../core/class/statusrequest.dart';
import '../../data/datasource/remote/home/search.dart';

abstract class SendController extends GetxController {
  goToSendcommercant(SearchModel user);
  checkInvitation();
  sendInvitation();
  deleteInvitation();
}

class SendControllerImp extends SendController {
  final Rx<SearchModel?> selectedUser = Rx<SearchModel?>(null);
  final Rx<StatusRequest> status = StatusRequest.none.obs;
  final RxBool hasSentInvitation = false.obs;
  final box = GetStorage();
  final Crud crud = Crud();

  String get storageKey {
    final userId = box.read('userId');
    final receiverId = selectedUser.value?.id;
    return 'invitation_${userId}_${receiverId}_commercant';
  }

  @override
  void goToSendcommercant(SearchModel user) {
    selectedUser.value = user;
    loadPersistedState();
    Get.toNamed(AppRoute.sendInvitation, arguments: user);
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      selectedUser.value = Get.arguments as SearchModel;
      loadPersistedState();
    }
  }

  @override
  void onReady() {
    super.onReady();
    checkInvitation();
  }

  void loadPersistedState() {
    if (selectedUser.value != null) {
      hasSentInvitation.value = box.read(storageKey) ?? false;
    }
  }

  void persistState(bool state) {
    if (selectedUser.value != null) {
      box.write(storageKey, state);
    }
  }

  @override
  Future<void> checkInvitation() async {
    status.value = StatusRequest.loading;
    try {
      final token = box.read('token');
      final senderId = box.read('userId');
      final receiverId = selectedUser.value?.id;

      if (token == null || senderId == null || receiverId == null) {
        status.value = StatusRequest.none;
        return;
      }

      final response = await crud.postData(
        AppLink.checkinvit,
        {'receiverId': receiverId},
        headers: {'Authorization': 'Bearer $token'},
      );

      response.fold(
            (failure) {
          hasSentInvitation.value = false;
          persistState(false);
          status.value = StatusRequest.none;
        },
            (response) {
          final serverState = response['hasInvitation'] ?? false;
          hasSentInvitation.value = serverState;
          persistState(serverState);
          status.value = StatusRequest.none;
        },
      );
    } catch (e) {
      debugPrint('Error checking invitation: $e');
      status.value = StatusRequest.none;
    }
  }

  @override
  Future<void> sendInvitation() async {
    status.value = StatusRequest.loading;

    try {
      final token = box.read('token');
      final senderId = box.read('userId');

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
            middleText: 'Une invitation existe déjà',
            textConfirm: 'OK',
            onConfirm: () => Get.back(),
          );
        },
            (response) {
          status.value = StatusRequest.success;
          hasSentInvitation.value = true;
          persistState(true);
          Get.defaultDialog(
            title: 'Succès',
            middleText: 'Invitation envoyée avec succès',
            textConfirm: 'OK',
            onConfirm: () async {
              Get.back();
              await Future.delayed(const Duration(milliseconds: 300));
              Get.back();
            },
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
      final token = box.read('token');
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
          Get.defaultDialog(
            title: 'Erreur',
            middleText: "Impossible de supprimer l'invitation",
            textConfirm: 'OK',
            onConfirm: () => Get.back(),
          );
        },
            (response) {
          hasSentInvitation.value = false;
          persistState(false);
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