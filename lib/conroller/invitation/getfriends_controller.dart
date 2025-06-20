import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/core/constant/colors.dart';
import 'package:credit_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import '../../core/class/crud.dart';
import '../../core/constant/routes.dart';
import '../../core/function/handingdatacontroller.dart';
import '../../data/datasource/remote/credit/deletefriendship.dart';

abstract class GetFriendsController extends GetxController {
  getFriends();
  goToFriends();
  deleteFriendship(String friendId);
}

class GetFriendsControllerImp extends GetFriendsController {
  final DeleteFriendshipData deleteFriendshipData = DeleteFriendshipData(Crud());
  Crud crud = Crud();
  StatusRequest statusRequest = StatusRequest.none;
  List<dynamic> friendsList = [];
  bool isLoading = true;
  final box = GetStorage();

  @override
  void onInit() {
    getFriends();
    super.onInit();
  }

  @override
  void goToFriends() {
    getFriends();
    Get.offNamed(AppRoute.friendListScreen);
  }


  @override
  Future<void> getFriends() async {
    statusRequest = StatusRequest.loading;
    isLoading = true;
    update();

    try {
      final token = box.read('token');
      var response = await crud.getData(
        '${AppLink.getFriends}',
        headers: {'Authorization': 'Bearer $token'},);

      statusRequest = handlingData(response);
      response.fold(
            (failure) {
              if (statusRequest == StatusRequest.offlinefailure) {
                Get.defaultDialog(
                  title: "62".tr,
                  middleText: "63".tr,
                  backgroundColor: Colors.white,
                  titleStyle: TextStyle(color: Colors.black),
                  middleTextStyle: TextStyle(color: Colors.black),
                  radius: 12,
                  barrierDismissible: false,
                );
                return;
              }
        },
            (responseData) {
          if (responseData['status'] == 'success') {
            friendsList = responseData['data']['friends'];
          } else if (responseData['message'] == 'Authentification requise') {
            Get.snackbar('Session expirée', 'Veuillez vous reconnecter');
          } else {
            Get.snackbar('Erreur', responseData['message'] ?? 'Erreur inconnue');
          }
        },
      );
    } catch (e) {
      Get.snackbar('Exception', e.toString());
      statusRequest = StatusRequest.serverexception;
    } finally {
      isLoading = false;
      update();
    }
  }
  @override
  Future<void> deleteFriendship(String friendId) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      final token = box.read('token');


      final response = await deleteFriendshipData.deleteData(
        token: token,
        friendId: friendId,
      );

      if (response['status'] == 'success') {
        Get.back();
        Get.snackbar(
          "SUCCESSS".tr,
          "Ce compte a été bien supprimé".tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.blue500,
          colorText: Colors.white,
        );
        await getFriends(); // Rafraîchir la liste
      } else {
        Get.snackbar(
          "Error".tr,
          response['message'] ?? "Failed to delete friend".tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error".tr,
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      statusRequest = StatusRequest.none;
      update();
    }
  }

  List<dynamic> filterFriends(String query) {
    return friendsList.where((friend) =>
    friend['firstName'].toLowerCase().contains(query.toLowerCase()) ||
        friend['lastName'].toLowerCase().contains(query.toLowerCase()) ||
        friend['businessName']?.toLowerCase().contains(query.toLowerCase()) ?? false).toList();
  }
}