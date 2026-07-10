import 'package:shared_preferences/shared_preferences.dart';

abstract class InitApp{
  static late SharedPreferences sharedPreferences;

  static Future<void> initApp()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
}