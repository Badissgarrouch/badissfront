import 'package:credit_app/core/class/crud.dart';
import '../../../../linkapi.dart';
class UserOfferData {
  final Crud crud;

  UserOfferData(this.crud);

  Future<dynamic> getData({required String token}) async {
    var response = await crud.getData(
      AppLink.useroffer,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
class MyacceptedofferData {
  final Crud crud;

  MyacceptedofferData(this.crud);

  Future<dynamic> getData({required String token}) async {
    var response = await crud.getData(
      AppLink.myacceptedoffer,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}