import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:forte_life/providers/parameters_provider.dart';
import 'package:forte_life/widgets/calculate_button.dart';
import 'package:forte_life/widgets/custom_datepicker.dart';
import 'package:forte_life/widgets/custom_dialogtext.dart';
import 'package:forte_life/widgets/custom_dropdown.dart';
import 'package:forte_life/widgets/custom_switch.dart';
import 'package:forte_life/widgets/custom_text_field.dart';
import 'package:forte_life/widgets/dropdown_text.dart';
import 'package:forte_life/widgets/field_title.dart';
import 'package:forte_life/widgets/reset_button.dart';

import 'package:intl/intl.dart';
import 'package:forte_life/widgets/age_field.dart';
import 'package:provider/provider.dart';

class CalculationEducationUI extends StatefulWidget {
  @override
  _CalculationEducationUIState createState() => _CalculationEducationUIState();
}

class _CalculationEducationUIState extends State<CalculationEducationUI> {
  FocusNode premiumFocusNode;

  @override
  void initState() {
    super.initState();
  }

  //Payor
  TextEditingController pFirstName = TextEditingController();
  TextEditingController pLastName = TextEditingController();
  TextEditingController pAge = TextEditingController();
  TextEditingController pDob = TextEditingController();
  TextEditingController pGender = TextEditingController();
  TextEditingController pOccupation = TextEditingController();
  //

  //Child
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
  String selectedMode = "Yearly";

  //Necessary error variables
  int counter = 0;
  //
  //

  int selectedYear = 10;
  double premiumNum;
  double sumAssuredNum;

