import 'package:flutter/material.dart';

class UserNameField extends StatelessWidget {
  UserNameField({this.hintText, this.tec});

  final String hintText;
  final TextEditingController tec;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 42,
        width: 288,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.16),
                  spreadRadius: 5,
                  blurRadius: 5)
            ]),
        child: TextField(
          keyboardType: TextInputType.name,
          controller: tec,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintText: hintText,
            hintStyle: TextStyle(
                fontFamily: "Kano", fontSize: 14, color: Color(0xFFBBBBBB)),
            prefixIcon: Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Icon(
                Icons.person_outline,
                size: 16,
                color: Color(0xFFBBBBBB),
              ),
            ),
          ),
        ));
  }
}
