class AppLink {
  static const String server = "http://192.168.1.19:5000/api/v1";
  static const String signUp = "$server/auth/signup";
  static const String signUp2 = "$server/auth/signup";
  static const String verifycodesignup = "$server/auth/verify-otp";
  static const String login = "$server/auth/login";
  static const String forgotPassword = "$server/auth/forgot-password";
  static const String verifyPasswordResetOtp = "$server/auth/verify-password-reset-otp";
  static const String resetPassword = "$server/auth/reset-password";
  static const String searchUser = "$server/invitations/search";
  static const String invitUser = "$server/invitations/sendinvitation";
  static const String checkinvit = "$server/invitations/checkinvitation";
  static const String deleteinvit = "$server/invitations/deleteinvitation";
} 