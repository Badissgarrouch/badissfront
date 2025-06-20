class AppLink {


  static const String server = "http://192.168.1.16:5000/api/v1";
  static const String socketServer = "http://192.168.1.16:5000";
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
  static const String getReceiveInvitation = "$server/invitations/getreceiveinvitation";
  static const String respondInvitation = "$server/invitations/respondinvitation";
  static const String getFriends = "$server/invitations/friends";
  static const String deleteFriendship = "$server/invitations/deletefriendship";
  static const String notification = "$server/notification";
  static String markNotificationRead(String notificationId) => "$server/notification/$notificationId/read";
  static const String updatename = "$server/auth/updateinfo";
  static const String evaluation = "$server/evaluate/submit";
  static const String getevaluationclient = "$server/evaluate/received";





  static const String server2 = "http://192.168.1.16:3000/api/v1";
  static const String socketServer2 = "ws://192.168.1.16:3000";
  static const String sendcredit = "$server2/credit/creditoffer";
  static const String getoffercredit = "$server2/credit/getcreditoffer";
  static const String respondtoffer = "$server2/credit/respondcreditoffer";
  static const String askModifyOffer = "$server2/credit/requestmodification";
  static const String modifyOffer = "$server2/credit/updateafterrequest";
  static const String getmysentoffer = "$server2/credit/getmysentoffer";
  static const String enterdetailcartes = "$server2/payment/addandgetcards";
  static const String getmerchantcard = "$server2/payment/commercant";
  static const String envoyerrecu = "$server2/payment/postrecu";
  static const String useroffer = "$server2/credit/getuseroffreaccepted";
  static const String myacceptedoffer = "$server2/credit/getacceptoffrebysender";
  static const String mensualite = "$server2/payment/getclientrecu";
  static const String mymensualite = "$server2/payment/getmyrecu";
  static const String image = "$server2/payment/image";
  static const String notifications2 = "$server2/notifications/notifications";
  static String markNotificationRead2(String notificationId) => "$server2/notifications/$notificationId/read";
  static const String statistic = "$server2/statistics/statcommercant";
  static const String statistic2="$server2/statistics/statclient";

} 