import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._internal();
  static final _singleton = SharedPref._internal();
  factory SharedPref() => _singleton;

  late SharedPreferences it;
}
