import 'package:credit_app/conroller/home/commercant_controller.dart';
import 'package:credit_app/core/component/avatar_picker.dart';
import 'package:credit_app/core/component/services_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Commercanthome extends GetView<CommercantControllerImp> {
  const Commercanthome({super.key});

  @override
  Widget build(BuildContext context) {
    CommercantControllerImp controller = Get.put(CommercantControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Espace Commerçant'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              controller.showLogoutConfirmation();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.settings),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MaterialButton(
              minWidth: 40,
              onPressed: () {},
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.home),
                  Text("Home"),
                ],
              ),
            ),
            MaterialButton(
              minWidth: 40,
              onPressed: () {},
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  Text("Add"),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView( // Permet le scroll sur toute la page
        child: Column(
          children: [
            // Header avec photo
            GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  const AvatarPicker(),
                  const SizedBox(height: 8),
                  Text(
                    'Nom Prénom',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            // Grille de services
            GridView.count(
              shrinkWrap: true, // Important pour le scroll
              physics: const NeverScrollableScrollPhysics(), // Désactive le scroll interne
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
    );
  }
}