import 'package:flutter/material.dart';
import 'package:flutter_playground/screens/home.dart';
import 'package:flutter_playground/widgets/codeinput.dart';

class VerificationScreen extends StatefulWidget {

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 96),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text("Phone Verification",
                        style: Theme.of(context).textTheme.subtitle2)),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 48),
                  child: Text(
                    "Enter your code here",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 64),
                  child: CodeInput(
                    length: 4,
                    keyboardType: TextInputType.number,
                    builder: CodeInputBuilders.darkCircle(),
                    onFilled: (value) {
                      print('Your input is $value.');
                      Navigator.pushReplacement(
                          context, 
                          MaterialPageRoute(builder: (context) => Home())
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
