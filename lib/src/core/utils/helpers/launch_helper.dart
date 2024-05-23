import 'package:shared_preferences/shared_preferences.dart';

import '../resources/app.keys.dart';

class LaunchHelper {
  final SharedPreferences sharedPreferences;
  LaunchHelper({required this.sharedPreferences});

  isFirstTime() {
    final bool? result = sharedPreferences.getBool(AppKeys.firstLaunch);
    return result ?? true;
  }

  Future<void> firstTime() async {
    await sharedPreferences.setBool(AppKeys.firstLaunch, false);
  }
}
