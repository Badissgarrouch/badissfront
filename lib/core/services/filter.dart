
import 'package:shared_preferences/shared_preferences.dart';
import 'package:credit_app/view/widget/notification/noti_type.dart';

class FilterService {
  Future<Map<NotificationType, bool>> loadFilterPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final filterStates = <NotificationType, bool>{};
    for (var type in NotificationType.values) {
      filterStates[type] = prefs.getBool('filter_${type.toString().split('.').last}') ?? true;
    }
    return filterStates;
  }

  void saveFilterPreferences(Map<NotificationType, bool> filterStates) async {
    final prefs = await SharedPreferences.getInstance();
    filterStates.forEach((key, value) {
      prefs.setBool('filter_${key.toString().split('.').last}', value);
    });
  }
}