import 'package:credit_app/conroller/home/search_contoller.dart';
import 'package:get/get.dart';

import '../core/class/crud.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies(){
    Get.put(Crud());


  }
}