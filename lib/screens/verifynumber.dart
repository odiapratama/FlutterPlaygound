import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/screens/verifycode.dart';
import 'package:flutter_playground/widgets/countrydropdown.dart';
import 'package:flutter_playground/widgets/socialbottomsheet.dart';
import 'package:flutter_playground/widgets/submitbutton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VerificationNumberScreen extends StatefulWidget {
  @override
  _VerificationNumberState createState() => _VerificationNumberState();
}

class _VerificationNumberState extends State<VerificationNumberScreen> {
  var _txtNumber = TextEditingController();
  String _txtNumberHint = "081234567890";

  @override
  void initState() {
    _txtNumber.addListener(() {
      setState(() {
        _txtNumberHint = _txtNumber.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 96),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(32),
                  child: Text("Verify your phone number",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 36),
                  child: Text(
                    "We have sent you an SMS with a code to $_txtNumberHint",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: 24, bottom: 8, left: 24, right: 24),
                      child: TextField(
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            fillColor: Theme.of(context).dividerColor,
                            hintStyle: Theme.of(context).textTheme.subtitle2,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            filled: true,
                            contentPadding: EdgeInsets.all(16)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 36, bottom: 8, left: 36, right: 24),
                      child: CountryDropDown(
                        initialValue: "id",
                        itemBuilder: _dropDownBuilder,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 24, bottom: 8, left: 184, right: 24),
                      child: TextField(
                        controller: _txtNumber,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.timesCircle,
                                color: Theme.of(context).accentColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _txtNumber.text = "";
                                });
                              },
                            ),
                            hintText: "|\t\t\tNumber",
                            hintStyle: Theme.of(context).textTheme.bodyText2,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            contentPadding: EdgeInsets.all(16)),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 36),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Or login with",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      GestureDetector(
                          onTap: () {
                            socialBottomSheet(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Text(
                              "Social Network",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 17),
                            ),
                          )),
                    ],
                  ),
                ),
                SubmitButton(
                    title: "Next",
                    act: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerificationScreen()));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropDownBuilder(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 8,
          ),
          Text(
            "+${country.phoneCode}(${country.isoCode})",
            style: TextStyle(fontSize: 14),
          )
        ],
      );

  void socialBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return SocialBottomSheet();
        });
  }
}
