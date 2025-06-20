import 'package:credit_app/view/screen/credit/client/sendcredit.dart';
import 'package:credit_app/view/screen/home/clienthome.dart';
import 'package:credit_app/view/screen/home/commercanthome.dart';
import 'package:credit_app/view/screen/home/profile.dart';
import 'package:credit_app/view/screen/payment/EnterCartdetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class HomeScreenCommercantController extends GetxController {
  changePage(int currentpage);
}

class HomeScreenCommercantControllerImp extends HomeScreenCommercantController {
  int currentpage=0;
  List<Widget> listPage = [
    const Commercanthome(),
    Profile(),
    SendOffer(),
    EnterCardDetail(),

    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('home'))
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('profile'))
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('Cards'))
      ],
    ),
  ];

  @override
  changePage(int i) {
    currentpage = i;
    update();
    // Votre implémentation existante
  }
}