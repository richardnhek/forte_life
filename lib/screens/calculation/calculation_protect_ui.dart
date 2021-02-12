import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:forte_life/providers/parameters_provider.dart';
import 'package:forte_life/widgets/calculate_button.dart';
import 'package:forte_life/widgets/custom_datepicker.dart';
import 'package:forte_life/widgets/custom_dropdown.dart';
import 'package:forte_life/widgets/custom_switch.dart';
import 'package:forte_life/widgets/custom_text_field.dart';
import 'package:forte_life/widgets/dropdown_text.dart';
import 'package:forte_life/widgets/field_title.dart';
import 'package:forte_life/widgets/reset_button.dart';

import 'package:intl/intl.dart';
import 'package:forte_life/widgets/age_field.dart';
import 'package:provider/provider.dart';

class CalculationProtectUI extends StatefulWidget {
  @override
  _CalculationProtectUIState createState() => _CalculationProtectUIState();
}

class _CalculationProtectUIState extends State<CalculationProtectUI> {
  FocusNode premiumFocusNode;

  @override
  void initState() {
    super.initState();
  }

  //Proposer
  TextEditingController pFirstName = TextEditingController();
  TextEditingController pLastName = TextEditingController();
  TextEditingController pAge = TextEditingController();
  TextEditingController pDob = TextEditingController();
  TextEditingController pGender = TextEditingController();
  TextEditingController pOccupation = TextEditingController();
  //

  //Life Proposed
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController dob = new TextEditingController();
  TextEditingController sumAssured = new TextEditingController();
  TextEditingController premium = new TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController lOccupation = TextEditingController();
  TextEditingController policyYear = TextEditingController();
  TextEditingController riderAdded = new TextEditingController();
  //

  String lSelectedGender;
  String pSelectedGender;
  int selectedYear = 10;
  double premiumRider;
  String selectedMode = "Yearly";
  double premiumNum;

  List<DropdownMenuItem> genderTypes = [
    DropdownMenuItem(
        child: DropDownText(
          title: "Male",
        ),
        value: "Male"),
    DropdownMenuItem(
        child: DropDownText(
          title: "Female",
        ),
        value: "Female")
  ];

  List<DropdownMenuItem> paymentMode = [
    DropdownMenuItem(
        child: DropDownText(
          title: "Yearly",
        ),
        value: "Yearly"),
    DropdownMenuItem(
        child: DropDownText(
          title: "Half-yearly",
        ),
        value: "Half-yearly"),
    DropdownMenuItem(
        child: DropDownText(
          title: "Quarterly",
        ),
        value: "Quarterly"),
    DropdownMenuItem(
        child: DropDownText(
          title: "Monthly",
        ),
        value: "Monthly")
  ];

  List<DropdownMenuItem> policyYears = [
    DropdownMenuItem(child: DropDownText(title: "10"), value: 10),
    DropdownMenuItem(child: DropDownText(title: "15"), value: 15),
    DropdownMenuItem(child: DropDownText(title: "20"), value: 20),
    DropdownMenuItem(child: DropDownText(title: "25"), value: 25),
    DropdownMenuItem(child: DropDownText(title: "30"), value: 30),
    DropdownMenuItem(child: DropDownText(title: "35"), value: 35)
  ];

  DateTime _selectedDate;
  DateTime _currentDate = DateTime.now();
  //

  //Reg
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  static final RegExp numberRegExp = RegExp(r'\d');
  //

