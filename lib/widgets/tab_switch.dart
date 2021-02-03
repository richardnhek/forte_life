import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class TabSwitch extends StatelessWidget {
  TabSwitch({this.minHeight, this.onToggle, this.label1, this.label2});

  final double minHeight;
  final Function onToggle;
  final String label1;
  final String label2;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ToggleSwitch(
        icons: [Icons.calculate_outlined, Icons.info_outline],
        fontSize: 18,
        iconSize: 28,
        cornerRadius: 0,
        activeBgColors: [Color(0xFF1A9A9A), Colors.blueAccent],
        inactiveBgColor: Colors.transparent,
        activeFgColor: Colors.white,
        inactiveFgColor: Colors.black.withOpacity(0.5),
        minWidth: double.maxFinite,
        minHeight: minHeight,
        labels: [label1, label2],
        onToggle: onToggle,
      ),
    );
  }
}
