import 'package:credit_app/core/class/crud.dart';
import 'package:credit_app/linkapi.dart';

class SendCreditData {
  final Crud crud;
  SendCreditData(this.crud);

  Future<dynamic> postData({
    required double monthlySalary,
    required double totalCredit,
    required String devise,
    required int duration,
    required DateTime startDate,
    required double salaryPercentage,
    required String purpose,
    required String recipientName,
    required String recipientEmail,
    required String token,
    String? comment,
  }) async {
    var response = await crud.postData(
      AppLink.sendcredit,
      {
        "monthlySalary": monthlySalary,
        "totalCredit": totalCredit,
        "devise": devise,
        "duration": duration,
        "startDate": startDate.toIso8601String(),
        "salaryPercentage": salaryPercentage,
        "purpose": purpose,
        "recipientName": recipientName,
        "recipientEmail": recipientEmail,
        "comment": comment ?? "",
      },
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return response.fold((l) => l, (r) => r);
  }
}