import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ha_pump/theme.dart';
import 'package:ha_pump/pages/login/components/background.dart';
import 'package:ha_pump/components/already_have_an_account_acheck.dart';
import 'package:ha_pump/components/text_field_container.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ha_pump/pages/finder/finder_screen.dart';
import 'package:ha_pump/model/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Auth auth = Auth(email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Background(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "LOGIN",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: size.height * 0.03),
                        const Text("Waiting For Banner/Picture"),
                        SizedBox(height: size.height * 0.03),
                        Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldContainer(
                                    child: TextFormField(
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText:
                                                "Please input your email"),
                                        EmailValidator(
                                            errorText: "Wrong email format"),
                                      ]),
                                      keyboardType: TextInputType.emailAddress,
                                      onSaved: (String? email) {
                                        auth.email = email!;
                                      },
                                      cursorColor: kPrimaryColor,
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.person,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: "Email",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  TextFieldContainer(
                                    child: TextFormField(
                                      validator: RequiredValidator(
                                          errorText:
                                              "Please input your password"),
                                      obscureText: true,
                                      onSaved: (String? password) {
                                        auth.password = password!;
                                      },
                                      cursorColor: kPrimaryColor,
                                      decoration: const InputDecoration(
                                        hintText: "Password",
                                        icon: Icon(
                                          Icons.lock,
                                          color: kPrimaryColor,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: size.width * 0.8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(29),
                            child: ElevatedButton(
                              child: const Text(
                                "LOGIN",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: auth.email,
                                            password: auth.password)
                                        .then((value) {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const Finder();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {}
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: kPrimaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        const AlreadyHaveAnAccountCheck(
                          route: '/signup',
                        )
                      ]),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(child: Text("Error occurs")),
          );
        });
  }
}
