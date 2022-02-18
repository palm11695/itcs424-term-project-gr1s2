import 'package:flutter/material.dart';
import 'package:ha_pump/pages/signup/components/background.dart';
import 'package:ha_pump/components/already_have_an_account_acheck.dart';
import 'package:ha_pump/components/rounded_button.dart';
import 'package:ha_pump/components/rounded_input_field.dart';
import 'package:ha_pump/components/rounded_password_field.dart';
import 'package:ha_pump/components/rounded_confirmed_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            // SvgPicture.asset(
            //   "assets/icons/signup.svg",
            //   height: size.height * 0.35,
            // ),
            const Text("Waiting For Banner/Picture"),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedConfirmedPasswordField(
              onChanged: (value) {},
            ),
            const RoundedButton(
              text: "SIGNUP",
              route: '/signup',
            ),
            SizedBox(height: size.height * 0.03),
            const AlreadyHaveAnAccountCheck(login: false, route: '/login'),
          ],
        ),
      ),
    );
  }
}
