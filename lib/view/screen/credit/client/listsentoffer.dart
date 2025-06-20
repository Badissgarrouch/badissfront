import 'package:credit_app/conroller/credit/client/getsentoffer_controller.dart';
import 'package:credit_app/core/constant/colors.dart';
import 'package:credit_app/view/screen/credit/client/getsentoffer.dart';
import 'package:credit_app/view/screen/credit/client/updateoffer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/class/statusrequest.dart';
import 'package:credit_app/view/widget/listoffer/status.dart';

class ListSentOffer extends StatelessWidget {
  const ListSentOffer({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GetSentOfferControllerImp());

    return Scaffold(
      appBar: AppBar(
        title:  Text("My credit requests".tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: GetBuilder<GetSentOfferControllerImp>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.statusRequest != StatusRequest.success ||
              controller.offers.isEmpty) {
            return  Center(
              child: Text(
                "No offers available".tr,
                style: TextStyle(fontSize: 14, color: Colors.grey,),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.offers.length,
            itemBuilder: (context, index) {
              final offer = controller.offers[index];
              final status = offer['status']?.toString().toLowerCase() ?? 'Unknown'.tr;
              final statusColor = getStatusColor(status);
              final statusText = getStatusText(status);

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.account_balance_wallet_outlined,
                                  color:AppColors.darkBlue),
                              const SizedBox(width: 10),
                              Text(
                                "${"Request number".tr} ${index + 1}",
                                style:  TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'details') {
                                Get.to(() => Getsentoffer(offer: offer));
                              } else if (value == 'modify') {
                                if (offer['status'] == 'modification requested') {
                                  Get.to(
                                        () => UpdateOfferView(),
                                    arguments: {'offerData': offer},
                                  );
                                } else {
                                  Get.snackbar(
                                    "Information".tr,
                                    "Modification possible only if the recipient has requested changes".tr,
                                    backgroundColor: Colors.orange,
                                    colorText: Colors.white,
                                  );
                                }
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                               PopupMenuItem(
                                value: 'details',
                                child: Text('See details'.tr),
                              ),
                              PopupMenuItem(
                                value: 'modify',
                                child: Text(
                                  'Modify'.tr,
                                  style: TextStyle(
                                    color: offer['status'] == 'modification requested'
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                                enabled: offer['status'] == 'modification requested',
                              ),
                            ],
                            icon: const Icon(Icons.more_vert),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: statusColor),
                        ),
                        child: Text(
                          "${"Status".tr} : $statusText",
                          style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${"Recipient".tr} : ${offer['recipientName'] ?? 'N/A'}",
                        style: TextStyle(
                          color: Colors.grey[700],fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${"Date".tr} : ${FormatStatusDate(offer['createdAt']?.toString())}",
                        style:  TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Get.to(() => Getsentoffer(offer: offer));
                          },
                          icon:  Icon(Icons.visibility,color: AppColors.darkBlue,),
                          label: Text("See details".tr),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}