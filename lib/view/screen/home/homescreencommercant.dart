
import 'package:credit_app/conroller/home/homescreencommercant_controller.dart';
import 'package:credit_app/view/widget/home/custombuttonappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Homescreencommercant extends StatelessWidget {
  const Homescreencommercant({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenCommercantControllerImp());
    return GetBuilder<HomeScreenCommercantControllerImp>(builder: (controller) => Scaffold(

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Custombuttonappbar(
                    textbutton: 'Home'.tr,
                    icondata: Icons.home,
                    onPressed: () {
                      controller.changePage(0);
                    },
                    active: controller.currentpage==0? true:false,

                  ),
                  Custombuttonappbar(
                    textbutton: 'Profile'.tr,
                    icondata: Icons.person_pin_rounded,
                    onPressed: () {
                      controller.changePage(1);
                    },
                    active: controller.currentpage==1? true:false,

                  ),
                ],
              ),

              // Right side
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Custombuttonappbar(
                    textbutton: 'Offer'.tr,
                    icondata: Icons.local_offer,
                    onPressed: () {
                      controller.changePage(2);
                    },
                    active: controller.currentpage==2? true:false,

                  ),
                  Custombuttonappbar(
                    textbutton: 'Cards'.tr,
                    icondata: Icons.add_card,
                    onPressed: () {
                      controller.changePage(3);
                    },
                    active: controller.currentpage==3? true:false,

                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      body: controller.listPage.elementAt(controller.currentpage),
    ));
  }
}