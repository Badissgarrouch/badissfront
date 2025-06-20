import 'package:credit_app/conroller/home/commercant_controller.dart';

import 'package:credit_app/core/component/services_card.dart';
import 'package:credit_app/view/widget/home/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../conroller/invitation/send_controller.dart';
import '../../../conroller/invitation/sendtoclient_controller.dart';
import '../../../core/class/statusrequest.dart';

class Commercanthome extends GetView<CommercantControllerImp> {
  const Commercanthome({super.key});

  @override
  Widget build(BuildContext context) {
    CommercantControllerImp controller = Get.put(CommercantControllerImp());
    SendClientControllerImp mycontroller = Get.put(SendClientControllerImp());
    SendControllerImp mecontroller = Get.put(SendControllerImp());
    final RxString searchQuery = ''.obs;


    return Obx(() {
      if (searchQuery.value.isEmpty) {
        return Column(
          children: [
            Customappbar(
              titleappbar: "Find Customers".tr,
              onPressedIcon: () {},
              onSearchChanged: (query) {
                searchQuery.value = query;
                controller.searchUsers(query);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            width: 250,
                            height: 200,
                            margin: const EdgeInsets.all(8),
                            child: Lottie.asset(
                              'assets/lotties/profile.json',
                              fit: BoxFit.contain,
                              repeat: true,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GetBuilder<CommercantControllerImp>(
                            builder: (controller) {
                              return Obx(() => Text(
                                '${controller.firstName.value} ${controller.lastName.value}',
                                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: [
                        ServiceCard(
                          title: 'INVITATIONS'.tr,
                          icon: Icons.people_alt,
                          onTap: controller.navigateToClients,
                        ),
                        ServiceCard(
                          title: 'EVALUATIONS'.tr,
                          icon: Icons.calendar_today,
                          onTap:controller.navigateToEvaluation,
                        ),
                        ServiceCard(
                          title: 'PROPOSITIONS'.tr,
                          icon: Icons.inventory,
                          onTap: controller.navigateToProducts,
                        ),
                        ServiceCard(
                          title: 'MY PROPOSITIONS'.tr,
                          icon: Icons.local_shipping,
                          onTap:controller.navigateTocredit
                        ),
                        ServiceCard(
                          title: 'HISTORY'.tr,
                          icon: Icons.description,
                          onTap:controller.navigateToRapport
                        ),
                        ServiceCard(
                          title: 'STATISTIC'.tr,
                          icon: Icons.bar_chart,
                          onTap:controller.navigateToStatistic
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: [
            Customappbar(
              titleappbar: "Find Traders".tr,
              onPressedIcon: () {},
              onSearchChanged: (query) {
                searchQuery.value = query;
                controller.searchUsers(query);
              },
            ),
            Expanded(
              child: Obx(() {
                if (searchQuery.value.length < 2) {
                  return Center(child: Text("Enter at least 3 characters".tr));
                }

                if (controller.searchStatus.value == StatusRequest.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.searchResults.isEmpty) {
                  return Center(child: Text("No results found".tr));
                }

                return ListView.builder(
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final user = controller.searchResults[index];
                    final isTrader = user.userType == '2';

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  if (isTrader) {
                                    mecontroller.goToSendcommercant(user); // Pour les commerçants
                                  } else {
                                    mycontroller.goToSendclient(user); // Pour les clients
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 12.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundColor: isTrader ? Colors.indigoAccent : Colors.blueGrey,
                                        child: Text(
                                          user.firstName.substring(0, 1).toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${user.firstName} ${user.lastName}',
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              user.businessName ?? (isTrader ? 'Trader'.tr : 'Customer'.tr),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: isTrader ? Colors.indigo : Colors.blueGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  backgroundColor: isTrader
                                      ? Colors.indigo.shade50
                                      : Colors.blueGrey.shade50,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Profile".tr,
                                  style: TextStyle(
                                    color: isTrader
                                        ? Colors.indigo.shade700
                                        : Colors.blueGrey.shade700,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );


              }),
            ),
          ],
        );
      }
    });
  }
}
