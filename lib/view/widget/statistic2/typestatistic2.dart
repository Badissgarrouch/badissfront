import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../conroller/statistic/statistic2_controller.dart';


class Typestatistic2 extends StatelessWidget {
  const Typestatistic2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<Statistics2Controller>();

    return Obx(() => Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showMultiSelectDialog(context, controller),
        splashColor: const Color(0xFF2196F3).withOpacity(0.2),
        highlightColor: const Color(0xFF2196F3).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(minWidth: 400),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  controller.selectedStats.isEmpty
                      ? 'Choose statistics'.tr
                      : controller.selectedStats
                      .map((key) => controller.stats[key]!['title'] as String)
                      .join(', '),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color(0xFF424242),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Color(0xFF2196F3), size: 28),
            ],
          ),
        ),
      ),
    )).animate().fadeIn(duration: 500.ms, delay: 200.ms);
  }

  void _showMultiSelectDialog(BuildContext context, Statistics2Controller controller) {
    showDialog(
      context: context,
      builder: (context) {
        List<String> tempSelected = List.from(controller.selectedStats);
        bool selectAll = tempSelected.length == controller.stats.length;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text(
                'Select statistics'.tr,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF212121),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Checkbox(
                        value: selectAll,
                        onChanged: (bool? value) {
                          setDialogState(() {
                            selectAll = value!;
                            tempSelected = value ? List.from(controller.stats.keys) : [];
                          });
                        },
                        activeColor: const Color(0xFF2196F3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        splashRadius: 20,
                      ),
                      title: Text(
                        'Select all'.tr,
                        style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF424242)),
                      ),
                      onTap: () {
                        setDialogState(() {
                          selectAll = !selectAll;
                          tempSelected = selectAll ? List.from(controller.stats.keys) : [];
                        });
                      },
                      splashColor: const Color(0xFF2196F3).withOpacity(0.2),
                      hoverColor: const Color(0xFF2196F3).withOpacity(0.1),
                    ),
                    const Divider(height: 10, thickness: 1, color: Color(0xFFE0E0E0)),
                    ...controller.stats.entries.map((entry) {
                      return ListTile(
                        leading: Checkbox(
                          value: tempSelected.contains(entry.key),
                          onChanged: (bool? value) {
                            setDialogState(() {
                              if (value!) {
                                tempSelected.add(entry.key);
                              } else {
                                tempSelected.remove(entry.key);
                              }
                              selectAll = tempSelected.length == controller.stats.length;
                            });
                          },
                          activeColor: const Color(0xFF2196F3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          splashRadius: 20,
                        ),
                        title: Text(
                          entry.value['title'.tr] as String,
                          style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF424242)),
                        ),
                        trailing: CircleAvatar(
                          backgroundColor: entry.value['color'] as Color,
                          radius: 10,
                          child: Icon(
                            controller.getIconForStat(entry.key),
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          setDialogState(() {
                            if (tempSelected.contains(entry.key)) {
                              tempSelected.remove(entry.key);
                            } else {
                              tempSelected.add(entry.key);
                            }
                            selectAll = tempSelected.length == controller.stats.length;
                          });
                        },
                        splashColor: const Color(0xFF2196F3).withOpacity(0.2),
                        hoverColor: const Color(0xFF2196F3).withOpacity(0.1),
                      );
                    }).toList(),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setDialogState(() {
                      tempSelected.clear();
                      selectAll = false;
                    });
                  },
                  child: Text(
                    'Erase'.tr,
                    style: GoogleFonts.poppins(color: const Color(0xFFF44336)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.updateSelectedStats(tempSelected);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Confirm'.tr,
                    style: GoogleFonts.poppins(color: const Color(0xFF2196F3)),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}