import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import '../../../core/class/crud.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/function/handingdatacontroller.dart';
import '../../../data/datasource/remote/credit/checkoffre.dart';

abstract class GetSentOfferController extends GetxController{
  void getmysentoffer();
}
class GetSentOfferControllerImp extends GetSentOfferController{
  final getmysentofferData getMySentOffer = getmysentofferData(Crud());
  final box = GetStorage();

  StatusRequest statusRequest = StatusRequest.none;
  List<dynamic> offers = [];

  @override
  void onInit(){
    getmysentoffer();
    super.onInit();

  }
  Future<void> getmysentoffer() async {
    statusRequest = StatusRequest.loading;
    update();

    final token = box.read('token');

    try {
      var response = await getMySentOffer.getData(token: token);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          offers = response['data'];
        } else {
          Get.snackbar('Erreur', response['message'] ?? "Erreur inconnue");
        }
      }
    } catch (e) {
      statusRequest = StatusRequest.serverfailure;
      Get.snackbar('Erreur', 'Une erreur est survenue: ${e.toString()}');
    }
    update();
  }

}