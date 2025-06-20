import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../conroller/invitation/getfriends_controller.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/routes.dart';

class FriendsListScreen extends StatelessWidget {
  const FriendsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GetFriendsControllerImp());

    return Scaffold(
      backgroundColor: AppColors.blue50,
      appBar: AppBar(
        title: Text(
          'My Friends'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: AppColors.blue600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.blue900,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder<GetFriendsControllerImp>(
        builder: (controller) {
          if (controller.isLoading) {
            return Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.blue200,
                ),
              ),
            );
          }

          if (controller.friendsList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline_rounded,
                    size: 40,
                    color: Colors.grey[700],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No friends yet'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start adding friends to see them here'.tr,
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          final clients = controller.friendsList.where((
              friend) => friend['businessName'] == null).toList();
          final merchants = controller.friendsList.where((
              friend) => friend['businessName'] != null).toList();

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (clients.isNotEmpty) ...[
                    buildSectionTitle('Customers'.tr),
                    const SizedBox(height: 8),
                    buildFriendsList(clients, false, controller),
                    const SizedBox(height: 24),
                  ],
                  if (merchants.isNotEmpty) ...[
                    buildSectionTitle('Traders'.tr),
                    const SizedBox(height: 8),
                    buildFriendsList(merchants, true, controller),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBlue,
      ),
    );
  }

  Widget buildFriendsList(List<dynamic> friends, bool isMerchant,
      GetFriendsControllerImp controller) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friend = friends[index];
        return Card(
          color: Colors.white,
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isMerchant ? AppColors.blue600 : AppColors.blue200,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${friend['firstName'][0]}${friend['lastName'][0]}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isMerchant ? Colors.white : AppColors.darkBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${friend['firstName']} ${friend['lastName']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        if (isMerchant && friend['businessName'] != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              friend['businessName'],
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (isMerchant)
                    IconButton(
                      icon: Icon(
                        Icons.credit_card,
                        color: AppColors.darkBlue,
                      ),
                      onPressed: () {
                        Get.toNamed(AppRoute.clientpaymentScreen,arguments: {'merchantId': friend['id'].toString()} );
                      },
                      splashColor: AppColors.blue300,
                      highlightColor: AppColors.blue300,
                    ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: AppColors.darkBlue,
                    ),
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Confirmation'.tr,
                        middleText: 'Do you really want to delete this friend?'
                            .tr,
                        textConfirm: 'Confirm'.tr,
                        textCancel: 'Cancel'.tr,
                        confirmTextColor: Colors.white,
                        cancelTextColor: AppColors.darkBlue,
                        buttonColor: AppColors.darkBlue,
                        onConfirm: () {
                          controller.deleteFriendship(friend['id'].toString());
                        },
                      );
                    },
                    splashColor: AppColors.blue300,
                    highlightColor: AppColors.blue300,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}