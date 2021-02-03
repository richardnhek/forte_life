import 'package:flutter/material.dart';

class AddedRyder extends StatelessWidget {
  AddedRyder({this.formController});

  final TextEditingController formController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all(color: Color(0xFFB8B8B8))),
        child: TextFormField(
          readOnly: true,
          textAlignVertical: TextAlignVertical.bottom,
          controller: formController,
          decoration: InputDecoration(
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
              isDense: true,
              hintText: "Added Ryder",
              labelText: "Added Ryder",
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
      ),
    );
  }
}
