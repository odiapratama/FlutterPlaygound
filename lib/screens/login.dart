import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_playground/screens/verifynumber.dart';
import 'package:flutter_playground/widgets/edittext.dart';
import 'package:flutter_playground/widgets/submitbutton.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Text("Hallo", style: Theme.of(context).textTheme.headline6),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("Login to your account",
                      style: Theme.of(context).textTheme.subtitle2),
                ),
                EditText(title: "Email"),
                EditText(title: "Password"),
                SubmitButton(
                    title: "Login",
                    act: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  VerificationNumberScreen()));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
