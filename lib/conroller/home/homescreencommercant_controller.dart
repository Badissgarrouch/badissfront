import 'package:credit_app/view/screen/home/clienthome.dart';
import 'package:credit_app/view/screen/home/commercanthome.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class HomeScreenCommercantController extends GetxController {
  changePage(int currentpage);
}

class HomeScreenCommercantControllerImp extends HomeScreenCommercantController {
  int currentpage=0;
  List<Widget> listPage = [
    const Commercanthome(),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('add'))
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('setting'))
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('profile'))
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