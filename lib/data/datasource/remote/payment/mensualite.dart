
import 'package:credit_app/core/class/statusrequest.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class mensualiteData {
  final Crud crud;

  mensualiteData(this.crud);

  Future<Either<StatusRequest, Map>> getData(String senderId,
      String token) async {
    final response = await crud.getData(
      "${AppLink.mensualite}/$senderId",
      headers: {'Authorization': 'Bearer $token'},
    );
    return response;
  }

  Future<Either<StatusRequest, Map>> getMyRecu(String token) async {
    final response = await crud.getData(
      "${AppLink.mymensualite}",
      headers: {'Authorization': 'Bearer $token'},
    );
    return response;
  }
}

