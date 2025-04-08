import 'package:credit_app/core/class/crud.dart';
import 'package:credit_app/linkapi.dart';


class ResetpasswordData {
  final Crud crud;
  ResetpasswordData(this.crud);

  Future<dynamic> postData(
      String resetToken,
      String newPassword,
      String confirmPassword,


      ) async {
    var response = await crud.postData(AppLink.resetPassword, {


      "resetToken": resetToken,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,

    });
    print("Token envoyé: $resetToken");
    return response.fold((l) => l, (r) => r);
  }
}