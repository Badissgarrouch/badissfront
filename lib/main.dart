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
import 'package:credit_app/view/screen/home/clienthome.dart';
import 'package:credit_app/view/screen/home/commercanthome.dart';
import 'package:credit_app/view/screen/languages.dart';
import 'package:credit_app/view/screen/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/initialbindings.dart';
import 'core/localization/translation.dart';
import 'view/screen/auth/forgotpassword.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices(); // Assurez-vous que cette fonction existe
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
      home:  Languages(),
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
          GetPage(name: AppRoute.clientHome, page: () =>  Clienthome()),
          GetPage(name: AppRoute.commercantHome, page: () =>  Commercanthome()),
        ],


    );
  }
}