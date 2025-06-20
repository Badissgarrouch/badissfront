import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/view/widget/invitation/sendtoclient/detailclient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../conroller/invitation/sendtoclient_controller.dart';
import '../../../data/datasource/remote/home/search.dart';
import '../../widget/invitation/respond/hearder.dart';
import '../../widget/invitation/send/confimdialog.dart';
import '../../widget/invitation/send/snedactions.dart';
import '../../widget/invitation/send/profile_card.dart';

class SendClientInvitation extends StatelessWidget {
  const SendClientInvitation({super.key});

  @override
  Widget build(BuildContext context) {
    SendClientControllerImp controller = Get.put(SendClientControllerImp());
    final SearchModel? argumentUser = Get.arguments;
    if (argumentUser != null && controller.selectedUser.value == null) {
      controller.selectedUser.value = argumentUser;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Obx(() {
        final user = controller.selectedUser.value;
        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final initials = '${user.firstName[0]}${user.lastName[0]}'.toUpperCase();

        return Column(
          children: [
             Header(text: 'Profile details'.tr),
            Expanded(
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      SendCardProfile(
                        initials: initials,
                        name: '${user.firstName} ${user.lastName}',
                        businessName: user.businessName ?? 'Customer'.tr,
                      ),
                      const SizedBox(height: 32),
                      SendDetailClient(
                        email: user.email,
                        phone: user.phone ?? 'Not specified'.tr,
                      ),
                      const SizedBox(height: 40),
                      SendActions(
                        onSend: () => showSendConfirmationDialog(
                          context: context,
                          onConfirm: () => controller.sendInvitation(),
                        ),
                        onCancel: () => showDeleteConfirmationDialog(
                          context: context,
                          onConfirm: () => controller.deleteInvitation(),
                        ),
                        hasSentInvitation: controller.hasSentInvitation.value,
                        isLoading: controller.status.value == StatusRequest.loading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
