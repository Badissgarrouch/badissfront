import 'package:credit_app/conroller/payment/mensualite_controller.dart';
import 'package:credit_app/core/constant/colors.dart';
import 'package:credit_app/data/datasource/remote/payment/mensualite.dart';
import 'package:credit_app/view/screen/payment/statususercredit.dart';
import 'package:credit_app/view/widget/payment/myacceptedoffer/card2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../conroller/payment/acceptedusercredit_controller.dart';
import '../../../core/class/statusrequest.dart';
import '../../../data/model/usermodel.dart';

class Myaccepteoffer extends StatelessWidget {
  final UserOfferController controller = Get.put(UserOfferController());
  final PaymentController paymentController;

  Myaccepteoffer({super.key})
      : paymentController = Get.put(PaymentController(Get.put(mensualiteData(Get.find()))));

      @override
      Widget build(BuildContext context) {
    final token = Get.arguments?['token'] as String?;

    if (token != null && controller.status.value == StatusRequest.none) {
      controller.getMyAcceptedOffers(token);
    }

    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: AppBar(
        title: Text(
          'My Accepted Offers'.tr,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.blue900,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.blue500),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: AppColors.grey200,
          ),
        ),
      ),
      body: Obx(() {
        switch (controller.status.value) {
          case StatusRequest.loading:
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.blue500,
              ),
            );
          case StatusRequest.fail:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Error loading offers".tr,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.grey700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (token != null) {
                        controller.getMyAcceptedOffers(token);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      "Try again".tr,
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          case StatusRequest.success:
            if (controller.acceptedOffers.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.credit_card_off,
                      size: 48,
                      color: AppColors.grey400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "No accepted offers found".tr,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              color: AppColors.blue500,
              backgroundColor: AppColors.white,
              onRefresh: () async {
                if (token != null) {
                  await controller.getMyAcceptedOffers(token);
                }
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.acceptedOffers.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final user = controller.acceptedOffers[index];
                  return UserCard2(
                    user: user,
                    onTap: () async {
                      if (token != null) {
                        await paymentController.fetchMyPayments(
                            user.id, token, user);
                        Get.to(() => Test2(
                            user: paymentController.user.value ??
                                User.fromUserAccepted(user, 'client')));
                      }
                    },
                  );
                },
              ),
            );
          default:
            return const SizedBox();
        }
      }),
    );
  }
}