import 'package:credit_app/core/class/crud.dart';
import 'package:credit_app/linkapi.dart';


class VerifycodeSignupData {
  final Crud crud;
  VerifycodeSignupData(this.crud);

  Future<dynamic> postData(
      String email,
      String optCode,




      ) async {
    var response = await crud.postData(AppLink.verifycodesignup, {


      "email": email,
      "otpCode":optCode

    });
    return response.fold((l) => l, (r) => r);
  }
}