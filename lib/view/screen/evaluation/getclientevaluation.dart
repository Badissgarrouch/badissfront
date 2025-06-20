import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../conroller/evaluation/clientevaluation_controller.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/class/wave.dart';
import '../../widget/evaluation/evaluationclient/customloader.dart';
import '../../widget/evaluation/evaluationclient/emptystate.dart';
import '../../widget/evaluation/evaluationclient/error.dart';
import '../../widget/evaluation/evaluationclient/groupedevaluation.dart';
import '../../widget/evaluation/evaluationclient/rating.dart';
import '../../widget/evaluation/evaluationclient/satisfactionfilter.dart';

class ReceivedEvaluations extends StatelessWidget {
  final String? token;

  const ReceivedEvaluations({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    Get.put(ReceivedEvaluationsController(token: token));

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0288D1), Color(0xFF01579B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star_rounded,
                                  color: Colors.white, size: 28),
                              const SizedBox(width: 12),
                              Text(
                                'Ratings received'.tr,
                                style: GoogleFonts.roboto(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(() {
              final controller = Get.find<ReceivedEvaluationsController>();
              final evaluations = controller.filteredEvaluations;
              final status = controller.status.value;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SatisfactionFilter(controller: controller),
                    const SizedBox(height: 16),
                    if (status == StatusRequest.loading)
                      const Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: CustomLoader(),
                      )
                    else if (status == StatusRequest.failure)
                      const ErrorState()
                    else if (status == StatusRequest.success && evaluations.isEmpty)
                        const EmptyState()
                      else if (status == StatusRequest.success)
                          Column(
                            children: [
                              RatingSummaryChart(evaluations: evaluations),
                              const SizedBox(height: 24),
                              GroupedEvaluations(evaluations: evaluations),
                            ],
                          ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}