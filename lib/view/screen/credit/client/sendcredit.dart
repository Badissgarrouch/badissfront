import 'package:credit_app/core/function/validinputcredit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../conroller/credit/client/sendcredit_controller.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/constant/colors.dart';
import '../../../widget/invitation/sendoffer/customtextfield.dart';
import '../../../widget/invitation/sendoffer/formlabel.dart';
import '../../../widget/invitation/sendoffer/header.dart';
import '../../../widget/invitation/sendoffer/monnaiefleid.dart';
import '../../../widget/invitation/sendoffer/submitbutton.dart';

class SendOffer extends StatelessWidget {
  const SendOffer({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(sendOfferControllerImp());
    return Scaffold(
      appBar: AppBar(
        title:Text("Credit Offer".tr,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        centerTitle: true,
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<sendOfferControllerImp>(
          builder: (controller) {
            if (controller.statusRequest == StatusRequest.loading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Lottie.asset(
                        'assets/lotties/loading.json',
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             SectionHeader(
                                title: "Financial Information".tr,
                                icon: Icons.attach_money_outlined),
                            const SizedBox(height: 12),
                             FormLabel(
                                text: "Monthly salary".tr, requiredField: true),
                            CurrencyInput(
                              selectedCurrency: controller.selectedCurrency,
                              valid: (val) {
                                return validInputCredit(val!, 1, 20, "number");
                              },
                              mycontroller: controller.monthlySalary,
                              onCurrencyChanged: controller.updateSelectedCurrency,
                            ),
                            const SizedBox(height: 12),
                            FormLabel(
                                text: "Total Credit".tr, requiredField: true),
                            CurrencyInput(
                              selectedCurrency: controller.selectedCurrency,
                              valid: (val) {
                                return validInputCredit(val!, 1, 20, "number");
                              },
                              mycontroller: controller.totalCredit,
                              onCurrencyChanged: controller.updateSelectedCurrency,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              valid: (val) {
                                return validInputCredit(val!, 1, 20, "number");
                              },
                              mycontroller: controller.duration,
                              label: "Credit duration (months)".tr,
                              requiredField: true,
                              hintText: "Enter the duration".tr,
                              prefixIcon: Icons.calendar_month,
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 365)),
                                );
                                if (selectedDate != null) {
                                  controller.setStartDate(selectedDate);
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
                                      return "Date invalide".tr;
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
                            const SizedBox(height: 20),
                            CustomTextField(
                              valid: (val) {
                                return validInputCredit(val!, 1, 20, "number");
                              },
                              mycontroller: controller.salaryPercentage,
                              label: "Percentage of salary".tr,
                              requiredField: true,
                              hintText: "Enter percentage".tr,
                              prefixIcon: Icons.percent,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              valid: (val) {
                                return validInputCredit(val!, 10, 30, "text");
                              },
                              mycontroller: controller.purpose,
                              label: "Purpose of the credit".tr,
                              requiredField: true,
                              hintText: "Enter the credit reason".tr,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(bottom: 32),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             SectionHeader(
                                title: "Recipient Information".tr,
                                icon: Icons.person_outline),
                            const SizedBox(height: 20),
                            CustomTextField(
                              valid: (val) {
                                return validInputCredit(val!, 3, 20, "alpha");
                              },
                              mycontroller: controller.recipientName,
                              label: "Recipient Name".tr,
                              requiredField: true,
                              hintText: "Enter the merchant's name".tr,
                              prefixIcon: Icons.person_pin_rounded,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              valid: (val) {
                                return validInputCredit(val!, 10, 40, "email");
                              },
                              mycontroller: controller.recipientEmail,
                              label: "Recipient Email".tr,
                              requiredField: true,
                              hintText: "Enter the merchant's email".tr,
                              prefixIcon: Icons.alternate_email,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              valid: (val) {
                                if (val == null || val.isEmpty) return null;
                                return null;
                              },
                              mycontroller: controller.comment,
                              label: "Comment (optional)".tr,
                              requiredField: false,
                              hintText: "Write a comment".tr,
                              prefixIcon: Icons.comment,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                      SubmitButton(
                        text: "Send offer".tr,
                        onPressed: () {
                          controller.sendOffer();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}