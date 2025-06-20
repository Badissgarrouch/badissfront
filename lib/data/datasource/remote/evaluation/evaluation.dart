import 'package:credit_app/core/class/crud.dart';
import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/linkapi.dart';
import 'package:dartz/dartz.dart';

class EvaluationData {
  final Crud crud;

  EvaluationData(this.crud);

  Future<Either<StatusRequest, Map>> submitEvaluation({
    required String receiverFirstName,
    required String receiverLastName,
    required int creditCommunicationStars,
    required int paymentTimelinessStars,
    required int transactionProfessionalismStars,
    required String token,
  }) async {
    final response = await crud.postData(
      AppLink.evaluation,
      {
        'receiverFirstName': receiverFirstName,
        'receiverLastName': receiverLastName,
        'creditCommunicationStars': creditCommunicationStars,
        'paymentTimelinessStars': paymentTimelinessStars,
        'transactionProfessionalismStars': transactionProfessionalismStars,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }
  Future<Either<StatusRequest, Map>> getReceivedEvaluations({
    required String token,
  }) async {
    final response = await crud.getData(
      AppLink.getevaluationclient,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }
}
