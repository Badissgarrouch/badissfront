import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../data/datasource/remote/invitation/send.dart';
import '../../data/model/usermodel2.dart';

class UserOfferController extends GetxController {
  final UserOfferData userOfferData = UserOfferData(Get.find());
  final MyacceptedofferData myacceptedofferData = MyacceptedofferData(Get.find());
  final Rx<StatusRequest> status = StatusRequest.none.obs;
  final RxList<dynamic> clients = <dynamic>[].obs;
  final RxList<dynamic> commercants = <dynamic>[].obs;
  final RxList<UserAccepted> acceptedOffers = <UserAccepted>[].obs;

  Future<void> getUsersWithAcceptedOffers(String token) async {
    try {
      status.value = StatusRequest.loading;

      var response = await userOfferData.getData(token: token);

      if (response is Map<String, dynamic>) {
        if (response['status'] == 'success') {
          clients.value = response['data']['clients'] ?? [];
          commercants.value = response['data']['commercants'] ?? [];
          status.value = StatusRequest.success;
        } else {
          status.value = StatusRequest.fail;
          Get.snackbar("Erreur", response['message'] ?? "Erreur inconnue");
        }
      } else {
        status.value = StatusRequest.fail;
        Get.snackbar("Erreur", "Réponse inattendue du serveur");
      }
    } catch (e) {
      status.value = StatusRequest.fail;
      Get.snackbar("Erreur", "Une erreur inattendue s'est produite");
      print('Error: $e');
    }
  }

  Future<void> getMyAcceptedOffers(String token) async {
    try {
      status.value = StatusRequest.loading;

      var response = await myacceptedofferData.getData(token: token);

      if (response is Map<String, dynamic>) {
        if (response['status'] == 'success') {
          acceptedOffers.value = (response['data'] as List)
              .map((item) => UserAccepted.fromJson(item, 'client'))
              .toList();
          status.value = StatusRequest.success;
        } else {
          status.value = StatusRequest.fail;
          Get.snackbar("Erreur", response['message'] ?? "Erreur inconnue");
        }
      } else {
        status.value = StatusRequest.fail;
        Get.snackbar("Erreur", "Réponse inattendue du serveur");
      }
    } catch (e) {
      status.value = StatusRequest.fail;
      Get.snackbar("Erreur", "Une erreur inattendue s'est produite");
      print('Error: $e');
    }
  }
}