import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:forte_life/widgets/calculator_button.dart';
import 'package:forte_life/widgets/field_title.dart';
import 'package:provider/provider.dart';

class HomeScreenUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    final mq = MediaQuery.of(context);
    return DoubleBackToCloseApp(
      snackBar: SnackBar(
        content: Text('Tap Back Again To Leave'),
        duration: Duration(milliseconds: 750),
      ),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: mq.size.height / 3,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: AssetImage(
                          "assets/pictures/android/gradient3_test.png"),
                      fit: BoxFit.fill)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: mq.size.height / 8, left: 25),
                  child: Container(
                    width: 200,
                    height: 50,
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: FieldTitle(
                            fieldTitle: "Insurance Calculator",
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
                          height: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: FieldTitle(
                            fieldTitle: "Forte Life Videos",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: mq.size.height / 15),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "Coming Soon",
                              style: TextStyle(
                                  color: Colors.grey.withOpacity(0.5),
                                  fontSize: 15,
                                  fontFamily: "Kano"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
