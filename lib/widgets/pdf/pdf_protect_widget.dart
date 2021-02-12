import 'dart:typed_data';

import 'package:forte_life/widgets/pdf/pdf_subtitle.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';

class PDFWidget {
  Document createPDF(
    String title,
    bool addRider,
    bool differentP,
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
    String paymentMode,
    String premium,
    String premiumRider,
    String riderSA,
  ) {
    //Final variables
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
    final Map<int, TableColumnWidth> columnWidthVal = {
      0: FlexColumnWidth(0.5),
      1: FlexColumnWidth(2),
      2: FlexColumnWidth(2),
      3: FlexColumnWidth(0.75),
      4: FlexColumnWidth(3)
    };

    //Doubles with no previous values
    double accumulatedPremium = 0;
    double accumulatedPremiumNoRider = 0;
    double totalSA = 0;
    double allCauses = 0;
    double allAccidents = 0;
    double cashValue = 0;
    double riderSANum = 0;
    double premiumRiderNum = 0;
    double totalPremiumNum = 0;
    //

    //Convert String to Double for ease of use
    double basicSANum = double.parse(basicSA);
    double premiumNum = double.parse(premium);
    //

    //Doubles with conditions
    riderSANum = addRider == true ? double.parse(riderSA) : 0;
    premiumRiderNum = addRider == true ? double.parse(premiumRider) : 0;
    //

    // Total premium
    double totalPremium = premiumNum + premiumRiderNum;
    //

    // Round all the doubles to a .00 decimal format
    String halfP = (totalPremium * 0.5178).toStringAsFixed(2);
    String quarterlyP = (totalPremium * 0.2635).toStringAsFixed(2);
    String monthlyP = (totalPremium * 0.0888).toStringAsFixed(2);
    String premiumStr = premiumNum.toStringAsFixed(2);
    String riderSAStr = riderSANum.toStringAsFixed(2);
    String premiumRiderStr = premiumRiderNum.toStringAsFixed(2);
    String totalPremiumStr = totalPremium.toStringAsFixed(2);
    String accumulatedPremiumStr = totalPremium.toStringAsFixed(2);
    String cashValueStr = cashValue.toStringAsFixed(2);
    String accumulatedPremiumNoRiderStr =
        accumulatedPremiumNoRider.toStringAsFixed(2);
    //

    List<List<dynamic>> getDynamicRow(int policyYear, int age) {
      List<List<dynamic>> dynamicRow = List();
      int i = 1;
      double cashValPercentage = 0;
      totalPremiumNum = (premiumNum + premiumRiderNum);
      accumulatedPremiumNoRider += premiumNum;
      accumulatedPremium += totalPremiumNum;
      //All causes and accidents, List initialization
      switch (age) {
        case 1:
          {
            allCauses = (basicSANum * 0.6) + riderSANum;
            allAccidents = (basicSANum * 1.2) + riderSANum;
            dynamicRow = [
              [
                "$i",
                "         $totalPremiumStr              $accumulatedPremiumStr     ",
                "$allCauses $allAccidents",
                "-",
                "-"
              ],
            ];
            i++;
            allCauses = (basicSANum * 0.8) + riderSANum;
            allAccidents = (basicSANum * 1.6) + riderSANum;
            accumulatedPremiumNoRider += premiumNum;
            accumulatedPremium += totalPremiumNum;
            dynamicRow.add([
              "$i",
              "         $totalPremiumStr              $accumulatedPremiumStr     ",
              "         $allCauses            $allAccidents     ",
              "-",
              "-"
            ]);
            break;
          }
        case 2:
          {
            allCauses = (basicSANum * 0.8) + riderSANum;
            allAccidents = (basicSANum * 1.6) + riderSANum;
            accumulatedPremiumNoRider += premiumNum;
            dynamicRow = [
              [
                "$i",
                "         $totalPremiumStr              $accumulatedPremiumStr     ",
                "         $allCauses            $allAccidents     ",
                "-",
                "-"
              ],
            ];

            break;
          }

        default:
          {
            allCauses = basicSANum + riderSANum;
            allAccidents = (basicSANum * 2) + riderSANum;
            dynamicRow = [
              [
                "$i",
                "         $totalPremiumStr              $accumulatedPremiumStr     ",
                "         $allCauses            $allAccidents     ",
                "-",
                "-"
              ]
            ];
            break;
          }
      }
      //
      i++;
      allCauses = basicSANum + riderSANum;
      allAccidents = (basicSANum * 2) + riderSANum;
      while (i <= policyYear) {
        accumulatedPremium += totalPremiumNum;
        accumulatedPremiumStr = accumulatedPremium.toStringAsFixed(2);
        accumulatedPremiumNoRider += premiumNum;
        if (i >= 3) {
          if (i <= 16) {
            if (i <= 12)
              cashValPercentage += 0.05;
            else
              cashValPercentage += 0.1;
          }
          cashValue = accumulatedPremiumNoRider * cashValPercentage;
          cashValueStr = cashValue.toStringAsFixed(2);
        } else
          cashValueStr = "-";
        if (i < policyYear) {
          dynamicRow.add([
            "$i",
            "         $totalPremiumStr              $accumulatedPremiumStr     ",
            "         $allCauses            $allAccidents     ",
            cashValueStr,
            "-"
          ]);
          i++;
        } else {
          dynamicRow.add([
            "$i",
            "         $totalPremiumStr              ${accumulatedPremium.round().toStringAsFixed(2)}     ",
            "         $allCauses            $allAccidents     ",
            cashValue.round().toStringAsFixed(2),
            "-"
          ]);
          i++;
        }
      }

      return dynamicRow;
    }

    List<String> getDynamicHeaders() {
      List<String> dynamicHeader = [
        "End of Policy Year",
        "                 Premium (USD) \n \n       Annualized     Accumulated",
        "             Total Death/TPD (USD) \n \n           All Causes      Accidents    ",
        "Cash Value",
        "Guaranteed Special Benefit"
      ];
      return dynamicHeader;
    }

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
                            style: TextStyle(fontSize: 6, font: regularF))),
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
                    child: Column(children: [
                  Table(
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
                                  padding: EdgeInsets.only(right: 5),
                                  child: PDFSubtitle(
                                      title: "Occupation", font: boldF),
                                )
                              ])
                        ]),
                        TableRow(children: [
                          Column(children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Container(
                                          width: 100,
                                          child: Text("Life Proposed",
                                              style: TextStyle(
                                                  font: regularF,
                                                  fontSize: 7)))),
                                  PDFSubtitle(title: lpName, font: regularF),
                                  PDFSubtitle(title: lpAge, font: regularF),
                                  PDFSubtitle(title: lpGender, font: regularF),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: PDFSubtitle(
                                        title: lpOccupation, font: regularF),
                                  )
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Container(
                                          width: 100,
                                          child: Text("Proposer",
                                              style: TextStyle(
                                                  font: regularF,
                                                  fontSize: 7)))),
                                  PDFSubtitle(title: pName, font: regularF),
                                  PDFSubtitle(title: pAge, font: regularF),
                                  PDFSubtitle(title: pGender, font: regularF),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5),
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
                                  padding: EdgeInsets.only(right: 5),
                                  child: PDFSubtitle(
                                      title: "Payment Mode", font: boldF),
                                )
                              ])
                        ]),
                        TableRow(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Container(
                                                width: 103.55,
                                                child: Text(
                                                    "Basic Plan     : $title",
                                                    style: TextStyle(
                                                        font: regularF,
                                                        fontSize: 7)))),
                                        PDFSubtitle(
                                            title:
                                                "USD ${basicSANum.toStringAsFixed(2)}",
                                            font: regularF),
                                        Padding(
                                          padding: EdgeInsets.only(left: 2.5),
                                          child: PDFSubtitle(
                                              title: policyTerm,
                                              font: regularF),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 2.5),
                                          child: PDFSubtitle(
                                              title: policyTerm,
                                              font: regularF),
                                        )
                                      ]),
                                  addRider == true
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  child: Container(
                                                      width: 103.55,
                                                      child: Text(
                                                          "Rider             : $title" +
                                                              " Plus",
                                                          style: TextStyle(
                                                              font: regularF,
                                                              fontSize: 7)))),
                                              PDFSubtitle(
                                                  title: "USD $riderSAStr",
                                                  font: regularF),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 2.5),
                                                child: PDFSubtitle(
                                                    title: policyTerm,
                                                    font: regularF),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 2.5),
                                                child: PDFSubtitle(
                                                    title: policyTerm,
                                                    font: regularF),
                                              )
                                            ])
                                      : SizedBox(height: 0),
                                ]),
                                Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: PDFSubtitle(
                                        title: paymentMode, font: regularF)),
                              ])
                        ]),
                        TableRow(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Container(
                                        width: 103.55,
                                        child: Text("Premium",
                                            style: TextStyle(
                                                font: boldF, fontSize: 7))))
                              ])
                        ]),
                        TableRow(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Column(children: [
                                      Container(
                                          width: 120,
                                          child: Text("Basic Plan     : $title",
                                              style: TextStyle(
                                                  font: regularF,
                                                  fontSize: 7))),
                                      addRider == true
                                          ? Container(
                                              width: 120,
                                              child: Text(
                                                  "Rider             : $title" +
                                                      " Plus",
                                                  style: TextStyle(
                                                      font: regularF,
                                                      fontSize: 7)))
                                          : SizedBox(height: 0)
                                    ])),
                                Padding(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Column(children: [
                                      PDFSubtitle(
                                          title: "USD $premiumStr",
                                          font: regularF),
                                      PDFSubtitle(
                                          title: addRider == true
                                              ? "USD $premiumRiderStr"
                                              : "",
                                          font: regularF),
                                    ]))
                              ]),
                        ]),
                        TableRow(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Container(
                                        width: 120,
                                        child: Text("Total Premium",
                                            style: TextStyle(
                                                font: boldF, fontSize: 7)))),
                                Padding(
                                  padding: EdgeInsets.only(left: 50),
                                  child: PDFSubtitle(
                                      title: "USD $totalPremiumStr",
                                      font: regularF),
                                )
                              ])
                        ]),
                      ]),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("* Payment Modes:",
                          style: TextStyle(font: regularF, fontSize: 7))),
                  Table(
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
                                Column(children: [
                                  PDFSubtitle(title: "Yearly", font: regularF),
                                  PDFSubtitle(title: "USD $totalPremiumStr")
                                ]),
                                Column(children: [
                                  PDFSubtitle(
                                      title: "Half-yearly", font: regularF),
                                  PDFSubtitle(title: "USD $halfP")
                                ]),
                                Column(children: [
                                  PDFSubtitle(
                                      title: "Quarterly", font: regularF),
                                  PDFSubtitle(title: "USD $quarterlyP")
                                ]),
                                Column(children: [
                                  PDFSubtitle(title: "Monthly", font: regularF),
                                  PDFSubtitle(title: "USD $monthlyP")
                                ])
                              ])
                        ])
                      ]),
                  SizedBox(height: 15),
                  Table.fromTextArray(
                      headers: getDynamicHeaders(),
                      headerAlignment: Alignment.center,
                      columnWidths: columnWidthVal,
                      headerHeight: 15,
                      headerPadding: EdgeInsets.all(0.75),
                      cellPadding: EdgeInsets.all(0.75),
                      headerStyle: TextStyle(font: boldF, fontSize: 7),
                      cellStyle: TextStyle(font: regularF, fontSize: 7),
                      cellAlignment: Alignment.topCenter,
                      headerDecoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(),
                              left: BorderSide(),
                              bottom: BorderSide())),
                      border: TableBorder.ex(
                          verticalInside: BorderSide(),
                          top: BorderSide(),
                          bottom: BorderSide(),
                          left: BorderSide(),
                          right: BorderSide()),
                      context: context,
                      data: getDynamicRow(
                          int.parse(policyTerm), int.parse(lpAge))),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Flexible(
                        child: Text(
                            "1.	This is a Non-participating Endowment plan with premium payables throughout the term of the Policy." +
                                "\n" +
                                "2.	The Guaranteed Special Benefit shall be equal to 2% of Basic Sum Assured multiplied by the Policy term with entry age below 50 years last birthday and 1% of Basic Sum Assured multiplied by the policy term with age 50 years last birthday and above." +
                                "\n" +
                                "3.	This Policy will acquire a Cash Value after it has been in-force for a minimum of two years." +
                                "\n" +
                                "4. 	The above is for illustration purposes only. The benefits described herein are subject to all terms and conditions contained in the Policy contract."
                                    "\n" +
                                "5.	Pays the earlier of either Death due to All Causes, TBD due too All Causes, Death due to Accident or TPD due to Accident.",
                            style: TextStyle(fontSize: 7, font: regularF))),
                  ),
                ]))
              ])));
        }));
    return pdf;
  }
}
