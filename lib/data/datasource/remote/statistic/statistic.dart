import 'package:dartz/dartz.dart';
import '../../../../core/class/crud.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../linkapi.dart';

class StatisticsDataSource {
  final Crud crud;

  StatisticsDataSource(this.crud);

  Future<Either<StatusRequest, Map>> getUserStatistics(String token) async {
    final response = await crud.getData(
      AppLink.statistic,
      headers: {'Authorization': 'Bearer $token'},
    );
    return response;
  }

  Future<Either<StatusRequest, Map>> getUserClientStatistics(String token) async {
    final response = await crud.getData(
      AppLink.statistic2,
      headers: {'Authorization': 'Bearer $token'},
    );
    return response;
  }
}

