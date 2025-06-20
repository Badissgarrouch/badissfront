import 'package:get/get.dart';

String? validInputCredit(String val, int min, int max, String type) {
  if (val.isEmpty) {
    return "This field is required".tr;
  }

  if (val.length < min) {
    return "The field must contain at least $min characters.".tr;
  }

  if (val.length > max) {
    return "The field must not exceed $max characters.".tr;
  }

  if (type == "email" && !GetUtils.isEmail(val)) {
    return "Invalid email address.".tr;
  }

  if (type == "number" && !GetUtils.isNumericOnly(val)) {
    return "This field must contain only numbers.".tr;
  }

  if (type == "text" && GetUtils.isNumericOnly(val)) {
    return "This field must not contain only numbers.".tr;

  }
  if (type == "alpha" && !RegExp(r'^[a-zA-ZÀ-ÿ\s\-]+$').hasMatch(val)) {
    return "This field must contain only letters.".tr;
  }
  if (type == "date") {
    try {
      DateTime.parse(val);
    } catch (e) {
      return "Invalid date. Expected format: YYYY-MM-DD.".tr;
    }
  }

  return null;
}
