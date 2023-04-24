import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static  SharedPreferences? sharedPreferences;
  static int() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

}