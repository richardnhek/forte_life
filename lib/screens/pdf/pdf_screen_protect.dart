import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forte_life/screens/pdf/pdf_screen_protect_ui.dart';
import 'package:forte_life/widgets/pdf/pdf_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/widgets.dart' as w;
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:provider/provider.dart';

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
  Future savePDF(File file, Document pdf) async {
    await file.writeAsBytes(pdf.save());
  }
  //

  final pdf = pw.Document();
  final file = File(
      "/storage/emulated/0/Android/data/com.reahu.forte_life/files/fortelife.pdf");
  @override
  w.Widget build(BuildContext context) {
    // pdf = PDFWidget().createPDF("Testing");
    final file = File(
            "/storage/emulated/0/Android/data/com.reahu.forte_life/files/logo.png")
        .readAsBytesSync();
    final image = pw.MemoryImage(file);
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return pw.Column(children: [
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
              pw.Image.provider(image,
                  width: 200, height: 100, fit: pw.BoxFit.contain),
              pw.Flexible(
                  child: pw.Text(
                      "Forte Life Assurance (Cambodia) Plc." + "\n" + "Test",
                      style: pw.TextStyle(
                          fontSize: 9, fontBold: Font.timesBold()))),
              pw.Text("Test",
                  style: pw.TextStyle(fontSize: 9, fontBold: Font.timesBold()))
            ])
          ]);
        }));
    return PDFScreenProtectUI();
  }
}
