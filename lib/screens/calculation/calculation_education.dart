import 'package:flutter/material.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:forte_life/screens/calculation/calculation_education_ui.dart';
import 'package:provider/provider.dart';

class CalculationEducation extends StatefulWidget {
  @override
  _CalculationEducationState createState() => _CalculationEducationState();
}

class _CalculationEducationState extends State<CalculationEducation> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return WillPopScope(
        onWillPop: () async {
          if (appProvider.categoriesTabIndex == 2) {
            appProvider.categoriesTabIndex = 0;
          }
        },
        child: CalculationEducationUI());
  }
}
