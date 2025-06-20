
import 'package:credit_app/view/widget/paypal/paypalpaiment/paypal3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../conroller/paypal/paypal_controller.dart';
import '../../../../core/class/paypalformcontainer.dart';
import '../../../../core/class/paypalinputdeco.dart';
import '../../../../core/class/paypaltextfield.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/countries.dart';


class CardAndBillingForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const CardAndBillingForm({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CheckoutController>();

    return FormContainer(
      title: 'Payment details'.tr,
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: controller.cardNumberController,
                label: 'Card number'.tr,
                icon: Icons.credit_card,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  CardNumberInputFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the card number'.tr;
                  }
                  if (value.replaceAll(' ', '').length < 16) {
                    return 'Invalid card number'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller.expiryController,
                      label: 'Expiry'.tr,
                      icon: Icons.calendar_today,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        ExpiryDateInputFormatter(),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Date required'.tr;
                        }
                        if (value.length < 5) {
                          return 'MM/YY format'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      controller: controller.cvvController,
                      label: 'CVV'.tr,
                      icon: Icons.lock,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      maxLength: 4,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'CVV required'.tr;
                        }
                        if (value.length < 3) {
                          return 'Invalid CVV'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: controller.cardNameController,
                label: 'Name on card'.tr,
                icon: Icons.person,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name on the card'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Billing address'.tr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue400, // AppColors.blue400
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: controller.emailController,
                label: 'Email'.tr,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email'.tr;
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Invalid email'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: controller.addressController,
                label: 'Address'.tr,
                icon: Icons.home,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller.cityController,
                      label: 'City'.tr,
                      icon: Icons.location_city,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your city'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      controller: controller.postalController,
                      label: 'Postcode'.tr,
                      icon: Icons.markunread_mailbox,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your postal code'.tr;
                        }
                        if (!RegExp(r'^\d{4}$').hasMatch(value)) {
                          return 'Invalid postal code'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Obx(() => DropdownButtonFormField<String>(
                value: controller.paymentData.value.country,
                decoration: FormUtils.buildInputDecoration(
                  label: 'Pays'.tr,
                  icon: Icons.public,
                ),
                isExpanded: true,
                items: countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country['code'],
                    child: Text(
                      '${country['flag']} ${country['name']}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.paymentData.update((val) {
                    val?.country = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a country'.tr;
                  }
                  return null;
                },
                dropdownColor: Colors.white,
                menuMaxHeight: 300,
              )),
            ],
          ),
        ),
      ],
    );
  }
}