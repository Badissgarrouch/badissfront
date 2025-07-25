import 'package:credit_app/core/constant/routes.dart';

import 'package:credit_app/view/screen/auth/forgotpassword.dart';
import 'package:credit_app/view/screen/auth/login.dart';
import 'package:credit_app/view/screen/auth/resetpassword.dart';
import 'package:credit_app/view/screen/auth/signup.dart';
import 'package:credit_app/view/screen/auth/signup2.dart';
import 'package:credit_app/view/screen/auth/successpage.dart';
import 'package:credit_app/view/screen/auth/successpagereset.dart';
import 'package:credit_app/view/screen/auth/verifycode.dart';
import 'package:credit_app/view/screen/auth/verifycodesignup.dart';
import 'package:credit_app/view/screen/client/card/friends.dart';
import 'package:credit_app/view/screen/credit/client/listsentoffer.dart';
import 'package:credit_app/view/screen/credit/client/sendcredit.dart';
import 'package:credit_app/view/screen/credit/client/updateoffer.dart';
import 'package:credit_app/view/screen/credit/commercant/checkoffre.dart';
import 'package:credit_app/view/screen/credit/commercant/listoffre.dart';
import 'package:credit_app/view/screen/evaluation/evaluation.dart';
import 'package:credit_app/view/screen/evaluation/getclientevaluation.dart';
import 'package:credit_app/view/screen/home/clienthome.dart';
import 'package:credit_app/view/screen/home/commercanthome.dart';
import 'package:credit_app/view/screen/home/homescreen.dart';
import 'package:credit_app/view/screen/home/homescreencommercant.dart';
import 'package:credit_app/view/screen/invitation/respondinvitation.dart';
import 'package:credit_app/view/screen/invitation/sendinvitation.dart';
import 'package:credit_app/view/screen/invitation/sendinvittoclient.dart';
import 'package:credit_app/view/screen/languages.dart';
import 'package:credit_app/view/screen/notification/notification.dart';
import 'package:credit_app/view/screen/onboarding.dart';
import 'package:credit_app/view/screen/payment/EnterCartdetail.dart';
import 'package:credit_app/view/screen/payment/monuserrecu.dart';
import 'package:credit_app/view/screen/payment/myaccepteoffer.dart';
import 'package:credit_app/view/screen/payment/pay.dart';
import 'package:credit_app/view/screen/payment/recevoirpayment.dart';
import 'package:credit_app/view/screen/payment/statususercredit.dart';
import 'package:credit_app/view/screen/paypal/paypal.dart';
import 'package:credit_app/view/screen/statistic/statistique.dart';
import 'package:credit_app/view/screen/statistic/statistique2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/usermodel.dart';

Map<String,Widget Function(BuildContext)>routes={
  AppRoute.onBoarding:(context)=>const OnBoarding(),
  AppRoute.languages:(context)=>const Languages(),
  AppRoute.signUp:(context)=>const Signup(),
  AppRoute.login:(context)=>const Login(),
  AppRoute.signUp2:(context)=>const Signup2(),
  AppRoute.forgotPassword:(context)=>const Forgotpassword(),
  AppRoute.verifyCode:(context)=>const Verifycode(),
  AppRoute.resetPassword:(context)=>const Resetpassword(),
  AppRoute.successPage:(context)=> Successpage(),
  AppRoute.successPageReset:(context)=> SuccesspageReset(),
  AppRoute.verifyCodesignup:(context)=> VerifycodeSignup(),
  AppRoute.clientHome:(context)=> Clienthome(),
  AppRoute.commercantHome:(context)=> Commercanthome(),
  AppRoute.homeScreen:(context)=> Homescreen(),
  AppRoute.homeScreenCommercant:(context)=> Homescreencommercant(),
  AppRoute.sendInvitation:(context)=> SendInvitation(),
  AppRoute.sendclientInvitation:(context)=> SendClientInvitation(),
  AppRoute.respondInvitation:(context)=> RespondInvitation(),
  AppRoute.friendListScreen:(context)=> FriendsListScreen(),
  AppRoute.sendOffer:(context)=> SendOffer(),
  AppRoute.offrelistScreen:(context)=>OfferListScreen() ,
  AppRoute.listSentOffer:(context)=> ListSentOffer(),
  AppRoute.updateOffer:(context)=> UpdateOfferView(),
  AppRoute.enterCardDetail:(context)=> EnterCardDetail(),
  AppRoute.clientpaymentScreen:(context)=> ClientPaymentScreen(),
  AppRoute.recevoirPayment:(context)=> Recevoirpayment(),
  AppRoute.test1:(context)=> Test1(),
  AppRoute.test2:(context)=> Test2(user:Get.arguments as User),
  AppRoute.myAcceptedoffer:(context)=> Myaccepteoffer(),
  AppRoute.notification:(context)=> NotificationScreen(),
  AppRoute.evalution:(context)=>Evaluation() ,
  AppRoute.getclientevalution:(context)=> ReceivedEvaluations(),
  AppRoute.statistic:(context)=> Statistics(),
  AppRoute.statistic2:(context)=> Statistics2(),
  AppRoute.checkoutscreen:(conxtext)=> CheckoutScreen()
};
