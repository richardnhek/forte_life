import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:forte_life/screens/pdf/pdf_screen_education.dart';
import 'package:forte_life/screens/pdf/pdf_screen_protect.dart';
import 'package:forte_life/widgets/tab_button.dart';
import 'package:forte_life/screens/info/info_screen.dart';
import 'package:provider/provider.dart';

class PDFScreen extends StatefulWidget {
  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  final tabs = [PDFScreenProtect(), PDFScreenEdu()];

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
        child: Scaffold(
          body: tabs[appProvider.pdfScreenIndex],
        ));
  }
}
