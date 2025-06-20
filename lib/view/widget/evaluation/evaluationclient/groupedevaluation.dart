import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'clientcard.dart';

class GroupedEvaluations extends StatelessWidget {
  final List<Map<String, dynamic>> evaluations;

  const GroupedEvaluations({super.key, required this.evaluations});

  @override
  Widget build(BuildContext context) {
    if (evaluations.isEmpty) {
      return const Center(child: Text('No reviews available'));
    }

    final groupedEvaluations = <String, List<Map<String, dynamic>>>{};

    for (var eval in evaluations) {
      final sender = eval['sender'] as Map<String, dynamic>?;
      if (sender == null || sender['id'] == null) {
        debugPrint('Skipping evaluation with missing sender: $eval');
        continue;
      }

      final senderId = (sender['id'] as num).toString(); // Convert int to String
      groupedEvaluations.putIfAbsent(senderId, () => []).add(eval);
    }

    if (groupedEvaluations.isEmpty) {
      return  Center(child: Text('No valid reviews found'.tr));
    }

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: groupedEvaluations.entries.map((entry) {
        final senderEvaluations = entry.value;
        final firstSender = senderEvaluations.first['sender'] as Map<String, dynamic>;

        final firstName = firstSender['firstName'] as String? ?? 'Inconnu';
        final lastName = firstSender['lastName'] as String? ?? '';
        final avgStars = _calculateAverageStars(senderEvaluations);

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFF0288D1).withOpacity(0.1),
                      child: Text(
                        '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}',
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF0288D1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '$firstName $lastName',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: Color(0xFFFFB300), size: 20),
                        const SizedBox(width: 4),
                        Text(
                          avgStars.toStringAsFixed(1),
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0288D1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ...senderEvaluations.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: EvaluationCard(evaluation: e),
              )),
            ],
          ),
        );
      }).toList(),
    );
  }

  double _calculateAverageStars(List<Map<String, dynamic>> evaluations) {
    if (evaluations.isEmpty) return 0;
    final sum = evaluations.fold<double>(0, (sum, eval) {
      final commStars = (eval['creditCommunicationStars'] as num?)?.toDouble() ?? 0;
      final timeStars = (eval['paymentTimelinessStars'] as num?)?.toDouble() ?? 0;
      final profStars = (eval['transactionProfessionalismStars'] as num?)?.toDouble() ?? 0;
      return sum + (commStars + timeStars + profStars) / 3;
    });
    return sum / evaluations.length;
  }
}