  @override
  Widget build(BuildContext context) {
    ParametersProvider parametersProvider =
        Provider.of<ParametersProvider>(context, listen: false);
    AppProvider appProvider = Provider.of<AppProvider>(context);

    final mq = MediaQuery.of(context);
    final _formKey = GlobalKey<FormState>();

    //Derive rate
    Future<void> getRate(bool isMale, int ageParam, int termParam) async {
      ByteData data = await rootBundle.load("assets/rate/rate.xlsx");
      var bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      var excel = Excel.decodeBytes(bytes);
      int row = 1;
      String column = "B";
      switch (termParam) {
        case 15:
          {
            column = "C";
            break;
          }
        case 20:
          {
            column = "D";
            break;
          }
        case 25:
          {
            column = "E";
            break;
          }
        case 30:
          {
            column = "F";
            break;
          }
        case 35:
          {
            column = "G";
            break;
          }
        default:
          {
            column = "B";
            break;
          }
      }
      if (isMale == true) {
        Sheet sheetObj = excel['Male'];
        row = ageParam - 17;
        var cellResult = sheetObj.cell(CellIndex.indexByString("$column$row"));
        premiumRider =
            (cellResult.value * double.parse(riderAdded.text)) / 1000;
      } else {
        Sheet sheetObj = excel['Female'];
        row = ageParam - 17;
        var cellResult = sheetObj.cell(CellIndex.indexByString("$column$row"));
        premiumRider =
            (cellResult.value * double.parse(riderAdded.text)) / 1000;
      }
    }
    //

    //Get each value of each Payment Mode
    List<double> paymentModeValue(String selectedMode) {
      switch (selectedMode) {
        case "Yearly":
          {
            return [1, 1];
          }
        case "Half-yearly":
          {
            return [2, 0.5178];
          }
        case "Quarterly":
          {
            return [4, 0.2635];
          }
        case "Monthly":
          {
            return [12, 0.0888];
          }
        default:
          {
            return [1, 1];
          }
      }
    }
    //

    //Calculate and Generate PDF
    void calculateAndPDF() {
      print(appProvider.differentPerson);
      if (appProvider.differentPerson == false) {
        setState(() {
          parametersProvider.pName = parametersProvider.lpName =
              firstName.text.toString() + " " + lastName.text.toString();
          parametersProvider.pAge =
              parametersProvider.lpAge = age.text.toString();
          parametersProvider.pGender =
              parametersProvider.lpGender = lSelectedGender.toString();
          parametersProvider.pOccupation =
              parametersProvider.lpOccupation = lOccupation.text.toString();
        });
      } else {
        setState(() {
          //Proposer
          parametersProvider.pName =
              pFirstName.text.toString() + " " + pLastName.text.toString();
          parametersProvider.pAge = pAge.text.toString();
          parametersProvider.pGender = pSelectedGender.toString();
          parametersProvider.pOccupation = pOccupation.text.toString();
          //

          //Life Proposed
          parametersProvider.lpName =
              lastName.text.toString() + " " + firstName.text.toString();
          parametersProvider.lpAge = age.text.toString();
          parametersProvider.lpGender = lSelectedGender.toString();
          parametersProvider.lpOccupation = lOccupation.text.toString();
          //
        });
      }

      if (appProvider.addRider == true) {
        parametersProvider.riderSA = double.parse(riderAdded.text).toString();
        parametersProvider.premiumRider = premiumRider.toString();
        parametersProvider.totalPremium =
            (premiumNum + premiumRider).toString();
      } else {
        parametersProvider.riderSA = "0";
        parametersProvider.premiumRider = "0";
        parametersProvider.totalPremium = premiumNum.toString();
      }

      parametersProvider.policyTerm = selectedYear.toString();
      parametersProvider.annualP = premiumNum.toString();
      parametersProvider.basicSA = sumAssured.text.toString();
      appProvider.activeTabIndex = 1;
      Navigator.of(context).pushNamed("/main_flow");
    }
    //

    return SafeArea(
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: mq.size.height / 9.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSwitch(
                value: appProvider.differentPerson,
                title: "Buying For Someone Else",
                onChanged: (bool) {
                  setState(() {
                    appProvider.differentPerson = bool;
                  });
                },
              ),
              Visibility(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FieldTitle(
                              fieldTitle: "Proposer",
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: mq.size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      formLabel: "First Name",
                                      formInputType: TextInputType.name,
                                      formController: pFirstName,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: CustomTextField(
                                      formLabel: "Last Name",
                                      formInputType: TextInputType.name,
                                      formController: pLastName,
                                      onChange: (value) async {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: mq.size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: AgeField(
                                        formController: pAge,
                                      )),
                                  SizedBox(width: 5),
                                  Expanded(
                                      flex: 2,
                                      child: CustomDatePicker(
                                        focusNode: AlwaysDisabledFocusNode(),
                                        dob: pDob,
                                        onTap: () {
                                          _selectDate(context, pDob, pAge);
                                        },
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: CustomDropDown(
                                      title: "Gender",
                                      value: pSelectedGender,
                                      items: genderTypes,
                                      onChange: (value) {
                                        setState(() {
                                          pSelectedGender = value;
                                        });
                                      },
                                    )),
                                    SizedBox(width: 5),
                                    Expanded(
                                      flex: 2,
                                      child: CustomTextField(
                                        formInputType: TextInputType.text,
                                        formLabel: "Occupation",
                                        formController: pOccupation,
                                      ),
                                    )
                                  ]),
                            )
                          ]),
                    )),
                visible: appProvider.differentPerson,
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FieldTitle(
                      fieldTitle: "Life Proposed",
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: mq.size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              formLabel: "First Name",
                              formInputType: TextInputType.name,
                              formController: firstName,
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: CustomTextField(
                              formLabel: "Last Name",
                              formInputType: TextInputType.name,
                              formController: lastName,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: mq.size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: AgeField(
                                formController: age,
                              )),
                          SizedBox(width: 5),
                          Expanded(
                              flex: 2,
                              child: CustomDatePicker(
                                focusNode: AlwaysDisabledFocusNode(),
                                dob: dob,
                                onTap: () {
                                  _selectDate(context, dob, age);
                                },
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: CustomDropDown(
                            title: "Gender",
                            value: lSelectedGender,
                            items: genderTypes,
                            onChange: (value) {
                              setState(() {
                                lSelectedGender = value;
                              });
                            },
                          )),
                          SizedBox(width: 5),
                          Expanded(
                            flex: 2,
                            child: CustomTextField(
                              formInputType: TextInputType.text,
                              formLabel: "Occupation",
                              formController: lOccupation,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: mq.size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomDropDown(
                              title: "Payment Mode",
                              value: selectedMode,
                              items: paymentMode,
                              onChange: (value) {
                                setState(() {
                                  selectedMode = value;
                                  if ((premium.text.isNotEmpty ||
                                          sumAssured.text.isNotEmpty) &&
                                      (selectedYear != null)) {
                                    if (premium.text.isNotEmpty) {
                                      sumAssured.text = ((((double.parse(
                                                          premium.text) /
                                                      (paymentModeValue(
                                                              selectedMode)[1] *
                                                          paymentModeValue(
                                                                  selectedMode)[
                                                              0])) *
                                                  selectedYear.toDouble())) *
                                              paymentModeValue(selectedMode)[0])
                                          .toStringAsFixed(2);
                                    } else if (sumAssured.text.isNotEmpty) {
                                      premiumNum =
                                          (double.parse(sumAssured.text) /
                                                  selectedYear.toDouble()) *
                                              paymentModeValue(selectedMode)[1];
                                      premium.text =
                                          premiumNum.toStringAsFixed(2);
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            flex: 1,
                            child: CustomDropDown(
                              title: "Policy Year",
                              value: selectedYear,
                              items: policyYears,
                              onChange: (value) {
                                setState(() {
                                  selectedYear = value;
                                  if ((premium.text.isNotEmpty ||
                                          sumAssured.text.isNotEmpty) &&
                                      selectedMode.isNotEmpty) {
                                    if (premium.text.isNotEmpty) {
                                      sumAssured.text = ((((double.parse(
                                                          premium.text) /
                                                      (paymentModeValue(
                                                              selectedMode)[1] *
                                                          paymentModeValue(
                                                                  selectedMode)[
                                                              0])) *
                                                  selectedYear.toDouble())) *
                                              paymentModeValue(selectedMode)[0])
                                          .toStringAsFixed(2);
                                    } else if (sumAssured.text.isNotEmpty) {
                                      premiumNum =
                                          (double.parse(sumAssured.text) /
                                                  selectedYear.toDouble()) *
                                              paymentModeValue(selectedMode)[1];
                                      premium.text =
                                          premiumNum.toStringAsFixed(2);
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      formLabel: "Premium Payable",
                      formInputType: TextInputType.number,
                      formController: premium,
                      onChange: (text) {
                        if (selectedYear != null) {
                          if (text == "") {
                            sumAssured.text = "";
                          } else
                            sumAssured.text = ((((double.parse(text) /
                                                (paymentModeValue(
                                                        selectedMode)[1] *
                                                    paymentModeValue(
                                                        selectedMode)[0])) *
                                            selectedYear.toDouble())
                                        .round()) *
                                    paymentModeValue(selectedMode)[0])
                                .toStringAsFixed(2);
                        } else {
                          sumAssured.text = null;
                        }
                      },
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      formLabel: "Sum Assured",
                      formInputType: TextInputType.number,
                      formController: sumAssured,
                      onChange: (text) {
                        if (selectedYear != null) {
                          if (text == "") {
                            premium.text = "";
                          } else
                            premiumNum = ((double.parse(text) /
                                    selectedYear.toDouble()) *
                                paymentModeValue(selectedMode)[1]);
                          premium.text = premiumNum.toStringAsFixed(2);
                        } else {
                          premium.text = null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              CustomSwitch(
                value: appProvider.addRider,
                title: "Add Rider",
                onChanged: (bool) {
                  setState(() {
                    appProvider.addRider = bool;
                  });
                },
              ),
              Visibility(
                  visible: appProvider.addRider,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    child: CustomTextField(
                      formInputType: TextInputType.number,
                      formLabel: "Added Rider",
                      formController: riderAdded,
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: CalculateButton(
                      onPressed: () async {
                        if (appProvider.addRider == true) {
                          await getRate(
                              true, int.parse(age.text), selectedYear);
                          calculateAndPDF();
                        } else
                          calculateAndPDF();
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: ResetButton(
                        onPressed: () {
                          //Proposer
                          pFirstName.clear();
                          pLastName.clear();
                          pAge.clear();
                          pDob.clear();
                          pGender.clear();
                          pOccupation.clear();
                          //

                          //Life Proposed
                          firstName.clear();
                          lastName.clear();
                          age.clear();
                          dob.clear();
                          sumAssured.clear();
                          premium.clear();
                          gender.clear();
                          lOccupation.clear();
                          policyYear.clear();

                          riderAdded.clear();

                          lSelectedGender = null;
                          pSelectedGender = null;
                          selectedYear = 0;
                        },
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Date Picker Function
  _selectDate(BuildContext context, TextEditingController tec,
      TextEditingController tecAge) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                surface: Colors.blueAccent,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      setState(() {
        _selectedDate = newSelectedDate;
        String dateTime = _selectedDate.toString();
        tec.text = convertDateTimeDisplay(dateTime);
        tec.selection = TextSelection.fromPosition(TextPosition(
            offset: dob.text.length, affinity: TextAffinity.upstream));
        tecAge.text = calculateAge(_selectedDate);
      });
    }
  }
//

// Calculate age from datepicker
  calculateAge(DateTime birthDate) {
    int age = _currentDate.year - birthDate.year;
    int month1 = _currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = _currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age.toString();
  }
  //

  //Validation

  //Convert DateTime format to Date form
  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  //

}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
