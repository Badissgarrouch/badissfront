import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutDialog({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 8),
                Text(
                  "LOGOUT".tr,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ],
            ),
          ),
          Positioned(
            top: -8,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.red, size: 30),
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
      content: Text(
        "Are you sure you want to quit the application?".tr,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              minimumSize: const Size(150, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text("Deconnexion".tr),
            onPressed: () {
              Get.back();
              onLogout();
            },
          ),
        ),
      ],
    );
  }
}