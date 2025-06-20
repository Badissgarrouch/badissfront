import 'package:credit_app/data/datasource/remote/invitation/sender.dart';

class InvitationModel {
  final int id;
  final String status;
  final String createdAt;
  final Sender sender;

  InvitationModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.sender,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['id'],
      status: json['status'],
      createdAt: json['createdAt'],
      sender: Sender.fromJson(json['sender']),
    );
  }
}