  List<Widget> customDialogChildren = List();

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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    DropdownMenuItem(child: DropDownText(title: "11"), value: 11),
    DropdownMenuItem(child: DropDownText(title: "12"), value: 12),
    DropdownMenuItem(child: DropDownText(title: "13"), value: 13),
    DropdownMenuItem(child: DropDownText(title: "14"), value: 14),
    DropdownMenuItem(child: DropDownText(title: "15"), value: 15),
    DropdownMenuItem(child: DropDownText(title: "16"), value: 16),
    DropdownMenuItem(child: DropDownText(title: "17"), value: 17),
  ];

  DateTime _selectedDate;
  DateTime _currentDate = DateTime.now();
  //

  @override
  Widget build(BuildContext context) {
    ParametersProvider parametersProvider =
        Provider.of<ParametersProvider>(context, listen: false);
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final mq = MediaQuery.of(context);
    showAlertDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        contentPadding: EdgeInsets.only(top: 25, left: 10, right: 10),
        title: Center(
            child: Container(
                child: Text(
          "Error Inputs",
          style: TextStyle(
              color: Colors.red,
              fontFamily: "Kano",
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ))),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: customDialogChildren),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

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
      //Payor
      parametersProvider.pName =
          pFirstName.text.toString() + " " + pLastName.text.toString();
      parametersProvider.pAge = pAge.text.toString();
      parametersProvider.pGender = pSelectedGender.toString();
      parametersProvider.pOccupation = pOccupation.text.toString();
      //

      //Child
      parametersProvider.lpName =
          lastName.text.toString() + " " + firstName.text.toString();
      parametersProvider.lpAge = age.text.toString();
      parametersProvider.lpGender = lSelectedGender.toString();
      parametersProvider.lpOccupation = lOccupation.text.toString();
      //

      parametersProvider.policyTerm = selectedYear.toString();
      parametersProvider.annualP = premiumNum.toString();
      parametersProvider.basicSA = sumAssuredNum.toString();
      appProvider.pdfScreenIndex = 1;
      appProvider.activeTabIndex = 1;
      Navigator.of(context).pushNamed("/main_flow");
    }
    //

    return SafeArea(
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: mq.size.height / 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FieldTitle(
                            fieldTitle: "Payor",
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
                                    formController: pFirstName,
                                    errorVisible: false,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: CustomTextField(
                                    formLabel: "Last Name",
                                    formInputType: TextInputType.name,
                                    formController: pLastName,
                                    errorVisible: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: mq.size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: AgeField(
                                      formController: pAge,
                                      errorVisible: false,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: CustomDropDown(
                                    title: "Gender",
                                    value: pSelectedGender,
                                    errorVisible: false,
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
                                      errorVisible: false,
                                    ),
                                  )
                                ]),
                          )
                        ])),
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
                                errorVisible: false,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: CustomTextField(
                                formLabel: "Last Name",
                                formInputType: TextInputType.name,
                                formController: lastName,
                                errorVisible: false,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                                  errorVisible: false,
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
                              errorVisible: false,
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
                                errorVisible: false,
                              ),
                            )
                          ],
                        ),
                      ),
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
                                errorVisible: false,
                                items: paymentMode,
                                onChange: (value) {
                                  setState(() {
                                    selectedMode = value;
                                    if ((premium.text.isNotEmpty ||
                                            sumAssured.text.isNotEmpty) &&
                                        (selectedYear != null)) {
                                      if (premium.text.isNotEmpty) {
                                        premiumNum = double.parse(premium.text);
                                        sumAssured.text = ((((double.parse(
                                                            premium.text) /
                                                        (paymentModeValue(
                                                                    selectedMode)[
                                                                1] *
                                                            paymentModeValue(
                                                                    selectedMode)[
                                                                0])) *
                                                    selectedYear.toDouble())) *
                                                paymentModeValue(
                                                    selectedMode)[0])
                                            .toStringAsFixed(2);
                                      } else if (sumAssured.text.isNotEmpty) {
                                        premiumNum = (double.parse(
                                                    sumAssured.text) /
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
                                errorVisible: false,
                                onChange: (value) {
                                  setState(() {
                                    selectedYear = value;
                                    if ((premium.text.isNotEmpty ||
                                            sumAssured.text.isNotEmpty) &&
                                        selectedMode.isNotEmpty) {
                                      if (premium.text.isNotEmpty) {
                                        premiumNum = double.parse(premium.text);
                                        sumAssured.text = ((((double.parse(
                                                            premium.text) /
                                                        (paymentModeValue(
                                                                    selectedMode)[
                                                                1] *
                                                            paymentModeValue(
                                                                    selectedMode)[
                                                                0])) *
                                                    selectedYear.toDouble())) *
                                                paymentModeValue(
                                                    selectedMode)[0])
                                            .toStringAsFixed(2);
                                      } else if (sumAssured.text.isNotEmpty) {
                                        premiumNum = (double.parse(
                                                    sumAssured.text) /
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
                      CustomTextField(
                        formLabel: "Premium Payable",
                        formInputType: TextInputType.number,
                        formController: premium,
                        errorVisible: false,
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
                                          selectedYear.toDouble())) *
                                      paymentModeValue(selectedMode)[0])
                                  .toStringAsFixed(2);
                            premiumNum = double.parse(text);
                            sumAssuredNum = double.parse(sumAssured.text);
                          } else {
                            sumAssured.text = null;
                          }
                        },
                      ),
                      CustomTextField(
                        formLabel: "Sum Assured",
                        formInputType: TextInputType.number,
                        formController: sumAssured,
                        errorVisible: false,
                        onChange: (text) {
                          if (selectedYear != null) {
                            if (text == "") {
                              premium.text = "";
                            } else
                              premiumNum = ((double.parse(text) /
                                      selectedYear.toDouble()) *
                                  paymentModeValue(selectedMode)[1]);
                            premium.text = premiumNum.toStringAsFixed(2);
                            sumAssuredNum = double.parse(text);
                            premiumNum = double.parse(premium.text);
                          } else {
                            premium.text = null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: CalculateButton(onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          counter = 0;
                          customDialogChildren.clear();
                          _formKey.currentState.save();
                          sumAssuredValidation(
                              sumAssured.text, premium.text, selectedYear);
                          premiumValidation(premium.text);
                          ageValidation(age.text, pAge.text, selectedYear);
                          print(counter);
                          if (counter == 3) {
                            calculateAndPDF();
                          } else
                            showAlertDialog(context);
                        } else {
                          customDialogChildren.add(CustomDialogText(
                            description: "No Inputs",
                          ));
                          showAlertDialog(context);
                        }
                      }),
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
      ),
    );
  }

  // Date Picker Function
  _selectDate(BuildContext context, TextEditingController tec,
      TextEditingController tecAge) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(1940),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xFF8AB84B),
                onPrimary: Colors.white,
                surface: Color(0xFF8AB84B),
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

  //Convert DateTime format to Date form
  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormatter = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormatter.parse(date);
    final String formatted = serverFormatter.format(displayDate);
    return formatted;
  }
  //

  //Validate Age
  void ageValidation(String ageText, String pAgeText, int policyTerm) {
    if (ageText.isEmpty || pAgeText.isEmpty) {
      customDialogChildren.add(CustomDialogText(
        description: "Age field can't be empty",
      ));
    } else {
      if (((int.parse(pAgeText) + policyTerm) > 69) ||
          (int.parse(pAgeText) < 18) ||
          (int.parse(pAgeText) > 59) ||
          (int.parse(ageText) < 1) ||
          ((int.parse(ageText) + policyTerm) > 18)) {
        if ((int.parse(pAgeText) + policyTerm) > 69 ||
            (int.parse(pAgeText) > 59)) {
          customDialogChildren.add(CustomDialogText(
            description:
                "Payor's age limit exceeded, please check information page.",
          ));
        }
        if (int.parse(pAgeText) < 18) {
          customDialogChildren.add(CustomDialogText(
            description: "Payor's age under 18, please check information page",
          ));
        }
        if (int.parse(ageText) < 1) {
          customDialogChildren.add(CustomDialogText(
            description: "Child's age must be at least 1 year old",
          ));
        }
        if ((int.parse(ageText) + policyTerm) > 18) {
          customDialogChildren.add(CustomDialogText(
            description:
                "Child's age limit exceeded, please check information page",
          ));
        }
      } else {
        counter++;
      }
    }
  }
  //

  //Validate Sum Assured
  void sumAssuredValidation(
      String sumAssuredAmount, String premiumAmount, int policyTerm) {
    if (sumAssuredAmount.isEmpty) {
      customDialogChildren.add(CustomDialogText(
        description: "Sum Assured can't be empty",
      ));
    } else {
      if (double.parse(sumAssuredAmount) < 2400) {
        customDialogChildren.add(CustomDialogText(
          description: "Sum Assured must be at least 2400 USD",
        ));
      } else {
        if (double.parse(sumAssuredAmount) <
            (double.parse(premiumAmount) *
                double.parse(policyTerm.toString()))) {
          customDialogChildren.add(CustomDialogText(
            description:
                "Sum Assured must be more than ${int.parse((double.parse(premiumAmount) * double.parse(policyTerm.toString())).toStringAsFixed(0))} for Policy Term $policyTerm and Premium $premium",
          ));
        }
      }
    }
  }
  //

  //Validate Sum Assured
  void premiumValidation(String premiumAmount) {
    if (premiumAmount.isEmpty) {
      customDialogChildren.add(CustomDialogText(
        description: "Premium can't be empty",
      ));
    } else if (double.parse(premiumAmount) < 240) {
      customDialogChildren.add(CustomDialogText(
        description: "Premium must be at least 240 USD",
      ));
    } else {
      counter++;
    }
  }
  //

}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
