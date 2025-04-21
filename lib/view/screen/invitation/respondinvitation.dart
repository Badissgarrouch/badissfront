import 'package:credit_app/view/widget/invitation/respond/respond_profil_card.dart';
import 'package:flutter/material.dart';
import 'package:credit_app/view/widget/invitation/respond/respond_detail_card.dart';
import 'package:get/get.dart';
import '../../../conroller/invitation/respond_controller.dart';
import '../../widget/invitation/respond/actions.dart';
import '../../widget/invitation/respond/hearder.dart';

class RespondInvitation extends StatelessWidget {
  const RespondInvitation({super.key});

  @override
  Widget build(BuildContext context) {
    RespondControllerImp controller = Get.put(RespondControllerImp());
    return Scaffold(
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const RespondCardProfile(
                    initials: "AB",
                    name: "Ahmed Ben Salah",
                    business: "Business Solutions SARL",
                  ),
                  const SizedBox(height: 32),
                  const RespondDetailsCard(),
                  const SizedBox(height: 40),
                  RespondActions(
                    onAccept: () => controller.Accept(),
                    onReject: () => controller.Reject(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}