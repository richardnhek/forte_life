import 'dart:io';

import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:forte_life/screens/pdf/pdf_screen_education.dart';
import 'package:forte_life/screens/pdf/pdf_screen_protect.dart';
import 'package:forte_life/widgets/custom_text_field.dart';
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
    final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');

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
