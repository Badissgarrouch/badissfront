
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/class/crud.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../linkapi.dart';

class MerchantCardService {
  final Crud crud;

  MerchantCardService(this.crud);

  Future<Either<StatusRequest, List<Map<String, dynamic>>>> getMerchantCards({
    required String merchantId,
    required String token,
  }) async {
    try {
      final response = await crud.getData(
        "${AppLink.getmerchantcard}/$merchantId",
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      return response.fold(
            (l) => Left(l),
            (r) {
          final List<dynamic> cardsData = r['cards'] ?? [];
          final List<Map<String, dynamic>> cards = cardsData.map((card) {
            return {
              'cardType': card['cardType'],
              'cardNumber': card['cardNumber'] ?? 'Non disponible', // Gestion du null
            };
          }).toList();
          return Right(cards);
        },
      );
    } catch (e) {
      return Left(StatusRequest.serverfailure);
    }
  }
}
class PaymentService {
  final Crud crud;

  PaymentService(this.crud);

  Future<Either<StatusRequest, Map<String, dynamic>>> post2Data({
    required String token,
    required String merchantId,
    required String cardType,
    required String cardNumber,
    required File receiptImage,
    required String paymentDate,
    required String paymentTime,
  }) async {
    try {
      if (!await receiptImage.exists()) {
        return Left(StatusRequest.failure);
      }

      // Préparer les données
      Map<String, dynamic> data = {
        'merchantId': merchantId,
        'cardType': cardType,
        'cardNumber': cardNumber,
        'paymentDate': paymentDate,
        'paymentTime': paymentTime,
      };

      // Envoyer la requête
      var response = await crud.post2Data(
        AppLink.envoyerrecu,
        data,
        receiptImage,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      return response.fold(
            (l) => Left(l),
            (r) => Right(r as Map<String, dynamic>),
      );
    } catch (e) {
      print('Error in PaymentService: $e');
      return Left(StatusRequest.serverfailure);
    }
  }
}