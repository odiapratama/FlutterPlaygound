import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SocialBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      height: 160,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "SIGN WITH",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: [
                  IconButton(
                      icon: Icon(
                        FontAwesome.getIconData("facebook"),
                        color: Color(0xFF3b5998),
                      ),
                      onPressed: () {

                      }),
                  Text("Facebook")
                ],
              ),
              Column(
                children: [
                  IconButton(
                      icon: Icon(
                        FontAwesome.getIconData("google"),
                          color: Color(0xFFdd4b39),
                      ),
                      onPressed: () {

                      }),
                  Text("Google")
                ],
              ),
              Column(
                children: [
                  IconButton(
                      icon: Icon(
                        FontAwesome.getIconData("twitter"),
                        color: Color(0xFF00aced),
                      ),
                      onPressed: () {

                      }),
                  Text("Twitter")
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
