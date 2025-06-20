
import 'package:credit_app/core/constant/routes.dart';

import 'package:credit_app/core/localization/changedlocal.dart';
import 'package:credit_app/core/services/services.dart';

import 'package:credit_app/view/screen/auth/login.dart';
import 'package:credit_app/view/screen/auth/resetpassword.dart';
import 'package:credit_app/view/screen/auth/signup.dart';
import 'package:credit_app/view/screen/auth/signup2.dart';
import 'package:credit_app/view/screen/auth/successpage.dart';
import 'package:credit_app/view/screen/auth/successpagereset.dart';
import 'package:credit_app/view/screen/auth/verifycode.dart';
import 'package:credit_app/view/screen/auth/verifycodesignup.dart';
import 'package:credit_app/view/screen/client/card/friends.dart';
import 'package:credit_app/view/screen/client/card/receiveinvit.dart';
import 'package:credit_app/view/screen/commercant/card/usersinvit.dart';
import 'package:credit_app/view/screen/credit/client/listsentoffer.dart';
import 'package:credit_app/view/screen/credit/client/sendcredit.dart';
import 'package:credit_app/view/screen/credit/client/updateoffer.dart';
import 'package:credit_app/view/screen/credit/commercant/listoffre.dart';
import 'package:credit_app/view/screen/evaluation/evaluation.dart';
import 'package:credit_app/view/screen/evaluation/getclientevaluation.dart';
import 'package:credit_app/view/screen/paypal/paypal.dart';

import 'package:credit_app/view/screen/statistic/statistique.dart';
import 'package:credit_app/view/screen/notification/notification.dart';


import 'package:credit_app/view/screen/payment/monuserrecu.dart';
import 'package:credit_app/view/screen/payment/statususercredit.dart';

import 'package:credit_app/view/screen/home/homescreen.dart';
import 'package:credit_app/view/screen/home/homescreencommercant.dart';
import 'package:credit_app/view/screen/invitation/respondinvitation.dart';
import 'package:credit_app/view/screen/invitation/sendinvitation.dart';
import 'package:credit_app/view/screen/invitation/sendinvittoclient.dart';
import 'package:credit_app/view/screen/languages.dart';
import 'package:credit_app/view/screen/onboarding.dart';
import 'package:credit_app/view/screen/payment/EnterCartdetail.dart';
import 'package:credit_app/view/screen/payment/myaccepteoffer.dart';
import 'package:credit_app/view/screen/payment/pay.dart';
import 'package:credit_app/view/screen/payment/recevoirpayment.dart';
import 'package:credit_app/data/model/usermodel.dart';
import 'package:credit_app/view/screen/statistic/statistique2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import 'bindings/initialbindings.dart';
import 'conroller/home/profile_controller.dart';
import 'conroller/notification/appController.dart';

import 'core/localization/translation.dart';

import 'view/screen/auth/forgotpassword.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initialServices();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    LocaleController controller=Get.put(LocaleController());
    Get.put(AppController());
    Get.put(ProfileController());

    return GetMaterialApp(
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: controller.language,
      initialBinding: InitialBindings(),
      theme: ThemeData(primarySwatch: Colors.blue),
      home:Login(),
        getPages: [
        GetPage(name: AppRoute.onBoarding, page: () =>  OnBoarding()),
        GetPage(name: AppRoute.languages, page: () =>  Languages()),

          GetPage(name: AppRoute.signUp, page: () =>  Signup()),
          GetPage(name: AppRoute.login, page: () =>  Login()),
          GetPage(name: AppRoute.signUp2, page: () =>  Signup2()),
          GetPage(name: AppRoute.forgotPassword, page:() =>  Forgotpassword()),
          GetPage(name: AppRoute.verifyCode, page: () =>  Verifycode()),
          GetPage(name: AppRoute.resetPassword, page: () =>  Resetpassword()),
          GetPage(name: AppRoute.successPageReset, page: () =>  SuccesspageReset()),

          GetPage(name: AppRoute.successPage, page: () =>  Successpage()),
          GetPage(name: AppRoute.verifyCodesignup, page: () =>  VerifycodeSignup()),
          GetPage(name: AppRoute.homeScreen, page: () => Homescreen()),
          GetPage(name: AppRoute.homeScreenCommercant, page: () =>  Homescreencommercant()),
          GetPage(name: AppRoute.sendInvitation, page: () => SendInvitation()),
          GetPage(name: AppRoute.sendclientInvitation, page: () => SendClientInvitation()),
          GetPage(name: AppRoute.respondInvitation, page: () => RespondInvitation()),
          GetPage(name: AppRoute.commercantInvitationsPage, page: () => CommercantInvitationsPage()),
          GetPage(name: AppRoute.usersInvit, page: () => UsersInvit()),
          GetPage(name: AppRoute.friendListScreen, page: () => FriendsListScreen()),
          GetPage(name: AppRoute.sendOffer, page: () => SendOffer()),
          GetPage(name: AppRoute.offrelistScreen, page: () =>  OfferListScreen()),
          GetPage(name: AppRoute.listSentOffer, page: () =>  ListSentOffer()),
          GetPage(name: AppRoute.updateOffer, page: () =>  UpdateOfferView()),
          GetPage(name: AppRoute.enterCardDetail, page: () => EnterCardDetail()),
          GetPage(name: AppRoute.clientpaymentScreen, page: () => ClientPaymentScreen()),
          GetPage(name: AppRoute.recevoirPayment, page: () => Recevoirpayment()),
          GetPage(name: AppRoute.test1, page: () => Test1()),
          GetPage(name: AppRoute.test2, page: () => Test2(user:Get.arguments as User)),
          GetPage(name: AppRoute.myAcceptedoffer, page: () => Myaccepteoffer()),
          GetPage(name: AppRoute.notification, page: () => NotificationScreen()),
          GetPage(name: AppRoute.evalution, page: () => Evaluation()),
          GetPage(name: AppRoute.statistic, page: () => Statistics()),
          GetPage(name: AppRoute.statistic2, page: () => Statistics2()),

          GetPage(name: AppRoute.checkoutscreen, page: () => CheckoutScreen()),
          GetPage(name: AppRoute.getclientevalution, page: () => ReceivedEvaluations(token: GetStorage().read('token')),




          )],


    );
  }
}