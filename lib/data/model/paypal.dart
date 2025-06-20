class PaymentData {
  String? cardNumber;
  String? expiryDate;
  String? cvv;
  String? cardName;
  String? email;
  String? address;
  String? city;
  String? postalCode;
  String? country;
  String? paypalEmail;
  String? paypalPassword;
  String paymentMethod;

  PaymentData({
    this.cardNumber,
    this.expiryDate,
    this.cvv,
    this.cardName,
    this.email,
    this.address,
    this.city,
    this.postalCode,
    this.country,
    this.paypalEmail,
    this.paypalPassword,
    this.paymentMethod = 'card',
  });

  bool get isCardDataValid {
    return cardNumber != null &&
        cardNumber!.replaceAll(' ', '').length >= 16 &&
        expiryDate != null &&
        expiryDate!.length == 5 &&
        cvv != null &&
        cvv!.length >= 3 &&
        cardName != null &&
        cardName!.isNotEmpty;
  }

  bool get isPayPalDataValid {
    return paypalEmail != null &&
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(paypalEmail!) &&
        paypalPassword != null &&
        paypalPassword!.length >= 6;
  }
}