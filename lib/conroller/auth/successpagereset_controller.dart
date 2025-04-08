
import 'package:get/get.dart';

import '../../core/constant/routes.dart' ;

abstract class SuccesspageResetController extends GetxController {
  checkEmail1();

  goToLogin();
}
class SuccesspageResetControllerImp extends SuccesspageResetController {



  @override
  checkEmail1() {

  }

  @override
  goToLogin() {
    Get.toNamed(AppRoute.login);
  }
  @override
  void onInit(){

    super.onInit();}
  @override
  void dispose() {


    super.dispose();
  }

}