import 'package:credit_app/core/class/crud.dart';
import 'package:credit_app/linkapi.dart';


class LoginData {
  final Crud crud;
  LoginData(this.crud);

  Future<dynamic> postData(

      String email,

      String password,


      ) async {
    var response = await crud.postData(AppLink.login, {


      "email": email,
      "password": password,

    });
    return response.fold((l) => l, (r) => r);
  }
}