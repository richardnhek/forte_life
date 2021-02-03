import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forte_life/screens/pdf/pdf_screen_protect_ui.dart';
import 'package:forte_life/widgets/pdf/pdf_widget.dart';
import 'package:flutter/widgets.dart' as w;
import 'package:pdf/widgets.dart' as pw;

class PDFScreenProtect extends StatefulWidget {
  @override
  _PDFScreenProtectState createState() => _PDFScreenProtectState();
}

class _PDFScreenProtectState extends State<PDFScreenProtect> {
  @override
  void initState() {
    super.initState();
    getPDF();
  }

  //Get old PDF and throw it to savePDF
  Future getPDF() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    savePDF(file, pdf);
  }
  //

  //Save PDF in local storage
  Future savePDF(File file, pw.Document pdf) async {
    await file.writeAsBytes(pdf.save());
  }
  //

  pw.Document pdf = pw.Document();
  final file = File(
      "/storage/emulated/0/Android/data/com.reahu.forte_life/files/fortelife.pdf");
  @override
  w.Widget build(BuildContext context) {
    pdf = PDFWidget().createPDF("Testing");
    return PDFScreenProtectUI();
  }
}
