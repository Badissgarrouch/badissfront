
import 'package:credit_app/conroller/notification/notification_controller.dart';
import 'package:credit_app/core/constant/routes.dart';
import 'package:credit_app/data/datasource/remote/invitation/invitationmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import '../../core/class/crud.dart';
import '../../core/class/statusrequest.dart';
import '../../core/component/logout.dart';
import '../../data/datasource/remote/home/search.dart';
import '../../linkapi.dart';
import '../notification/appController.dart';

abstract class ClientController extends GetxController {
  void navigateToProducts();
  void navigateToMerchants();
  void navigateToCredit();
  void navigateToLogin();
  void showLogoutConfirmation();
  void navigateToStatistique();
}

class ClientControllerImp extends ClientController {
  final Crud crud = Crud();
  RxList<SearchModel> searchResults = <SearchModel>[].obs;
  RxList<InvitationModel> invitations = <InvitationModel>[].obs;
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
    String userEmail = box.read('current_user') ?? '';
    firstName.value = box.read('${userEmail}_firstName') ?? '';
    lastName.value = box.read('${userEmail}_lastName') ?? '';
    update();
  }

  Future<void> searchUsers(String query) async {
    if (query.isEmpty || query.length < 3) {
      searchResults.clear();
      searchStatus.value = StatusRequest.none;
      return;
    }

    final token = await _getValidToken();
    if (token == null) {
      await _forceLogout();
      return;
    }

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

    await Future.delayed(Duration(milliseconds: 100));
    token = box.read('token');
    return token;
  }

  Future<void> _forceLogout() async {
    await box.erase();
    Get.snackbar('Session Expired', 'Please login again');
    navigateToLogin();
  }

  void _handleSearchError(StatusRequest failure) {
    searchStatus.value = StatusRequest.fail;
    Get.defaultDialog(
      title: "62".tr,
      middleText: "63".tr,
      backgroundColor: Colors.white,
      titleStyle: TextStyle(color: Colors.black),
      middleTextStyle: TextStyle(color: Colors.black),
      radius: 12,
      barrierDismissible: false,
    );
  }

  void _handleSearchResponse(Map response) {
    if (response['data'] != null && response['data']['users'] != null) {
      final List<dynamic> usersList = response['data']['users'];
      searchResults.value = usersList
          .map((e) => SearchModel.fromJson(e))
          .toList();
      searchStatus.value = StatusRequest.success;
    } else {
      Get.snackbar('Aucun résultat', 'Aucun utilisateur trouvé.');
      searchStatus.value = StatusRequest.none;
    }
    update();
  }

  Future<void> fetchReceivedInvitations() async {
    final token = await _getValidToken();
    if (token == null) {
      await _forceLogout();
      return;
    }

    try {
      final url = AppLink.getReceiveInvitation;
      final result = await crud.getData(url, headers: {'Authorization': 'Bearer $token'});

      result.fold(
            (failure) => Get.snackbar("Erreur", "Impossible de charger les invitations"),
            (response) => _handleReceivedInvitationsResponse(response),
      );
    } catch (e) {
      print('‼️ Error fetching invitations: $e');
      Get.snackbar("Erreur", "Une erreur est survenue lors de la récupération des invitations.");
    }
  }

  void _handleReceivedInvitationsResponse(Map response) {
    if (response['data'] != null && response['data']['invitations'] != null) {
      final List<dynamic> invitationsList = response['data']['invitations'];
      invitations.value = invitationsList
          .map((e) => InvitationModel.fromJson(e))
          .toList();
    } else {
      Get.snackbar('Aucune invitation', 'Aucune invitation reçue.');
    }
    update();
  }

  @override
  void navigateToProducts() {
    Get.toNamed(AppRoute.listSentOffer);
  }

  @override
  void navigateToMerchants() {
    fetchReceivedInvitations();
    Get.toNamed(AppRoute.commercantInvitationsPage);
  }

  @override
  void navigateToLogin() {
    Get.offAllNamed(AppRoute.login);
  }

  @override
  void navigateToStatistique() {
    final token = box.read('token');
    if (token == null) {
      return;
    }
    Get.toNamed(AppRoute.statistic2, arguments: {'token': token});
  }

  @override
  void navigateToCredit() {
    final token = box.read('token');
    if (token == null) {
      return;
    }
    Get.toNamed(AppRoute.myAcceptedoffer, arguments: {'token': token});
  }

  @override
  void showLogoutConfirmation() {
    Get.dialog(
      LogoutDialog(
        onLogout: () {
          final appController = Get.find<AppController>();
          final notificationController = Get.find<NotificationController>();
          appController.logout();
          notificationController.logout();
          box.remove('token');
          box.remove('current_user');
          navigateToLogin();
        },
      ),
      barrierDismissible: false,
    );
  }
}