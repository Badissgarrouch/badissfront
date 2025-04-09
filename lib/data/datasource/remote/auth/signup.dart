import 'package:credit_app/core/class/crud.dart';
import 'package:credit_app/linkapi.dart';


class SignupData {
  final Crud crud;
  SignupData(this.crud);

  Future<dynamic> postData(
      String firstName,
      String lastName,

      String email,
      String phone,
      String carteCin,
      String password,

      String confirmPassword,
      String userType,
      ) async {
    var response = await crud.postData(AppLink.signUp, {

      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
      "carteCin": carteCin,
      "password": password,
      "confirmPassword": confirmPassword,
      "userType": userType,
    });
    return response.fold((l) => l, (r) => r);
  }
}