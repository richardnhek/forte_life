import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as m;
import 'dart:io';

class PDFWidget {
  Document createPDF(String title) {
    final file = File(
            "/storage/emulated/0/Android/data/com.reahu.forte_life/files/logo.png")
        .readAsBytesSync();
    final image = MemoryImage(file);
    Document pdf = Document();
    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Expanded(
                  child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Image.provider(image,
                      width: 150, height: 80, fit: BoxFit.contain),
                  SizedBox(width: 15),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Flexible(
                        child: Text(
                            "Forte Life Assurance (Cambodia) Plc." +
                                "\n" +
                                "Vattanac Capital, Level 18 No.66 Monivong Blvd, Sangkat Wat Phnom," +
                                "\n" +
                                "Khan Daun Penh, Phnom Penh, Cambodia." +
                                "\n" +
                                "Tel: (+855) 23 885 077/ 066 Fax: (+855) 23 986 922" +
                                "\n" +
                                "Email: info@fortelifeassurance.com",
                            style: TextStyle(
                                fontSize: 8, fontBold: Font.timesBold()))),
                  ),
                ]),
                SizedBox(height: 20),
                Text("SALES ILLUSTRATION",
                    style: TextStyle(
                        fontSize: 14,
                        fontBold: Font.helveticaBold(),
                        fontWeight: FontWeight.bold)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Flexible(child: Text("Life Proposed: "))]),
              ])));
        }));
    return pdf;
  }
}
