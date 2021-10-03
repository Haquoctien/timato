import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timato/screens/main_app/main_screen.dart';
import 'package:timato/screens/welcome/welcome_screen.dart';
import 'package:timato/services/shared_prefs.dart';
import 'blocs/todo.dart';
import 'constants/shared_pref_keys.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref().it = await SharedPreferences.getInstance();
  runApp(MyApp());

  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isFirstTimeUser = SharedPref().it.getBool(SharedPrefKeys.isfirstTimeUser) ?? true;
    return BlocProvider<TodoBloc>(
      create: (context) => TodoBloc(),
      child: MaterialApp(
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
      ),
    );
  }
}
