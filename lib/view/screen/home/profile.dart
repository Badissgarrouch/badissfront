import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Profile extends StatelessWidget {
  const Profile ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(height: Get.width / 2, color: Colors.blue),
          Positioned(top: Get.width / 2.5, child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration( color: Colors.white,borderRadius:BorderRadius.circular(100)),
            child: CircleAvatar(
              radius: 40 ,
              backgroundColor: Colors.grey[100],
              backgroundImage: AssetImage("assets/images/lololo.png"),
            ), // CircleAvatar
          )), // Container // Positioned
        ], // Stack
      ), // Container
    );
  }
}
