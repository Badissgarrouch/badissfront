import 'package:credit_app/view/screen/credit/client/sendcredit.dart';
import 'package:credit_app/view/screen/evaluation/getclientevaluation.dart';
import 'package:credit_app/view/screen/home/clienthome.dart';
import 'package:credit_app/view/screen/home/profile.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/constant/routes.dart';

abstract class HomeScreenController extends GetxController {
  void changePage(int currentpage);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentpage = 0;
  final String? token = GetStorage().read('token');

  late List<Widget> listPage;

  HomeScreenControllerImp() {
    listPage = [
      const Clienthome(),
      Profile(),
      SendOffer(),
      ReceivedEvaluations(token: token),

    ];
  }

  @override
  void changePage(int i) {
    if (i == 3 && token == null) {
      Get.snackbar(
        'Erreur',
        'Veuillez vous connecter pour voir les évaluations.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      Get.offNamed(AppRoute.login);
      return;
    }
    currentpage = i;
    update();
  }
}