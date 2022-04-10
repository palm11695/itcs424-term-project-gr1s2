import 'package:flutter/material.dart';
import 'package:ha_pump/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ha_pump/pages/welcome/welcom_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthButton extends StatelessWidget {
  final String email;
  final String password;
  final String text;
  final Color color, textColor;
  const AuthButton({
    Key? key,
    required this.email,
    required this.password,
    required this.text,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(context),
      ),
    );
  }

  Widget newElevatedButton(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      onPressed: () async {
        if (text == "LOGIN") {
          try {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password)
                .then((value) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const WelcomeScreen();
              }));
            });
          } on FirebaseAuthException {
            return;
          }
        } else if (text == "SIGN UP") {
          try {
            await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: email, password: password)
                .then((value) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const WelcomeScreen();
              }));
            });
          } on FirebaseAuthException catch (e) {
            Fluttertoast.showToast(msg: e.code, gravity: ToastGravity.CENTER);
          }
        }
      },
      style: ElevatedButton.styleFrom(
          primary: color,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}
