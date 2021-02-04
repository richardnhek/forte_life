import 'package:flutter/material.dart';

class ResultTitle extends StatelessWidget {
  ResultTitle({this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        child: Text(
          title,
          style: TextStyle(
              fontFamily: "Kano",
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
