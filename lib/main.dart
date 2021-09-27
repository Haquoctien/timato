import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timato/screens/main_app/main_screen.dart';
import 'package:timato/screens/welcome/welcome.dart';
import 'package:timato/services/shared_prefs.dart';
import 'constants/shared_pref_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref().it = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isFirstTimeUser = SharedPref().it.getBool(SharedPrefKeys.isfirstTimeUser) ?? true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.from(
          colorScheme: ColorScheme.light(
        primary: Color(0xFF344955),
        primaryVariant: Color(0xff232F34),
        secondary: Colors.orangeAccent,
        secondaryVariant: Colors.orange,
        surface: Colors.white,
        onSurface: Colors.black,
        background: Color(0xFFAFBAC4),
      )),
      navigatorKey: Get.key,
      home: isFirstTimeUser ? WelcomeScreen() : MainScreen(),
    );
  }
}
