import 'dart:typed_data';

import 'package:forte_life/widgets/pdf/pdf_subtitle.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as m;
import 'dart:io';

class PDFWidget {
  Document createPDF(
    String title,
    String lpName,
    String lpAge,
    String lpGender,
    String lpOccupation,
    String pName,
    String pAge,
    String pGender,
    String pOccupation,
    String basicSA,
    String policyTerm,
    String premiumPayingTerm,
  ) {
    final file = File(
            "/storage/emulated/0/Android/data/com.reahu.forte_life/files/logo.png")
        .readAsBytesSync();
    final image = MemoryImage(file);
    final Uint8List regularFont = File(
            '/storage/emulated/0/Android/data/com.reahu.forte_life/files/LiberationSans-Regular.ttf')
        .readAsBytesSync();
    final Uint8List boldFont = File(
            '/storage/emulated/0/Android/data/com.reahu.forte_life/files/LiberationSans-Bold.ttf')
        .readAsBytesSync();
    final regularData = regularFont.buffer.asByteData();
    final boldData = boldFont.buffer.asByteData();
    final regularF = Font.ttf(regularData);
    final boldF = Font.ttf(boldData);
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
                            style: TextStyle(fontSize: 5, font: boldF))),
                  ),
                ]),
                SizedBox(height: 20),
                Text("SALES ILLUSTRATION",
                    style: TextStyle(
                        fontSize: 14,
                        font: boldF,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Center(
                    child: Table(
                        border: TableBorder.ex(
                            horizontalInside: BorderSide(),
                            bottom: BorderSide(),
                            top: BorderSide(),
                            left: BorderSide(),
                            right: BorderSide()),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                      TableRow(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Container(width: 100),
                              ),
                              PDFSubtitle(title: "Name", font: boldF),
                              PDFSubtitle(title: "Age", font: boldF),
                              PDFSubtitle(title: "Gender", font: boldF),
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: PDFSubtitle(
                                    title: "Occupation", font: boldF),
                              )
                            ])
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Container(
                                        width: 100,
                                        child: Text("Life Proposed",
                                            style: TextStyle(
                                                font: regularF, fontSize: 7)))),
                                PDFSubtitle(title: lpName, font: regularF),
                                PDFSubtitle(title: lpAge, font: regularF),
                                PDFSubtitle(title: lpGender, font: regularF),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: PDFSubtitle(
                                      title: lpOccupation, font: regularF),
                                )
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Container(
                                        width: 100,
                                        child: Text("Proposer",
                                            style: TextStyle(
                                                font: regularF, fontSize: 7)))),
                                PDFSubtitle(title: pName, font: regularF),
                                PDFSubtitle(title: pAge, font: regularF),
                                PDFSubtitle(title: pGender, font: regularF),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: PDFSubtitle(
                                      title: pOccupation, font: regularF),
                                )
                              ])
                        ])
                      ]),
                      TableRow(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: 100,
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("Type of Benefits",
                                          style: TextStyle(
                                              font: boldF, fontSize: 7)))),
                              Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: PDFSubtitle(
                                      title: "Sum Insured", font: boldF)),
                              PDFSubtitle(title: "Policy Term", font: boldF),
                              PDFSubtitle(
                                  title: "Premium Paying Term", font: boldF),
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: PDFSubtitle(
                                    title: "Payment Mode", font: boldF),
                              )
                            ])
                      ]),
                      TableRow(children: [
                        Row(children: [
                          Column(children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Container(
                                          width: 100,
                                          child: Text("Basic Plan     : $title",
                                              style: TextStyle(
                                                  font: regularF,
                                                  fontSize: 7)))),
                                  PDFSubtitle(
                                      title: "USD $basicSA", font: regularF),
                                  PDFSubtitle(
                                      title: policyTerm, font: regularF),
                                  PDFSubtitle(
                                      title: premiumPayingTerm, font: regularF),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Container(
                                          width: 100,
                                          child: Text(
                                              "Rider            : $title" +
                                                  "  Plus",
                                              style: TextStyle(
                                                  font: regularF,
                                                  fontSize: 7)))),
                                  PDFSubtitle(
                                      title: "USD $basicSA", font: regularF),
                                  PDFSubtitle(
                                      title: policyTerm, font: regularF),
                                  PDFSubtitle(
                                      title: premiumPayingTerm, font: regularF),
                                ]),
                          ]),
                          PDFSubtitle(title: "Yearly", font: regularF),
                        ])
                      ]),
                    ]))
              ])));
        }));
    return pdf;
  }
}
