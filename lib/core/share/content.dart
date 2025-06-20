import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:credit_app/view/widget/notification/noti_utils.dart';
import '../../view/widget/notification/noti_type.dart';
import 'checkboxdialog.dart';

class FilterDialogContent extends StatelessWidget {
  final Rx<Map<NotificationType, bool>> localFilterStates;
  final RxBool localSelectAll;

  const FilterDialogContent({
    super.key,
    required this.localFilterStates,
    required this.localSelectAll,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Obx(
              () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomCheckboxListTile(
                title: 'Selected all'.tr,
                value: localSelectAll.value,
                onChanged: (value) {
                  localSelectAll.value = value!;
                  localFilterStates.value = {...localFilterStates.value}
                    ..updateAll((_, __) => value);
                },
              ),
              const Divider(height: 8, thickness: 1, color: Colors.grey),
              ...NotificationType.values.map((type) => CustomCheckboxListTile(
                title: getTypeName(type),
                value: localFilterStates.value[type] ?? false,
                onChanged: (value) {
                  localFilterStates.value = {
                    ...localFilterStates.value,
                    type: value!,
                  };
                  localSelectAll.value =
                      localFilterStates.value.values.every((v) => v);
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}