import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  CustomDropDown({this.value, this.items, this.onChange, this.title});

  final dynamic value;
  final List<dynamic> items;
  final Function onChange;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.5),
      child: Padding(
        padding: EdgeInsets.only(left: 5),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              iconSize: 17.5,
              value: value,
              hint: Text(
                title,
                style: TextStyle(
                    fontFamily: "Kano",
                    fontSize: 15,
                    color: Colors.black.withOpacity(0.5)),
              ),
              items: items,
              onChanged: onChange),
        ),
      ),
      decoration: BoxDecoration(border: Border.all(color: Color(0xFFB8B8B8))),
    );
  }
}
