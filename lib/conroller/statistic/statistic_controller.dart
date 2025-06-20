import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/class/crud.dart';
import '../../core/function/statistic/barres.dart';
import '../../core/function/statistic/circulaire.dart';
import '../../core/function/statistic/courbes.dart';
import '../../core/class/statusrequest.dart';

import '../../data/datasource/remote/statistic/statistic.dart';

class StatisticsController extends GetxController {
  final stats = <String, Map<String, dynamic>>{}.obs;
  final selectedStats = [
    'friends',
    'invitations_sent',
    'invitations_received',
    'offers_sent',
    'offers_received',
    'offers_accepted_by_me',
    'offers_accepted_on_me',
    'offers_rejected_by_me',
    'offers_rejected_on_me',
    'pending_payments_by_me',
    'pending_payments_on_me',
    'completed_payments_by_me',
    'completed_payments_on_me',
  ].obs;
  final chartType = 'Line'.obs;
  final statusRequest = StatusRequest.none.obs;
  final StatisticsDataSource dataSource;
  final String? token;

  StatisticsController({required this.token})
      : dataSource = Get.put(StatisticsDataSource(Get.put(Crud())));

  final statKeyToTranslationKey = {
    'friends': 'Friends',
    'invitations_sent': 'Invitations Sent',
    'invitations_received': 'Invitations Received',
    'offers_sent': 'Offers Sent',
    'offers_received': 'Offers Received',
    'offers_accepted_by_me': 'Offers accepted by me',
    'offers_accepted_on_me': 'Offers accepted on me',
    'offers_rejected_by_me': 'Offers rejected by me',
    'offers_rejected_on_me': 'Offers rejected on me',
    'pending_payments_by_me': 'Pending Payment by me',
    'pending_payments_on_me': 'Pending Payment on me',
    'completed_payments_by_me': 'Completed Payment by me',
    'completed_payments_on_me': 'Completed Payment on me',
  };





  // Local color mapping
  final colorMap = {
    'friends': const Color(0xFF4CAF50),
    'invitations_sent': const Color(0xFFFF9800),
    'invitations_received': const Color(0xFF3F51B5),
    'offers_sent':const Color(0xFFD81B60),
    'offers_received': const Color(0xFF2196F3),
    'offers_accepted_by_me': const Color(0xFF4CAF50),
    'offers_accepted_on_me': const Color(0xFF66BB6A),
    'offers_rejected_by_me': const Color(0xFFF44336),
    'offers_rejected_on_me': const Color(0xFFE57373),
    'pending_payments_by_me': const Color(0xFFFFC107),
    'pending_payments_on_me': const Color(0xFFFFD54F),
    'completed_payments_by_me': const Color(0xFF9C27B0),
    'completed_payments_on_me': const Color(0xFFBA68C8),
  };

  int get totalTransactions {
    return selectedStats.fold(0, (sum, key) {
      return sum + (stats[key]!['data'] as List<int>).reduce((a, b) => a + b);
    });
  }

  @override
  void onInit() {
    super.onInit();
    fetchStatistics();
  }

  Future<void> fetchStatistics() async {
    statusRequest.value = StatusRequest.loading;

    if (token == null) {
      statusRequest.value = StatusRequest.authfailure;
      Get.snackbar('Erreur', 'Session expirée. Veuillez vous reconnecter.');
      Get.offNamed('/login');
      return;
    }

    final response = await dataSource.getUserStatistics(token!);

    response.fold(
          (failure) {
        statusRequest.value = failure;
        print('Failed to fetch statistics: $failure');
        if (failure == StatusRequest.authfailure) {
          Get.snackbar('Erreur', 'Session invalide. Veuillez vous reconnecter.');
          Get.offNamed('/login');
        } else {
          Get.snackbar('Erreur', 'Impossible de charger les statistiques.');
        }
      },
          (data) {
        final backendStats = data['data'] as Map<String, dynamic>;
        final updatedStats = backendStats.map((key, value) => MapEntry(key, {
          'title': statKeyToTranslationKey[key]?.tr ?? value['title'],
          'data': List<int>.from(value['data']),
          'color': colorMap[key] ?? const Color(0xFF000000),
        }));
        stats.assignAll(updatedStats);
        statusRequest.value = StatusRequest.success;
      },
    );
  }

  void updateChartType(String? value) {
    chartType.value = value ?? 'Line';
  }

  void updateSelectedStats(List<String> newStats) {
    selectedStats.assignAll(newStats);
  }

  IconData getIconForStat(String key) {
    switch (key) {
      case 'friends':
        return Icons.group;
      case 'invitations_sent':
        return Icons.send;
      case 'invitations_received':
        return Icons.group_add;
      case 'offers_sent':
        return Icons.person_add;
      case 'offers_received':
        return Icons.card_giftcard;
      case 'offers_accepted_by_me':
      case 'offers_accepted_on_me':
        return Icons.check_circle;
      case 'offers_rejected_by_me':
      case 'offers_rejected_on_me':
        return Icons.cancel;
      case 'pending_payments_by_me':
      case 'pending_payments_on_me':
        return Icons.hourglass_empty;
      case 'completed_payments_by_me':
      case 'completed_payments_on_me':
        return Icons.payment;
      default:
        return Icons.info;
    }
  }

  LineChartData buildLineChartData() {
    return generateLineChartData(
      selectedStats: selectedStats,
      stats: stats,
    );
  }

  BarChartData buildBarChartData() {
    return generateBarChartData(
      selectedStats: selectedStats,
      stats: stats,
    );
  }

  PieChartData buildPieChartData() {
    return generatePieChartData(
      selectedStats: selectedStats,
      stats: stats,
      getIconForStat: getIconForStat,
    );
  }
}