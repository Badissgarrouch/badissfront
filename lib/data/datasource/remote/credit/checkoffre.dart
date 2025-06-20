import 'package:credit_app/core/class/crud.dart';
import 'package:credit_app/linkapi.dart';

class CheckOfferData {
  final Crud crud;

  CheckOfferData(this.crud);

  Future<dynamic> getData({
    required String token,
  }) async {
    var response = await crud.getData(
      "${AppLink.getoffercredit}",
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
class getmysentofferData {
  final Crud crud;

  getmysentofferData(this.crud);

  Future<dynamic> getData({
    required String token,
  }) async {
    var response = await crud.getData(
      "${AppLink.getmysentoffer}",
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
