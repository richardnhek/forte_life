import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  FieldTitle({this.fieldTitle, this.extraPadding});

  final String fieldTitle;
  final double extraPadding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, bottom: 15, top: extraPadding),
      child: Text(
        fieldTitle,
        style: TextStyle(
            fontFamily: "Kano", fontSize: 21, fontWeight: FontWeight.w600),
      ),
    );
  }
}
