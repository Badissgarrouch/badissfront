import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RespondActions extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const RespondActions({
    super.key,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF81C784), Color(0xFFE8F5E9)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.black,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            icon: const Icon(Icons.check, size: 25,color: Colors.greenAccent,),
            label: Text(
              "Accept invitation".tr,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            onPressed: onAccept,
          ),
        ),
        const SizedBox(height: 12),


        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFEF9A9A), Color(0xFFFFEBEE)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              side: BorderSide.none,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              foregroundColor: Colors.black,
            ),
            icon: const Icon(Icons.close, size: 25,color: Colors.redAccent,),
            label: Text(
              "Decline invitation".tr,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            onPressed: onReject,
          ),
        ),
      ],
    );
  }
}