import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static SharedPreferences? preferences;

   Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }
}