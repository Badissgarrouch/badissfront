import 'dart:ui';

import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import 'package:credit_app/view/widget/notification/noti_items.dart';
import 'package:credit_app/view/widget/notification/noti_type.dart';

class NotificationSortingUtils {
  void vibrateOnSort() {
    Vibration.vibrate(duration: 50);
  }

  List<NotificationItem> _filterNotifications(
      List<NotificationItem> notifications,
      Map<NotificationType, bool> filterStates,
      ) {
    return notifications.where((n) {
      return filterStates[n.type] ?? false;
    }).toList();
  }

  Map<String, List<NotificationItem>> _groupNotifications(
      List<NotificationItem> notifications,
      ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final twoDaysAgo = today.subtract(Duration(days: 2));
    final threeDaysAgo = today.subtract(Duration(days: 3));
    final lastWeek = today.subtract(Duration(days: 7));
    final twoWeeksAgo = today.subtract(Duration(days: 14));
    final lastMonth = DateTime(now.year, now.month - 1, now.day);
    final twoMonthsAgo = DateTime(now.year, now.month - 2, now.day);
    final lastThreeMonths = DateTime(now.year, now.month - 3, now.day);
    final sixMonthsAgo = DateTime(now.year, now.month - 6, now.day);
    final lastYear = DateTime(now.year - 1, now.month, now.day);

    return {
      'New'.tr: notifications.where((n) => n.time.isAfter(today)).toList(),
      'Yesterday'.tr: notifications.where((n) => n.time.isAfter(yesterday) && n.time.isBefore(today)).toList(),
      '2 days ago'.tr: notifications.where((n) => n.time.isAfter(twoDaysAgo) && n.time.isBefore(yesterday)).toList(),
      '3 days ago'.tr: notifications.where((n) => n.time.isAfter(threeDaysAgo) && n.time.isBefore(twoDaysAgo)).toList(),
      'Last Week'.tr: notifications.where((n) => n.time.isAfter(lastWeek) && n.time.isBefore(threeDaysAgo)).toList(),
      '2 weeks ago'.tr: notifications.where((n) => n.time.isAfter(twoWeeksAgo) && n.time.isBefore(lastWeek)).toList(),
      'Last Month'.tr: notifications.where((n) => n.time.isAfter(lastMonth) && n.time.isBefore(twoWeeksAgo)).toList(),
      '2 months ago'.tr: notifications.where((n) => n.time.isAfter(twoMonthsAgo) && n.time.isBefore(lastMonth)).toList(),
      'Last 3 months'.tr: notifications.where((n) => n.time.isAfter(lastThreeMonths) && n.time.isBefore(twoMonthsAgo)).toList(),
      '6 months ago'.tr: notifications.where((n) => n.time.isAfter(sixMonthsAgo) && n.time.isBefore(lastThreeMonths)).toList(),
      'Older than 6 months'.tr: notifications.where((n) => n.time.isBefore(sixMonthsAgo) && n.time.isAfter(lastYear)).toList(),
      'More than a year'.tr: notifications.where((n) => n.time.isBefore(lastYear)).toList(),
    };
  }

  List<Map<String, dynamic>> filterAndGroupNotifications({
    required List<NotificationItem> notifications,
    required Map<NotificationType, bool> filterStates,
  }) {
    final filtered = _filterNotifications(notifications, filterStates);
    final grouped = _groupNotifications(filtered);

    return grouped.entries
        .where((entry) => entry.value.isNotEmpty)
        .map((entry) => {'period': entry.key, 'notifications': entry.value})
        .toList();
  }
}