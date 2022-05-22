import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app_with_firebase/config.dart';
import 'package:to_do_app_with_firebase/screens/home_screen.dart';
import 'package:to_do_app_with_firebase/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        fontFamily: "IBM",
        brightness: Brightness.dark,
        primaryColor: k_primaryColor,
        scaffoldBackgroundColor: Color(0xF0123456),
        colorScheme: ColorScheme.dark(
          primary: k_primaryColor,
          secondary: k_secondaryColor,
        ),
        textTheme: TextTheme(
          headline4: TextStyle(
            color: k_primaryColor.withOpacity(0.9),
            fontSize: 20,
          ),
        ),
      ),
      home: FirebaseAuth.instance.currentUser == null ? LoginScreen() : HomeScreen(),
    );
  }
}
