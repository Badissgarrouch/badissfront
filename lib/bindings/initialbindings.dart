
import 'package:get/get.dart';

import '../core/class/crud.dart';
import '../data/datasource/remote/evaluation/evaluation.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies(){
    Get.put(Crud());
    Get.put<EvaluationData>(EvaluationData(Get.find<Crud>()));
    }


  }
