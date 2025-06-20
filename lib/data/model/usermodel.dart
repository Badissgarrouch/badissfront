// data/model/usermodel.dart
import 'package:credit_app/data/model/usermodel2.dart';

class User {
  final String id;
  final String nom;
  final String prenom;
  final String type;
  final String duration;
  final String devise;
  final String totalCredit;
  final DateTime? startDate;
  final List<Mois> mois;

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.type,
    required this.duration,
    required this.devise,
    required this.totalCredit,
    this.startDate,
    required this.mois,
  });

  factory User.fromJson(
      Map<String, dynamic> json,
      String type, {
        String? duration,
        List<Mois>? mois,
        String? devise,
        String? totalCredit,
        DateTime? startDate,
      }) {
    return User(
      id: json['id']?.toString() ?? '',
      nom: json['lastName'] ?? 'Inconnu',
      prenom: json['firstName'] ?? '',
      type: type,
      duration: duration ?? json['duration']?.toString() ?? '0',
      devise: devise ?? json['devise'] ?? 'TND',
      totalCredit: totalCredit ?? json['totalCredit']?.toString() ?? '0',
      startDate: startDate,
      mois: mois ?? [],
    );
  }

  factory User.fromUserAccepted(UserAccepted userAccepted, String type, {List<Mois>? mois}) {
    return User(
      id: userAccepted.id,
      nom: userAccepted.nom,
      prenom: userAccepted.prenom,
      type: type,
      duration: userAccepted.duration,
      devise: userAccepted.devise,
      totalCredit: userAccepted.totalCredit,
      startDate: userAccepted.startDate,
      mois: mois ?? userAccepted.mois
          .asMap()
          .entries
          .map((entry) => Mois(numero: entry.key + 1, paye: false))
          .toList(),
    );
  }
}

class Mois {
  final int numero;
  final bool paye;
  final PaymentDetail? paymentDetail;

  Mois({
    required this.numero,
    required this.paye,
    this.paymentDetail,
  });
}

class PaymentDetail {
  final String paymentId;
  final String cardType;
  final String cardNumber;
  final String receiptImageUrl;
  final String paymentDate;
  final String paymentTime;

  PaymentDetail({
    required this.paymentId,
    required this.cardType,
    required this.cardNumber,
    required this.receiptImageUrl,
    required this.paymentDate,
    required this.paymentTime,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) {
    return PaymentDetail(
      paymentId: json['paymentId']?.toString() ?? '',
      cardType: json['cardType'] ?? 'N/A',
      cardNumber: json['cardNumber'] ?? '•••• •••• •••• ••••',
      receiptImageUrl: json['receiptImageUrl'] ?? '',
      paymentDate: json['paymentDate'] ?? 'N/A',
      paymentTime: json['paymentTime'] ?? 'N/A',
    );
  }
}
