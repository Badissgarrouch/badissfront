import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../conroller/notification/notification_controller.dart';
import '../../../core/share/content.dart';
import '../../../core/share/dialog_action.dart';
import '../../../core/share/noti_dialogtitle.dart';
import 'noti_type.dart';
class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();
    final localFilterStates = Rx<Map<NotificationType, bool>>(
      Map<NotificationType, bool>.from(controller.filterStates),
    );
    final localSelectAll = RxBool(controller.selectAllFilters.value);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300, maxHeight: 500),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FilterDialogTitle(),
              const SizedBox(height: 16),
              FilterDialogContent(
                localFilterStates: localFilterStates,
                localSelectAll: localSelectAll,
              ),
              const SizedBox(height: 16),
              FilterDialogActions(
                controller: controller,
                localFilterStates: localFilterStates,
                localSelectAll: localSelectAll,
              ),
            ],
          ),
        ),
      ),
    );
  }
}