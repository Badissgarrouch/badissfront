import 'package:credit_app/core/class/crud.dart';
import 'package:credit_app/linkapi.dart';


class Signup2Data {
  final Crud crud;
  Signup2Data(this.crud);

  Future<dynamic> postData(
      String firstName,
      String lastName,

      String email,
      String phone,
      String businessAddress,
      String businessName,
      String sectorOfActivity,
      String password,

      String confirmPassword,
      String userType,
      ) async {
    var response = await crud.postData(AppLink.signUp2, {

      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
      "businessAddress":businessAddress,
      "businessName":businessName,
      "sectorOfActivity":sectorOfActivity,

      "password": password,
      "confirmPassword": confirmPassword,
      "userType": userType,
    });
    return response.fold((l) => l, (r) => r);
  }
}