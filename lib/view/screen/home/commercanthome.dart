import 'package:credit_app/conroller/home/commercant_controller.dart';
import 'package:credit_app/core/component/avatar_picker.dart';
import 'package:credit_app/core/component/services_card.dart';
import 'package:credit_app/view/widget/home/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Commercanthome extends GetView<CommercantControllerImp> {
  const Commercanthome({super.key});

  @override
  Widget build(BuildContext context) {
    CommercantControllerImp controller = Get.put(CommercantControllerImp());
    final RxString searchQuery = ''.obs;


    return Obx(() {
      if (searchQuery.isEmpty) {
        return Column(
          children: [
            Customappbar(
              titleappbar: "Find Customer",
              onPressedIcon: () {},
              onSearchChanged: (query) {
                searchQuery.value = query;
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
                          const AvatarPicker(),
                          const SizedBox(height: 8),
                          GetBuilder<CommercantControllerImp>(
                            builder: (controller) {
                              return Obx(() => Text(
                                '${controller.firstName.value} ${controller.lastName.value}',
                                style: Theme.of(context).textTheme.titleMedium,
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
                          title: 'CLIENTS',
                          icon: Icons.people_alt,
                          onTap: controller.navigateToProducts,
                        ),
                        ServiceCard(
                          title: 'ÉCHÉANCES',
                          icon: Icons.calendar_today,
                          onTap: controller.navigateToMerchants,
                        ),
                        ServiceCard(
                          title: 'PRODUITS',
                          icon: Icons.inventory,
                          onTap: controller.navigateToMerchants,
                        ),
                        ServiceCard(
                          title: 'FOURNISSEURS',
                          icon: Icons.local_shipping,
                          onTap: controller.navigateToMerchants,
                        ),
                        ServiceCard(
                          title: 'RAPPORTS',
                          icon: Icons.description,
                          onTap: controller.navigateToMerchants,
                        ),
                        ServiceCard(
                          title: 'STATISTIQUES',
                          icon: Icons.bar_chart,
                          onTap: controller.navigateToMerchants,
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
              titleappbar: "Find Customer",
              onPressedIcon: () {},
              onSearchChanged: (query) {
                searchQuery.value = query;
              },
            ),
            Expanded(
              child: Center(
                child: Text(" ${searchQuery.value}"),
              ),
            ),
          ],
        );
      }
    });
  }
}