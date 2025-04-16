import 'package:credit_app/conroller/home/client_controller.dart';
import 'package:credit_app/core/component/avatar_picker.dart';
import 'package:credit_app/core/component/services_card.dart';
import 'package:credit_app/view/widget/home/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/class/statusrequest.dart';

class Clienthome extends GetView<ClientControllerImp> {
  const Clienthome({super.key});

  @override
  Widget build(BuildContext context) {
    ClientControllerImp controller = Get.put(ClientControllerImp());
    final RxString searchQuery = ''.obs;

    return Obx(() {
      // Si la recherche est vide, afficher la page d'accueil normale
      if (searchQuery.isEmpty) {
        return Column(
          children: [
            Customappbar(
              titleappbar: "Find traders",
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
                          GetBuilder<ClientControllerImp>(
                            builder: (controller) {
                              return Obx(() =>
                                  Text(
                                    '${controller.firstName.value} ${controller
                                        .lastName.value}',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleMedium,
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
                          title: 'Produits',
                          icon: Icons.shopping_basket,
                          onTap: controller.navigateToProducts,
                        ),
                        ServiceCard(
                          title: 'Commerçants',
                          icon: Icons.store,
                          onTap: controller.navigateToMerchants,
                        ),
                        ServiceCard(
                          title: 'Crédits',
                          icon: Icons.credit_score,
                          onTap: controller.navigateToMerchants,
                        ),
                        ServiceCard(
                          title: 'Salaire',
                          icon: Icons.payment,
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
        // Page de résultats de recherche
        return Column(
          children: [
            Customappbar(
              titleappbar: "Find traders",
              onPressedIcon: () {},
              onSearchChanged: (query) {
                searchQuery.value = query;
                controller.searchUsers(query);
              },
            ),
            Expanded(
              child: Obx(() {
                if (controller.searchStatus.value == StatusRequest.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.searchResults.isEmpty) {
                  return Center(
                    child: Text(
                      controller.searchStatus.value == StatusRequest.none
                          ? "Enter at least 2 characters"
                          : "No results found",
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final user = controller.searchResults[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(user.firstName.substring(0, 1)),
                        ),
                        title: Text('${user.firstName} ${user.lastName}'),
                        subtitle: Text(user.businessName ?? 'Trader'),
                        onTap: () {
                          // Action when user taps on a result
                        },
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