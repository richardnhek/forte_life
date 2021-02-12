import 'package:flutter/material.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:forte_life/widgets/calculator_button.dart';
import 'package:provider/provider.dart';

class HomeScreenUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    final mq = MediaQuery.of(context);
    return SafeArea(
        child: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: mq.size.height / 3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/pictures/android/gradient3.png"),
                    fit: BoxFit.fill)),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: mq.size.height / 8, left: 15),
                  child: Container(
                    width: 180,
                    height: 35,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/pictures/android/logo/logo.png"),
                            fit: BoxFit.contain)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: mq.size.height / 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "Insurance Calculator",
                          style: TextStyle(
                              fontFamily: "Kano",
                              fontSize: 21,
                              color: Color(0xFF4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CalculatorButton(
                            calculatorTitle: "Forte Life Protect",
                            calculatorDesc: "Insurance Plan",
                            calculatorOnTap: () =>
                                {appProvider.categoriesTabIndex = 1},
                            calculatorImg:
                                AssetImage("assets/icons/shield.png"),
                          ),
                          CalculatorButton(
                            calculatorTitle: "Forte Life Education",
                            calculatorDesc: "Insurance Plan",
                            calculatorOnTap: () =>
                                {appProvider.categoriesTabIndex = 2},
                            calculatorImg:
                                AssetImage("assets/icons/gradhat.png"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
