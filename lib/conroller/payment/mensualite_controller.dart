
import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/data/datasource/remote/payment/mensualite.dart';
import 'package:credit_app/data/model/usermodel.dart';
import 'package:credit_app/data/model/usermodel2.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final mensualiteData dataSource;
  var status = StatusRequest.none.obs;
  var user = Rxn<User>();

  PaymentController(this.dataSource);

  Future<void> fetchClientPayments(String senderId, String token) async {
    status.value = StatusRequest.loading;

    final response = await dataSource.getData(senderId, token);

    response.fold(
          (failure) {
        status.value = failure;
      },
          (data) {
        final client = data['client'];
        final payments = List<Map>.from(data['payments'] ?? []);
        final duration = data['duration']?.toString() ?? '0';
        final paymentCount = data['paymentCount'] ?? 0;

        final mois = List.generate(
          int.parse(duration),
              (index) => Mois(
            numero: index + 1,
            paye: index < paymentCount,
            paymentDetail: index < payments.length
                ? PaymentDetail.fromJson(
              Map<String, dynamic>.from({
                'paymentId': payments[index]['id']?.toString() ?? '',
                'cardType': payments[index]['cardType'] ?? 'N/A',
                'cardNumber': payments[index]['cardNumber'] ?? '•••• •••• •••• ••••',
                'receiptImageUrl': payments[index]['receiptImageUrl'] ?? '',
                'paymentDate': payments[index]['paymentDate'] ?? 'N/A',
                'paymentTime': payments[index]['paymentTime'] ?? 'N/A',
              }),
            )
                : null,
          ),
        );

        user.value = User.fromJson(
          client,
          client['userType'] ?? '1',
          duration: duration,
          mois: mois,
        );

        status.value = StatusRequest.success;
      },
    );
  }

  Future<void> fetchMyPayments(String receiverId, String token, UserAccepted userAccepted) async {
    status.value = StatusRequest.loading;

    final response = await dataSource.getMyRecu(token);

    response.fold(
          (failure) {
        status.value = failure;
      },
          (data) {
        final receipts = List<Map>.from(data['receipts'] ?? []);
        final filteredReceipts = receipts.where((receipt) => receipt['receiverId'].toString() == receiverId).toList();
        final paymentCount = filteredReceipts.length;
        final duration = filteredReceipts.isNotEmpty ? filteredReceipts[0]['duration']?.toString() ?? userAccepted.duration : userAccepted.duration;

        final mois = List.generate(
          int.parse(duration),
              (index) => Mois(
            numero: index + 1,
            paye: index < paymentCount,
            paymentDetail: index < filteredReceipts.length
                ? PaymentDetail.fromJson(Map<String, dynamic>.from(filteredReceipts[index]))
                : null,
          ),
        );

        user.value = User.fromUserAccepted(userAccepted, 'client', mois: mois);

        status.value = StatusRequest.success;
      },
    );
  }
}
