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
    bool isFirstTimeUser = SharedPref().it.getBool(SharedPrefKeys.isfirstTimeUser) ?? true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue
            // primarySwatch: MaterialColor(0xFFF8B195, {
            //   50: Color(0xfffbd0bf),
            //   100: Color(0xfff9c1aa),
            //   200: Color(0xfff9b9a0),
            //   300: Color(0xFFF8B195),
            //   400: Color(0xffdf9f86),
            //   500: Color(0xfff68e77),
            //   600: Color(0xffae7c68),
            //   700: Color(0xff956a59),
            // }),
            // backgroundColor: Color(0xFF355C7D),
            // //cardColor: Color(0xff6c5b7b),
            ),
      ).copyWith(
        visualDensity: VisualDensity(horizontal: VisualDensity.maximumDensity, vertical: VisualDensity.maximumDensity),
      ),
      navigatorKey: Get.key,
      home: isFirstTimeUser ? WelcomeScreen() : MainScreen(),
    );
  }
}
