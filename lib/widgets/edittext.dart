import 'package:flutter/material.dart';

class EditText extends StatelessWidget {

  String title;

  EditText({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 24, right: 24),
        child: TextField(
          textAlign: TextAlign.left,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: Theme.of(context).dividerColor,
            hintText: title,
            hintStyle: Theme.of(context).textTheme.bodyText1,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.all(16)
          ),
        ),
      ),
    );
  }
}