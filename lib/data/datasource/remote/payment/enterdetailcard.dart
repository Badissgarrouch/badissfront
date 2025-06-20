import 'package:credit_app/core/class/crud.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../linkapi.dart';

class PaymentCardService {
  final Crud crud = Get.find();

  Future<Either<StatusRequest, Map<String, dynamic>>> getUserCards({
    required String token,
  }) async {
    try {
      final response = await crud.getData(
        AppLink.enterdetailcartes,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      return response.fold(
            (l) => Left(l),
            (r) => Right(r as Map<String, dynamic>),
      );
    } catch (e) {
      return Left(StatusRequest.serverfailure);
    }
  }

  Future<Either<StatusRequest, Map<String, dynamic>>> postData({
    required List<Map<String, dynamic>> cards,
    required String action,
    required String token,
  }) async {
    try {
      final response = await crud.postData(
        AppLink.enterdetailcartes,
        {
          'cards': cards,
          'action': action,
        },
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      return response.fold(
            (l) => Left(l),
            (r) => Right(r as Map<String, dynamic>),
      );
    } catch (e) {
      return Left(StatusRequest.serverfailure);
    }
  }
}