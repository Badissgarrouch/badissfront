import 'package:credit_app/view/screen/home/clienthome.dart';
import 'package:credit_app/view/screen/home/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int currentpage);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentpage=0;
  List<Widget> listPage = [
    const Clienthome(),
    Profile(),
    Column(

      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('profile'))
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
        Center(child: Text('favor'))
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