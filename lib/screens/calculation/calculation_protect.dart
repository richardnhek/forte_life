import 'package:flutter/material.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'calculation_protect_ui.dart';
import 'package:provider/provider.dart';

class CalculationProtect extends StatefulWidget {
  @override
  _CalculationProtectState createState() => _CalculationProtectState();
}

class _CalculationProtectState extends State<CalculationProtect> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return WillPopScope(
        onWillPop: () async {
          if (appProvider.categoriesTabIndex == 1) {
            appProvider.categoriesTabIndex = 0;
          }
        },
        child: CalculationProtectUI());
  }
}
