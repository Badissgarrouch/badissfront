import 'package:credit_app/core/constant/colors.dart';
import 'package:credit_app/core/constant/routes.dart';

import 'package:credit_app/data/datasource/remote/payment/mensualite.dart';
import 'package:credit_app/view/screen/payment/statususercredit.dart';
import 'package:credit_app/view/widget/payment/monuserrecu/card1.dart';
import 'package:credit_app/view/widget/payment/monuserrecu/selector1.dart';
import 'package:credit_app/data/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import '../../../conroller/payment/acceptedusercredit_controller.dart';
import '../../../conroller/payment/mensualite_controller.dart';
import '../../../core/class/statusrequest.dart';


class Test1 extends StatelessWidget {
  final ValueNotifier<String> selectedTypeNotifier = ValueNotifier('client');
  final UserOfferController controller = Get.put(UserOfferController());
  final box = GetStorage();

  Test1({super.key});

  @override
  Widget build(BuildContext context) {
    final token = Get.arguments?['token'] as String?;
    if (token == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar("Erreur", "Token manquant");
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    Get.lazyPut(() => mensualiteData(Get.find()));
    final paymentController = Get.put(PaymentController(Get.find<mensualiteData>()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getUsersWithAcceptedOffers(token);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text(
          'Offer owners'.tr,
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.blue800,
                AppColors.blue700,
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ValueListenableBuilder<String>(
            valueListenable: selectedTypeNotifier,
            builder: (context, selectedType, _) {
              final displayedUsers = selectedType == 'client'
                  ? controller.clients
                  : controller.commercants;

              return Column(
                children: [
                  const SizedBox(height: 18),
                  TypeSelector(
                    selectedType: selectedType,
                    onTypeChanged: (type) => selectedTypeNotifier.value = type,
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: Obx(() {
                      if (controller.status.value == StatusRequest.loading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (controller.status.value == StatusRequest.fail) {
                        return Center(child: Text('Loading error'.tr));
                      } else if (displayedUsers.isEmpty) {
                        return Center(child: Text('No users found'.tr));
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: displayedUsers.length,
                        itemBuilder: (context, index) {
                          final user = displayedUsers[index];
                          return UserCard(
                            user: User.fromJson(user, selectedType),
                            onTap: () async {
                              await paymentController.fetchClientPayments(user['id'].toString(), token);
                              Get.to(() => Test2(user: paymentController.user.value ?? User.fromJson(user, selectedType)));
                            },
                          );
                        },
                      );
                    }),
                  ),
                ],
              );
            },
          ),
          Positioned(
            left: 90,
            bottom: 16,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.blue700,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 6,
              ),
              onPressed: () {
                final token = box.read('token');
                if (token == null) {
                  Get.snackbar("Erreur", "Token manquant");
                  return;
                }
                Get.offNamed(AppRoute.myAcceptedoffer, arguments: {'token': token});
              },
              child: Text(
                'My Accepted Offers'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}