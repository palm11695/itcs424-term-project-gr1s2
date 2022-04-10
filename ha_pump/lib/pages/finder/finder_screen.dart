import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ha_pump/pages/finder/components/background.dart';
import 'package:ha_pump/pages/login/login_screen.dart';
import 'package:ha_pump/theme.dart';

class Finder extends StatefulWidget {
  const Finder({Key? key}) : super(key: key);
  @override
  _FinderState createState() => _FinderState();
}

class _FinderState extends State<Finder> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    auth.idTokenChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const LoginScreen();
        }));
      }
    });
    Size size = MediaQuery.of(context).size;
    String? currentEmail = auth.currentUser!.email;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Welcome To Ha Pump!\n",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(currentEmail!),
              SizedBox(height: size.height * 0.02),
              // SvgPicture.asset(
              //   "assets/icons/chat.svg",
              //   height: size.height * 0.45,
              // ),
              ElevatedButton(
                  child: const Text(
                    "Sign out",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
