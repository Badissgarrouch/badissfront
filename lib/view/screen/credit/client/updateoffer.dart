import 'package:credit_app/core/function/validinputcredit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../conroller/credit/client/updateoffer_controller.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/constant/colors.dart';
import '../../../widget/auth/custombutton.dart';
import '../../../widget/invitation/sendoffer/customtextfield.dart';
import '../../../widget/invitation/sendoffer/formlabel.dart';
import '../../../widget/invitation/sendoffer/monnaiefleid.dart';

class UpdateOfferView extends StatelessWidget {
  const UpdateOfferView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UpdateOfferControllerImp());
    return Scaffold(
      appBar: AppBar(
        title:Text("Modify the Offer".tr,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: GetBuilder<UpdateOfferControllerImp>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/success.json',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
                repeat: true,
              ),
            );
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.edit,
                                    color: AppColors.darkBlue, size: 24),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    "Current Information".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                             FormLabel(
                                text: "New monthly salary".tr, requiredField: true),
                            CurrencyInput(
                              selectedCurrency: 'TND',
                              valid: (val) {
                                return validInputCredit(val!, 1, 20, "number");
                              },
                              mycontroller: controller.monthlySalary,
                            ),
                            const SizedBox(height: 16),
                             FormLabel(
                                text: "New total credit".tr, requiredField: true),
                            CurrencyInput(
                              selectedCurrency: 'TND',
                              valid: (val) {
                                return validInputCredit(val!, 1, 20, "number");
                              },
                              mycontroller: controller.totalCredit,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              valid: (val) {
                                return validInputCredit(val!, 2, 20, "number");
                              },
                              mycontroller: controller.duration,
                              label: "New duration (months)".tr,
                              requiredField: true,
                              hintText: "Enter the duration".tr,
                              prefixIcon: Icons.calendar_month,
                            ),GestureDetector(
                              onTap: () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 365)),
                                );
                                if (selectedDate != null) {
                                  controller.startDate.text =
                                  "${selectedDate.day.toString().padLeft(2, '0')}/"
                                      "${selectedDate.month.toString().padLeft(2, '0')}/"
                                      "${selectedDate.year}";
                                }
                              },
                              child: AbsorbPointer(
                                child: CustomTextField(
                                  valid: (val) {
                                    if (val!.isEmpty) return "This field is required".tr;
                                    try {
                                      final parts = val.split('/');
                                      if (parts.length != 3) return "Format DD/MM/YYYY".tr;
                                      final day = int.parse(parts[0]);
                                      final month = int.parse(parts[1]);
                                      final year = int.parse(parts[2]);
                                      DateTime(year, month, day);
                                      return null;
                                    } catch (e) {
                                      return "Invalid date".tr;
                                    }
                                  },
                                  mycontroller: controller.startDate,
                                  label: "Payment date".tr,
                                  requiredField: true,
                                  hintText: "DD/MM/YYYY".tr,
                                  prefixIcon: Icons.calendar_today,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              valid: (val) {
                                return validInputCredit(val!, 1, 20, "number");
                              },
                              mycontroller: controller.salaryPercentage,
                              label: "New salary percentage".tr,
                              requiredField: true,
                              hintText: "Enter the percentage".tr,
                              prefixIcon: Icons.percent,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              valid: (val) {
                                return validInputCredit(val!, 10, 30, "text");
                              },
                              mycontroller: controller.purpose,
                              label: "New purpose of credit".tr,
                              requiredField: false,
                              hintText: "Enter the purpose",
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.comment,
                                    color: AppColors.darkBlue, size: 24),
                                const SizedBox(width: 8),
                                Flexible(  // Added Flexible to prevent overflow
                                  child: Text(
                                    "Trader comment".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                controller.modificationRequest.text,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height:12),

                    // Submit Button
                    Custombutton(
                      text: "submit".tr,
                      onPressed: () {
                        controller.updateOffer();
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}