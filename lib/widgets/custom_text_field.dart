import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.formLabel, this.formInputType, this.formController});

  final String formLabel;
  final TextInputType formInputType;
  final TextEditingController formController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            decoration:
                BoxDecoration(border: Border.all(color: Color(0xFFB8B8B8))),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              controller: formController,
              decoration: InputDecoration(
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                  isDense: true,
                  hintText: formLabel,
                  hintStyle: TextStyle(
                      fontFamily: "Kano",
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.5))),
              keyboardType: formInputType,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: "Biko",
              ),
              autovalidateMode: AutovalidateMode.always,
            ),
          ),
        ],
      ),
    );
  }
}
