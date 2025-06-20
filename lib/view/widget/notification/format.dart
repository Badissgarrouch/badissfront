import 'package:get/get.dart';
import 'package:intl/intl.dart';

String formatTime(DateTime time) {
  final now = DateTime.now();
  final difference = now.difference(time);
  if (difference.inMinutes < 60) {
    return 'There is ${difference.inMinutes} min'.tr;
  } else if (difference.inHours < 24) {
    return 'There is ${difference.inHours} h'.tr;
  } else {
    return 'There is ${difference.inDays} j'.tr;
  }
}

String formatDate(DateTime date) {
  return DateFormat('DD/MM/YYYY'.tr).format(date);
}