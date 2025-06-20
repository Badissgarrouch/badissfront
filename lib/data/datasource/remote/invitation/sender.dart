class Sender {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String userType;
  final String businessName;
  final String businessAddress;
  final String sectorOfActivity;

  Sender({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.userType,
    required this.businessName,
    required this.businessAddress,
    required this.sectorOfActivity,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      userType: json['userType'] ?? '',
      businessName: json['businessName'] ?? '',
      businessAddress: json['businessAddress'] ?? '',
      sectorOfActivity: json['sectorOfActivity'] ?? '',
    );
  }
}