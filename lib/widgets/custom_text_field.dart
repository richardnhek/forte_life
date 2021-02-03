import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.formLabel,
      this.formInputType,
      this.formController,
      this.extraLeftPadding,
      this.extraTopPadding,
      this.onChange});

  final String formLabel;
  final TextInputType formInputType;
  final TextEditingController formController;
  final double extraLeftPadding;
  final double extraTopPadding;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: extraTopPadding,
        left: extraLeftPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration:
                BoxDecoration(border: Border.all(color: Color(0xFFB8B8B8))),
            child: TextFormField(
              maxLines: 1,
              onChanged: onChange,
              textAlignVertical: TextAlignVertical.bottom,
              controller: formController,
              decoration: InputDecoration(
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
                  isDense: true,
                  labelText: formLabel,
                  labelStyle: TextStyle(
                      fontFamily: "Kano",
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.5)),
                  hintText: formLabel,
                  hintStyle: TextStyle(
                      fontFamily: "Kano",
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.5))),
              keyboardType: formInputType,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: "Kano",
              ),
              autovalidateMode: AutovalidateMode.always,
            ),
          ),
        ],
      ),
    );
  }
}
