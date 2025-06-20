import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/paypal.dart';
import '../../view/screen/paypal/paypalconfiirmation.dart';
import '../../view/widget/paypal/paypalpaiment/paypal2.dart' as payment_service;

class CheckoutController extends GetxController {
  final selectedPaymentMethod = 'card'.obs;
  final isProcessing = false.obs;
  final paymentData = PaymentData().obs;
  final paymentService = payment_service.PaymentService();
  final formKey = GlobalKey<FormState>();
  final paypalFormKey = GlobalKey<FormState>();
  final billingFormKey = GlobalKey<FormState>();


  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();
  final cardNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalController = TextEditingController();
  final paypalPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    cardNumberController.addListener(() {
      paymentData.update((val) {
        val?.cardNumber = cardNumberController.text;
      });
    });
    expiryController.addListener(() {
      paymentData.update((val) {
        val?.expiryDate = expiryController.text;
      });
    });
    cvvController.addListener(() {
      paymentData.update((val) {
        val?.cvv = cvvController.text;
      });
    });
    cardNameController.addListener(() {
      paymentData.update((val) {
        val?.cardName = cardNameController.text;
      });
    });
    emailController.addListener(() {
      paymentData.update((val) {
        val?.email = emailController.text;
        val?.paypalEmail = emailController.text;
      });
    });
    addressController.addListener(() {
      paymentData.update((val) {
        val?.address = addressController.text;
      });
    });
    cityController.addListener(() {
      paymentData.update((val) {
        val?.city = cityController.text;
      });
    });
    postalController.addListener(() {
      paymentData.update((val) {
        val?.postalCode = postalController.text;
      });
    });
    paypalPasswordController.addListener(() {
      paymentData.update((val) {
        val?.paypalPassword = paypalPasswordController.text;
      });
    });
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    cardNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    postalController.dispose();
    paypalPasswordController.dispose();
    super.onClose();
  }

  void changePaymentMethod(String method) {
    selectedPaymentMethod.value = method;
    paymentData.update((val) {
      val?.paymentMethod = method;
    });
  }

  void validateAndProceed(BuildContext context) async {
    if (selectedPaymentMethod.value == 'card' && !formKey.currentState!.validate()) {
      return;
    }
    if (selectedPaymentMethod.value == 'paypal' && !paypalFormKey.currentState!.validate()) {
      return;
    }
    if (selectedPaymentMethod.value == 'card' && !billingFormKey.currentState!.validate()) {
      return; // Validate billing only for card payments
    }

    // Simulate processing state
    isProcessing.value = true;
    await Future.delayed(const Duration(seconds: 1)); // Brief delay for demo
    isProcessing.value = false;

    Get.to(() => PaymentConfirmationScreen(
      paymentMethod: selectedPaymentMethod.value,
      paymentData: paymentData.value,
      paymentService: paymentService,
    ));
  }
}