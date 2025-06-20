import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../conroller/notification/notification_controller.dart';
import '../../../core/constant/colors.dart';
import '../../widget/notification/deletedialog.dart';
import '../../widget/notification/dialog.dart';
import '../../widget/notification/noti_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final visibleNotificationCount = controller.filterAndGroupNotifications().fold<int>(
            0,
                (sum, group) => sum + (group['notifications'] as List).length,
          );
          return Row(
            children: [
              Flexible(
                child: Text(
                  'Notifications'.tr,
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.red[600]!, Colors.red[800]!]),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$visibleNotificationCount',
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          );
        }),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[600]!, Colors.teal[400]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border(bottom: BorderSide(color: Colors.teal[200]!, width: 2)),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.white),
            onPressed: () => Get.dialog(const FilterDialog()),
            tooltip: 'Filter'.tr,
          ),
          IconButton(
            icon: Icon(Icons.delete_forever, color: Colors.red[600]),
            onPressed: () => Get.dialog(const ClearNotificationsDialog()),
            tooltip: 'Delete all'.tr,
          ),
        ],
      ),
      body: Obx(() {
        final groupedNotifications = controller.filterAndGroupNotifications();
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: Colors.blue[600]));
        }
        if (groupedNotifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications_off, size: 30, color: Colors.grey[900], semanticLabel: 'No notifications'.tr),
                const SizedBox(height: 5),
                Text(
                  'No notifications'.tr,
                  style: TextStyle(fontSize: 16, color: Colors.grey[900]),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: groupedNotifications.length,
          itemBuilder: (context, index) {
            final group = groupedNotifications[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    group['period'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue700,
                      fontSize: 18,
                    ),
                  ),
                ),
                ...group['notifications'].map<Widget>((notification) {
                  return NotificationCard(notification: notification);
                }).toList(),
              ],
            );
          },
        );
      }),
    );
  }
}