import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../conroller/payment/enterdetailcard_controller.dart';
import '../../widget/payment/entercarddetail/dropdown.dart';
import '../../widget/payment/entercarddetail/image.dart';
import '../../widget/payment/entercarddetail/increment.dart';
import '../../widget/payment/entercarddetail/numerocard.dart';
import '../../widget/payment/entercarddetail/header.dart';

class EnterCardDetail extends StatelessWidget {
  const EnterCardDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EnterDetailCardControllerImp>(
      init: EnterDetailCardControllerImp(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const MyCard(),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  const CardImageBanner(),
                  const SizedBox(height: 16),
                  ...List.generate(controller.cardFields.length, (index) {
                    final field = controller.cardFields[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index > 0) Increment(index: index),
                        Dropdown(
                          field: field,
                          controller: controller,
                        ),
                        const SizedBox(height: 16),
                        Numerocard(
                          field: field,
                          controller: controller,
                          index: index,
                        ),
                        const SizedBox(height: 24),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}