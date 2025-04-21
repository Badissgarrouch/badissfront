import 'package:credit_app/core/constant/routes.dart';
import 'package:get/get.dart';

abstract class RespondController extends GetxController{
  goToRespond();
  Accept();
  Reject();
}

class RespondControllerImp extends RespondController{
  @override
  void goToRespond() {
    Get.toNamed(AppRoute.respondInvitation);
  }

  @override
  void Accept() {

  }

  @override
  void Reject() {

  }
}
