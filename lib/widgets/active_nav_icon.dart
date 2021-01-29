import 'package:flutter/material.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:provider/provider.dart';

class ActiveNavIcon extends StatefulWidget {
  ActiveNavIcon({this.navIcon});
  final Icon navIcon;
  @override
  _ActiveNavIconState createState() => _ActiveNavIconState();
}

class _ActiveNavIconState extends State<ActiveNavIcon> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return GestureDetector(
      onTap: () => {
        if (appProvider.categoriesTabIndex > 0)
          {
            setState(() {
              appProvider.categoriesTabIndex = 0;
            })
          }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.withOpacity(0.8)),
        child: Center(child: widget.navIcon),
      ),
    );
  }
}
