import 'package:flutter/material.dart';
import 'package:ha_pump/pages/login/components/background.dart';
import 'package:ha_pump/components/already_have_an_account_acheck.dart';
import 'package:ha_pump/components/rounded_button.dart';
import 'package:ha_pump/components/rounded_input_field.dart';
import 'package:ha_pump/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            // SvgPicture.asset(
            //   "assets/icons/login.svg",
            //   height: size.height * 0.35,
            // ),
            const Text("Waiting For Picture"),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            const RoundedButton(
              text: "LOGIN",
              route: '/login',
            ),
            SizedBox(height: size.height * 0.03),
            const AlreadyHaveAnAccountCheck(
              route: '/signup',
            )
          ],
        ),
      ),
    );
  }
}
