import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:forte_life/screens/pdf/pdf_screen_education.dart';
import 'package:forte_life/screens/pdf/pdf_screen_protect.dart';
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

    return WillPopScope(
        onWillPop: () async {
          if (appProvider.pdfScreenIndex == 0 ||
              appProvider.pdfScreenIndex == 1) {
            return true;
          } else
            return false;
        },
        child: SafeArea(
          child: Container(
            child: Scaffold(
              body: tabs[appProvider.pdfScreenIndex],
            ),
          ),
        ));
  }
}
