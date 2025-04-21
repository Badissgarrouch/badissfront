import 'package:credit_app/conroller/home/client_controller.dart';
import 'package:credit_app/core/component/avatar_picker.dart';
import 'package:credit_app/core/component/services_card.dart';
import 'package:credit_app/view/widget/home/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../conroller/invitation/send_controller.dart';
import '../../../core/class/statusrequest.dart';

class Clienthome extends GetView<ClientControllerImp> {
  const Clienthome({super.key});

  @override
  Widget build(BuildContext context) {
    ClientControllerImp controller = Get.put(ClientControllerImp());
    SendControllerImp mycontroller = Get.put(SendControllerImp());
    final RxString searchQuery = ''.obs;

    return Obx(() {
      // ✅ Vérifie correctement si la recherche est vide
      if (searchQuery.value.isEmpty) {
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
        // ✅ Affichage des résultats de recherche
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
                if (searchQuery.value.length < 2) {
                  return const Center(child: Text("Enter at least 2 characters"));
                }

                if (controller.searchStatus.value == StatusRequest.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.searchResults.isEmpty) {
                  return const Center(child: Text("No results found"));
                }

                return ListView.builder(
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final user = controller.searchResults[index];
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
                                  mycontroller.goToSendcommercant(user);
                                  // Action principale (ex: sélectionner l'utilisateur)
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 12.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundColor: Colors.indigoAccent,
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
                                              user.businessName ??'Trader',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
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
                                onPressed: () {
                                  // Action vers profil détaillé
                                  print('Voir profil de ${user.firstName}');
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.indigo.shade50,
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Profil",
                                  style: TextStyle(
                                    color: Colors.indigo.shade700,
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
