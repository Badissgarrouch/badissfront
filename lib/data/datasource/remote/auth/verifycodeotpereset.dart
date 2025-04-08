import 'package:credit_app/core/class/crud.dart';
import 'package:credit_app/linkapi.dart';


class VerifycodeotperesetData {
  final Crud crud;
  VerifycodeotperesetData(this.crud);

  Future<dynamic> postData(

      String email,

      String otpCode,


      ) async {
    var response = await crud.postData(AppLink.verifyPasswordResetOtp, {


      "email": email,
      "otpCode": otpCode,

    });
    return response.fold((l) => l, (r) => r);
  }
}