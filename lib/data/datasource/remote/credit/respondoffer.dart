import 'package:dartz/dartz.dart';

import '../../../../core/class/crud.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../linkapi.dart';

class RespondOfferData {
  final Crud crud;
  RespondOfferData(this.crud);

  Future<dynamic> postData({
    required String token,
    required String offerId,
    required String action,
    String? comment,
  }) async {

    if (offerId.isEmpty) {
      return Left(StatusRequest.fail);
    }

    var response = await crud.postData(
      AppLink.respondtoffer,
      {
        'offerId': offerId,
        'action': action,
        if (comment != null) 'comment': comment,
      },
      headers: {'Authorization': 'Bearer $token'},
    );

    return response.fold((l) => l, (r) => r);
  }
}