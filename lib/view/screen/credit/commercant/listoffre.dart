import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:credit_app/conroller/credit/commercant/checkoffre_controller.dart';
import 'package:credit_app/core/constant/colors.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../widget/listoffer/card.dart';


class OfferListScreen extends StatelessWidget {
  const OfferListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CheckOfferControllerImp());

    return Scaffold(
      appBar: AppBar(
        title:  Text("Customer offers".tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: GetBuilder<CheckOfferControllerImp>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.statusRequest != StatusRequest.success || controller.offers.isEmpty) {
            return Center(
              child: Text(
                "No offers available".tr,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.offers.length,
            itemBuilder: (context, index) {
              return OfferCard(index: index, offer: controller.offers[index].cast<String, dynamic>());
            },
          );
        },
      ),
    );
  }
}
