import 'package:flutter/material.dart';

class AgeField extends StatelessWidget {
  AgeField({this.formController});

  final TextEditingController formController;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.12),
          border: Border.all(color: Color(0xFFB8B8B8))),
      child: TextFormField(
        readOnly: true,
        textAlignVertical: TextAlignVertical.bottom,
        controller: formController,
        decoration: InputDecoration(
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
            isDense: true,
            hintText: "Age",
            labelText: "Age",
            labelStyle: TextStyle(
                fontFamily: "Kano",
                fontSize: 15,
                color: Colors.black.withOpacity(0.5)),
            hintStyle: TextStyle(
                fontFamily: "Kano",
                fontSize: 15,
                color: Colors.black.withOpacity(0.5))),
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontFamily: "Biko",
        ),
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}
