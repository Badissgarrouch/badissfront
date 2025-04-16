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
import 'package:credit_app/view/screen/home/clienthome.dart';
import 'package:credit_app/view/screen/home/commercanthome.dart';
import 'package:credit_app/view/screen/home/homescreen.dart';
import 'package:credit_app/view/screen/home/homescreencommercant.dart';
import 'package:credit_app/view/screen/languages.dart';
import 'package:credit_app/view/screen/onboarding.dart';
import 'package:flutter/material.dart';

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
};
