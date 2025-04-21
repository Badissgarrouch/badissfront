class SearchModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String userType;
  final String? businessName;
  final String? businessAddress;
  final String? sectorOfActivity;

  SearchModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    required this.userType,
    this.businessName,
    this.businessAddress,
    this.sectorOfActivity
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'].toString(),
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      userType: json['userType'].toString(),
      businessName: json['businessName'],
      businessAddress: json['businessAddress'],
      sectorOfActivity: json['sectorOfActivity'],
    );
  }
}