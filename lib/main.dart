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

import 'package:credit_app/view/screen/home/homescreen.dart';
import 'package:credit_app/view/screen/home/homescreencommercant.dart';
import 'package:credit_app/view/screen/invitation/respondinvitation.dart';
import 'package:credit_app/view/screen/invitation/sendinvitation.dart';
import 'package:credit_app/view/screen/invitation/sendinvittoclient.dart';
import 'package:credit_app/view/screen/languages.dart';
import 'package:credit_app/view/screen/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import 'bindings/initialbindings.dart';
import 'core/localization/translation.dart';
import 'view/screen/auth/forgotpassword.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initialServices();
  await GetStorage.init();// Assurez-vous que cette fonction existe
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocaleController controller=Get.put(LocaleController());
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
        ],


    );
  }
}