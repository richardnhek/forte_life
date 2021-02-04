import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:forte_life/providers/parameters_provider.dart';
import 'package:forte_life/utils/device_utils.dart';
import 'package:forte_life/widgets/added_ryder.dart';
import 'package:forte_life/widgets/calculate_button.dart';
import 'package:forte_life/widgets/custom_text_field.dart';
import 'package:forte_life/widgets/dropdown_text.dart';
import 'package:forte_life/widgets/field_title.dart';
import 'package:forte_life/widgets/reset_button.dart';
import 'package:intl/intl.dart';
import 'package:forte_life/widgets/age_field.dart';
import 'package:provider/provider.dart';
import 'dart:convert' show utf8;

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

  TextEditingController ryderAdded = TextEditingController();

  String lSelectedGender;
  String pSelectedGender;
  int selectedYear;
  int selectedRyder;

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

  List<DropdownMenuItem> policyYears = [
    DropdownMenuItem(child: DropDownText(title: "10"), value: 10),
    DropdownMenuItem(child: DropDownText(title: "15"), value: 15),
    DropdownMenuItem(child: DropDownText(title: "20"), value: 20),
    DropdownMenuItem(child: DropDownText(title: "25"), value: 25),
    DropdownMenuItem(child: DropDownText(title: "30"), value: 30),
    DropdownMenuItem(child: DropDownText(title: "35"), value: 35)
  ];

  List<DropdownMenuItem> ryderList = [
    DropdownMenuItem(child: Text("1"), value: 1),
    DropdownMenuItem(child: Text("2"), value: 2),
    DropdownMenuItem(child: Text("3"), value: 3),
    DropdownMenuItem(child: Text("4"), value: 4),
    DropdownMenuItem(child: Text("5"), value: 5),
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
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final mq = MediaQuery.of(context);
    final _formKey = GlobalKey<FormState>();
    //Calculate and Generate PDF
    void calculateAndPDF() {
      ParametersProvider parametersProvider =
          Provider.of<ParametersProvider>(context, listen: false);
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
          parametersProvider.pName =
              pFirstName.text.toString() + " " + pLastName.text.toString();
          parametersProvider.pAge = pAge.text.toString();
          parametersProvider.pGender = pSelectedGender.toString();
          parametersProvider.pOccupation = pOccupation.text.toString();

          parametersProvider.lpName =
              lastName.text.toString() + " " + firstName.text.toString();
          parametersProvider.lpAge = age.text.toString();
          parametersProvider.lpGender = lSelectedGender.toString();
          parametersProvider.lpOccupation = lOccupation.text.toString();
        });
      }

      parametersProvider.policyTerm = selectedYear.toString();
      parametersProvider.annualP = premium.text.toString();
      parametersProvider.basicSA = sumAssured.text.toString();
      appProvider.activeTabIndex = 1;
      Navigator.of(context).pushNamed("/main_flow");
    }
    //

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: mq.size.height / 9),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: SwitchListTile(
                      title: Text(
                        "Buying For Someone Else",
                        style: TextStyle(
                            fontFamily: "Kano",
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      activeColor: Color(0xFF8AB84B),
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      value: appProvider.differentPerson,
                      onChanged: (bool) {
                        setState(() {
                          appProvider.differentPerson = bool;
                        });
                      }),
                ),
                Visibility(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FieldTitle(
                          fieldTitle: "Proposer",
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    formLabel: "First Name",
                                    formInputType: TextInputType.name,
                                    formController: pFirstName,
                                    extraLeftPadding: 5,
                                    extraTopPadding: 0,
                                  ),
                                ),
                                Expanded(
                                  child: CustomTextField(
                                      formLabel: "Last Name",
                                      formInputType: TextInputType.name,
                                      formController: pLastName,
                                      extraLeftPadding: 5,
                                      extraTopPadding: 0),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: AgeField(
                                      formController: pAge,
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFB8B8B8))),
                                    child: TextField(
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.only(
                                              left: 5, top: 10, bottom: 10),
                                          hintText: "Date of Birth",
                                          labelText: "Date of Birth",
                                          labelStyle: TextStyle(
                                              fontFamily: "Kano",
                                              fontSize: 15,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                          hintStyle: TextStyle(
                                              fontFamily: "Kano",
                                              fontSize: 15,
                                              color: Colors.black
                                                  .withOpacity(0.5))),
                                      focusNode: AlwaysDisabledFocusNode(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: "Kano"),
                                      controller: pDob,
                                      onTap: () {
                                        _selectDate(context, pDob, pAge);
                                      },
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Container(
                                  height: DeviceUtils.getResponsive(
                                      appProvider: appProvider,
                                      mq: mq,
                                      onPhone: mq.size.height / 13.3,
                                      onTablet: mq.size.height / 13.3),
                                  padding: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xFFB8B8B8))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        iconSize: 17.5,
                                        value: pSelectedGender,
                                        hint: Text(
                                          "Gender",
                                          style: TextStyle(
                                              fontFamily: "Kano",
                                              fontSize: 15,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                        items: genderTypes,
                                        onChanged: (value) {
                                          setState(() {
                                            pSelectedGender = value;
                                          });
                                        }),
                                  ),
                                ),
                              )),
                              Expanded(
                                flex: 2,
                                child: CustomTextField(
                                  formInputType: TextInputType.text,
                                  formLabel: "Occupation",
                                  formController: pOccupation,
                                  extraLeftPadding: 0,
                                  extraTopPadding: 0,
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                  visible: appProvider.differentPerson,
                ),
                FieldTitle(
                  fieldTitle: "Life Proposed",
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          formLabel: "First Name",
                          formInputType: TextInputType.name,
                          formController: firstName,
                          extraLeftPadding: 5,
                          extraTopPadding: 0,
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          formLabel: "Last Name",
                          formInputType: TextInputType.name,
                          formController: lastName,
                          extraLeftPadding: 5,
                          extraTopPadding: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: AgeField(
                          formController: age,
                        )),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFB8B8B8))),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.only(left: 5, top: 10, bottom: 10),
                              hintText: "Date of Birth",
                              labelText: "Date of Birth",
                              labelStyle: TextStyle(
                                  fontFamily: "Kano",
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.5)),
                              hintStyle: TextStyle(
                                  fontFamily: "Kano",
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.5))),
                          focusNode: AlwaysDisabledFocusNode(),
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Kano",
                              fontSize: 15),
                          controller: dob,
                          onTap: () {
                            _selectDate(context, dob, age);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          height: DeviceUtils.getResponsive(
                              appProvider: appProvider,
                              mq: mq,
                              onPhone: mq.size.height / 13.3,
                              onTablet: mq.size.height / 13.3),
                          padding: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFB8B8B8))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                iconSize: 17.5,
                                value: lSelectedGender,
                                hint: Text(
                                  "Gender",
                                  style: TextStyle(
                                      fontFamily: "Kano",
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                items: genderTypes,
                                onChanged: (value) {
                                  setState(() {
                                    lSelectedGender = value;
                                  });
                                }),
                          ),
                        ),
                      )),
                      Expanded(
                        flex: 2,
                        child: CustomTextField(
                          formInputType: TextInputType.text,
                          formLabel: "Occupation",
                          formController: lOccupation,
                          extraLeftPadding: 0,
                          extraTopPadding: 0,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: DeviceUtils.getResponsive(
                              appProvider: appProvider,
                              mq: mq,
                              onPhone: mq.size.height / 13.3,
                              onTablet: mq.size.height / 13.3),
                          padding: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFB8B8B8))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                iconSize: 17.5,
                                value: selectedYear,
                                hint: Text(
                                  "Policy Year",
                                  style: TextStyle(
                                      fontFamily: "Kano",
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                items: policyYears,
                                onChanged: (value) {
                                  setState(() {
                                    selectedYear = value;
                                    if (premium.text.isNotEmpty ||
                                        sumAssured.text.isNotEmpty) {
                                      if (premium.text.isNotEmpty) {
                                        sumAssured.text =
                                            (int.parse(premium.text) *
                                                    selectedYear)
                                                .toString();
                                      } else if (sumAssured.text.isNotEmpty) {
                                        premium.text =
                                            (int.parse(sumAssured.text) /
                                                    selectedYear)
                                                .toString();
                                      }
                                    }
                                  });
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  formLabel: "Premium Payable",
                  formInputType: TextInputType.number,
                  formController: premium,
                  extraLeftPadding: 5,
                  extraTopPadding: 5,
                  onChange: (text) {
                    if (selectedYear != null) {
                      sumAssured.text =
                          (int.parse(text) * selectedYear).toString();
                    } else {
                      sumAssured.text = " ";
                    }
                  },
                ),
                CustomTextField(
                  formLabel: "Sum Insured",
                  formInputType: TextInputType.number,
                  formController: sumAssured,
                  extraLeftPadding: 5,
                  extraTopPadding: 5,
                  onChange: (text) {
                    if (selectedYear != null) {
                      premium.text =
                          (int.parse(text) / selectedYear).toString();
                    } else {
                      premium.text = " ";
                    }
                  },
                ),
                Container(
                  child: SwitchListTile(
                      title: Text(
                        "Add Ryder",
                        style: TextStyle(
                            fontFamily: "Kano",
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      activeColor: Color(0xFF8AB84B),
                      value: appProvider.addRyder,
                      onChanged: (bool) {
                        setState(() {
                          appProvider.addRyder = bool;
                        });
                      }),
                ),
                Visibility(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: DeviceUtils.getResponsive(
                                appProvider: appProvider,
                                mq: mq,
                                onPhone: mq.size.height / 13.3,
                                onTablet: mq.size.height / 13.3),
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFB8B8B8))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: selectedRyder,
                                  hint: Text(
                                    "Ryder",
                                    style: TextStyle(
                                        fontFamily: "Kano",
                                        fontSize: 15,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                  items: ryderList,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRyder = value;
                                    });
                                  }),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: AddedRyder(
                              formController: ryderAdded,
                            ))
                      ],
                    ),
                  ),
                  visible: appProvider.addRyder,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: CalculateButton(
                        onPressed: () {
                          calculateAndPDF();
                        },
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: ResetButton(
                          onPressed: () {
                            print("Reset");
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

  //Check

  //Validate age limitations
  bool checkAgeLimit(int pYear, int age) {
    if (pYear + age <= 69) {
      return true;
    } else {
      return false;
    }
  }

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
