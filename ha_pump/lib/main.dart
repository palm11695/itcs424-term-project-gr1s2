import 'package:flutter/material.dart';
import 'package:ha_pump/pages/welcome/welcom_screen.dart';
import 'package:ha_pump/theme.dart';
import 'package:ha_pump/pages/login/login_screen.dart';
import 'package:ha_pump/pages/signup/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ha Pump',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
      initialRoute: '/',
    );
  }
}
