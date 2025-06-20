import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../conroller/payment/enterdetailcard_controller.dart';
import '../../../../core/constant/colors.dart';

class MyCard extends StatelessWidget implements PreferredSizeWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EnterDetailCardControllerImp>();
    return AppBar(
      backgroundColor: Colors.grey[50],
      title: Text("My Cards".tr,
          style: TextStyle(
              color: AppColors.blue700,
              fontSize: 23,
              fontWeight: FontWeight.bold)),
      actions: [
        IconButton(
          icon: Icon(Icons.send, color: AppColors.blue700),
          onPressed: () {
            controller.submitCards();
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}