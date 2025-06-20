import 'package:credit_app/core/class/crud.dart';
import 'package:credit_app/linkapi.dart';

class UpdateOfferData {
  final Crud crud;
  UpdateOfferData(this.crud);

  Future<dynamic> putData({
    required int offerId,
    required double monthlySalary,
    required double totalCredit,
    required String devise,
    required int duration,
    required DateTime startDate,
    required double salaryPercentage,
    required String purpose,
    required String token,
  }) async {
    var response = await crud.putData(
      AppLink.modifyOffer,
      {
        "offerId": offerId,
        "monthlySalary": monthlySalary,
        "totalCredit": totalCredit,
        "devise": devise,
        "duration": duration,
        "startDate": startDate.toIso8601String(),
        "salaryPercentage": salaryPercentage,
        "purpose": purpose,
      },
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}