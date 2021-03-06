import 'package:flutter/material.dart';
import 'package:ha_pump/pages/welcome/components/background.dart';
import 'package:ha_pump/components/rounded_button.dart';
import 'package:ha_pump/theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "WELCOME TO HA PUMP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.02),
              const Text("Gas Stations Finder",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 3,
                  )),
              SizedBox(height: size.height * 0.08),
              const RoundedButton(text: "LOGIN", route: '/login'),
              const RoundedButton(
                text: "SIGN UP",
                route: '/signup',
                color: kPrimaryLightColor,
                textColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
