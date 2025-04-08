import 'package:credit_app/core/class/crud.dart';
import 'package:credit_app/linkapi.dart';


class ForgotpasswordData {
  final Crud crud;
  ForgotpasswordData(this.crud);

  Future<dynamic> postData(

      String email,




      ) async {
    var response = await crud.postData(AppLink.forgotPassword, {


      "email": email,


    });
    return response.fold((l) => l, (r) => r);
  }
}