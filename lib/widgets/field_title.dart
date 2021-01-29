import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  FieldTitle({this.fieldTitle});

  final String fieldTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 15),
      child: Text(
        fieldTitle,
        style: TextStyle(
            fontFamily: "Kano", fontSize: 21, fontWeight: FontWeight.w600),
      ),
    );
  }
}
