import 'package:get/get.dart';

validInput(String val,int min,int max,String type){
  if (type=="username"){
    if(!GetUtils.isUsername(val)){
      return "This username is not valid".tr;
    }
  }
  if (type=="email"){
    if(!GetUtils.isEmail(val)){
      return "This email is not valid".tr;
    }
  }
  if (type=="phone"){
    if(!GetUtils.isPhoneNumber(val)){
      return "This phone number is not valid".tr;
    }
  }
  if (type=="cin"){
    if(!GetUtils.isNum(val)){
      return "CIN can't be empty".tr;
    }
  }




  if (val.isEmpty){

      return "This field can't be empty".tr;

  }
  if (val.length<min){

    return "${"can't be less than".tr} $min";


  }
  if (val.length>max){

    return "${"can't be more than".tr} $max";

  }
  }
