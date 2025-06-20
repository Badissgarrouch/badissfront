import 'package:intl/intl.dart';

class UserAccepted {
  final String id;
  final String nom;
  final String prenom;
  final String duration;
  final String devise;
  final String totalCredit;
  final DateTime? startDate;
  final List<String> mois;

  UserAccepted({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.duration,
    required this.devise,
    required this.totalCredit,
    this.startDate,
    required this.mois,
  });

  factory UserAccepted.fromJson(Map<String, dynamic> json, String type) {
    final startDate = json['offer']?['startDate'] != null
        ? DateTime.parse(json['offer']['startDate'])
        : null;
    final duration = int.tryParse(json['offer']?['duration']?.toString() ?? '0') ?? 0;
    final List<String> mois = startDate != null
        ? List.generate(
      duration,
          (index) => DateFormat.yMMM().format(
        startDate.add(Duration(days: 30 * index)),
      ),
    )
        : [];

    return UserAccepted(
      id: json['receiver']?['id']?.toString() ?? '',
      nom: json['receiver']?['lastName'] ?? 'Inconnu',
      prenom: json['receiver']?['firstName'] ?? '',
      duration: json['offer']?['duration']?.toString() ?? '0',
      devise: json['offer']?['devise'] ?? 'TND',
      totalCredit: json['offer']?['totalCredit']?.toString() ?? '0',
      startDate: startDate,
      mois: mois,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'receiver': {
        'id': id,
        'lastName': nom,
        'firstName': prenom,
      },
      'offer': {
        'duration': duration,
        'devise': devise,
        'totalCredit': totalCredit,
        'startDate': startDate?.toIso8601String(),
      },
      'mois': mois,
    };
  }
}