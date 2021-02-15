import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreenEducationUI extends StatefulWidget {
  @override
  _PDFScreenEducationUIState createState() => _PDFScreenEducationUIState();
}

class _PDFScreenEducationUIState extends State<PDFScreenEducationUI> {
  File file = File(
      "/storage/emulated/0/Android/data/com.reahu.forte_life/files/fortelife-education.pdf");
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    showPDF();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: _isLoading == true
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: SfPdfViewer.file(
                    file,
                    initialZoomLevel: 1.2,
                    pageSpacing: 0,
                  ),
                )),
    );
  }

  Future showPDF() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    getPDF();
  }

  Future getPDF() async {
    file = File(
        "/storage/emulated/0/Android/data/com.reahu.forte_life/files/fortelife-education.pdf");
    setState(() {
      _isLoading = false;
    });
  }
}
