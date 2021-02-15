import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:forte_life/screens/calculation/calculation_education_ui.dart';
import 'package:forte_life/screens/info/info_screen_two.dart';
import 'package:forte_life/widgets/tab_button.dart';
import 'calculation_protect_ui.dart';
import 'package:forte_life/screens/info/info_screen.dart';
import 'package:provider/provider.dart';

class CalculationEducation extends StatefulWidget {
  @override
  _CalculationEducationState createState() => _CalculationEducationState();
}

class _CalculationEducationState extends State<CalculationEducation> {
  final tabs = [CalculationEducationUI(), InfoScreenEdu()];

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final mq = MediaQuery.of(context);

    return WillPopScope(
        onWillPop: () async {
          if (appProvider.categoriesTabIndex == 1) {
            appProvider.categoriesTabIndex = 0;
          }
        },
        child: Stack(
          children: [
            Scaffold(
              body: tabs[appProvider.calculationPageEdu],
            ),
            Container(
              height: mq.size.height / 7,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    spreadRadius: 1,
                    blurRadius: 5)
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: TabButton(
                        tabTitle: "Calculator",
                        width: mq.size.width / 2,
                        height: mq.size.height / 10,
                        icon: Icons.calculate_outlined,
                        isActive: appProvider.calculationPageEdu == 0,
                        onPressed: () {
                          setState(() {
                            appProvider.calculationPageEdu = 0;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: TabButton(
                      width: mq.size.width / 2,
                      height: mq.size.height / 10,
                      tabTitle: "Information",
                      icon: Icons.info_outline,
                      isActive: appProvider.calculationPageEdu == 1,
                      onPressed: () {
                        setState(() {
                          appProvider.calculationPageEdu = 1;
                        });
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
