import 'package:credit_app/core/class/crud.dart';
import 'package:credit_app/core/class/statusrequest.dart';

import 'package:credit_app/data/datasource/remote/home/search.dart';
import 'package:credit_app/linkapi.dart';
import 'package:dartz/dartz.dart';

class UserDataSource {
  final Crud crud;

  UserDataSource({required this.crud});

  Future<Either<StatusRequest, SearchModel>> updateUserInfo({
    required String token,
    String? firstName,
    String? lastName,
  }) async {
    final response = await crud.putData(
      AppLink.updatename,
      {
        if (firstName != null) 'firstName': firstName,
        if (lastName != null) 'lastName': lastName,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response.fold(
          (status) => Left(status),
          (data) {
        if (data['status'] == 'success') {
          return Right(SearchModel.fromJson(data['data']));
        } else {
          return Left(StatusRequest.serverfailure);
        }
      },
    );
  }
}