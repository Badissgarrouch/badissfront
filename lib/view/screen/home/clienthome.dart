import 'package:credit_app/conroller/home/client_controller.dart';
import 'package:credit_app/core/component/avatar_picker.dart';
import 'package:credit_app/core/component/services_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Clienthome extends GetView<ClientControllerImp> {
  const Clienthome({super.key});

  @override
  Widget build(BuildContext context) {
    ClientControllerImp controller = Get.put(ClientControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Espace Client'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {

            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () { controller.showLogoutConfirmation();},
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
      body: SingleChildScrollView(
        child: Column(
          children: [
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
    );
  }
}