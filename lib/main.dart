import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timato/screens/main_app/main_screen.dart';
import 'package:timato/screens/welcome/welcome.dart';
import 'package:timato/services/shared_prefs.dart';

import 'enums/shared_pref_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref().it = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isFirstTimeUser = true; //SharedPref().it.getBool(SharedPrefKeys.isfirstTimeUser) ?? true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData.from(
      //   colorScheme: ColorScheme.fromSwatch(
      //     primarySwatch: Colors.amber,
      //     backgroundColor: Colors.white,
      //     accentColor: Colors.blue,
      //     cardColor: Colors.amberAccent,
      //     primaryColorDark: Colors.purple,
      //   ),
      // ),
      navigatorKey: Get.key,
      home: isFirstTimeUser ? WelcomeScreen() : MainScreen(),
    );
  }
}
