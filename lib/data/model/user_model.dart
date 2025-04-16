class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String userType;
  final String? businessName;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userType,
    this.businessName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      userType: json['userType']?.toString() ?? '',
      businessName: json['businessName'],
    );
  }
}