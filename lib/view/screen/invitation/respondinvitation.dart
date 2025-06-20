import 'package:credit_app/view/widget/invitation/respond/respond_profil_card.dart';
import 'package:credit_app/view/widget/listoffer/status.dart';
import 'package:flutter/material.dart';
import 'package:credit_app/view/widget/invitation/respond/respond_detail_card.dart';
import 'package:get/get.dart';
import '../../../conroller/invitation/respond_controller.dart';
import '../../../data/datasource/remote/invitation/invitationmodel.dart';
import '../../../data/datasource/remote/invitation/sender.dart';
import '../../widget/invitation/respond/actions.dart';
import '../../widget/invitation/respond/hearder.dart';

class RespondInvitation extends StatelessWidget {
  const RespondInvitation({super.key});

  @override
  Widget build(BuildContext context) {
    final InvitationModel invitation = Get.arguments;
    final Sender sender = invitation.sender;
    final initials = '${sender.firstName[0]}${sender.lastName[0]}'.toUpperCase();

    RespondControllerImp controller = Get.put(RespondControllerImp());

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        children: [
          Header(
            text: "Invitation details".tr,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RespondCardProfile(
                    initials: initials,
                    name: "${sender.firstName} ${sender.lastName}",
                    businessName: sender.businessName,
                  ),
                  const SizedBox(height: 32),
                  RespondDetailsCard(
                    email: sender.email,
                    phone: sender.phone,
                    date:FormatStatusDate(invitation.createdAt) ,
                  ),
                  const SizedBox(height: 40),
                  RespondActions(
                      onAccept: () => controller.acceptInvitation(invitation.sender.id.toString()),
                      onReject: () => controller.rejectInvitation(invitation.sender.id.toString())
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