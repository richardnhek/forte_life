import 'package:flutter/material.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:forte_life/utils/device_utils.dart';
import 'package:forte_life/widgets/custom_text_field.dart';
import 'package:forte_life/widgets/field_title.dart';
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

  TextEditingController pFirstName = new TextEditingController();
  TextEditingController pLastName = new TextEditingController();
  TextEditingController pAge = new TextEditingController();
  TextEditingController pDob = new TextEditingController();
  TextEditingController pGender = new TextEditingController();
  TextEditingController pOccupation = new TextEditingController();
  //

  //Life Proposed
  TextEditingController firstName = new TextEditingController();

  TextEditingController lastName = new TextEditingController();

  TextEditingController age = new TextEditingController();

  TextEditingController dob = new TextEditingController();

  TextEditingController premium = new TextEditingController();

  TextEditingController gender = new TextEditingController();

  TextEditingController policyYear = new TextEditingController();

  TextEditingController sumAssured = new TextEditingController();

  int lSelectedGender;
  int pSelectedGender;
  int selectedYear;

  List<DropdownMenuItem> genderTypes = [
    DropdownMenuItem(child: Text("Male"), value: 1),
    DropdownMenuItem(child: Text("Female"), value: 2)
  ];

  List<DropdownMenuItem> policyYears = [
    DropdownMenuItem(child: Text("10"), value: 10),
    DropdownMenuItem(child: Text("15"), value: 15),
    DropdownMenuItem(child: Text("20"), value: 20),
    DropdownMenuItem(child: Text("25"), value: 25),
    DropdownMenuItem(child: Text("30"), value: 30),
    DropdownMenuItem(child: Text("35"), value: 35)
  ];

  DateTime _selectedDate;
  DateTime _currentDate = DateTime.now();
  //

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final mq = MediaQuery.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: CheckboxListTile(
                    title: Text(
                      "Buying For Someone Else",
                      style: TextStyle(
                          fontFamily: "Kano",
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                    dense: true,
                    contentPadding: EdgeInsets.all(5),
                    value: appProvider.differentPerson,
                    onChanged: (bool) {
                      setState(() {
                        appProvider.differentPerson = bool;
                      });
                    }),
              ),
              Visibility(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FieldTitle(
                      fieldTitle: "Proposer",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            formLabel: "First Name",
                            formInputType: TextInputType.name,
                            formController: pFirstName,
                          ),
                        ),
                        Expanded(
                          child: CustomTextField(
                            formLabel: "Last Name",
                            formInputType: TextInputType.name,
                            formController: pLastName,
                          ),
                        ),
                      ],
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
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, right: 5, left: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xFFB8B8B8))),
                                  child: TextField(
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: "Date of Birth",
                                        hintStyle: TextStyle(
                                            fontFamily: "Kano",
                                            fontSize: 16,
                                            color:
                                                Colors.black.withOpacity(0.5))),
                                    focusNode: AlwaysDisabledFocusNode(),
                                    style: TextStyle(color: Colors.black),
                                    controller: pDob,
                                    onTap: () {
                                      _selectDate(context, pDob, pAge);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              height: DeviceUtils.getResponsive(
                                  appProvider: appProvider,
                                  mq: mq,
                                  onPhone: mq.size.height / 18.5,
                                  onTablet: mq.size.height / 18.5),
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFB8B8B8))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    value: pSelectedGender,
                                    hint: Text(
                                      "Gender",
                                      style: TextStyle(
                                          fontFamily: "Kano",
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(0.5)),
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
                            ),
                          )
                        ])
                  ],
                ),
                visible: appProvider.differentPerson,
              ),
              FieldTitle(
                fieldTitle: "Life Proposed",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextField(
                      formLabel: "First Name",
                      formInputType: TextInputType.name,
                      formController: firstName,
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      formLabel: "Last Name",
                      formInputType: TextInputType.name,
                      formController: lastName,
                    ),
                  ),
                ],
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
                          formController: age,
                        )),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFB8B8B8))),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.all(10),
                                hintText: "Date of Birth",
                                hintStyle: TextStyle(
                                    fontFamily: "Kano",
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.5))),
                            focusNode: AlwaysDisabledFocusNode(),
                            style: TextStyle(color: Colors.black),
                            controller: dob,
                            onTap: () {
                              _selectDate(context, dob, age);
                            },
                          ),
                        ),
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
                      child: Padding(
                    padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                    child: Container(
                      height: DeviceUtils.getResponsive(
                          appProvider: appProvider,
                          mq: mq,
                          onPhone: mq.size.height / 18.5,
                          onTablet: mq.size.height / 18.5),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFB8B8B8))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: lSelectedGender,
                            hint: Text(
                              "Gender",
                              style: TextStyle(
                                  fontFamily: "Kano",
                                  fontSize: 16,
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
                      child: Padding(
                        padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                        child: Container(
                          height: DeviceUtils.getResponsive(
                              appProvider: appProvider,
                              mq: mq,
                              onPhone: mq.size.height / 18.5,
                              onTablet: mq.size.height / 18.5),
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFB8B8B8))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                value: selectedYear,
                                hint: Text(
                                  "Policy Year",
                                  style: TextStyle(
                                      fontFamily: "Kano",
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                items: policyYears,
                                onChanged: (value) {
                                  setState(() {
                                    selectedYear = value;
                                  });
                                }),
                          ),
                        ),
                      )),
                ],
              ),
              CustomTextField(
                formLabel: "Premium Payable",
                formInputType: TextInputType.number,
                formController: premium,
              ),
              CustomTextField(
                formLabel: "Sum Assured",
                formInputType: TextInputType.number,
                formController: sumAssured,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFF8AB84B),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.16),
                                spreadRadius: 1,
                                blurRadius: 5)
                          ]),
                      child: FlatButton(
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          print("Calculate");
                        },
                        child: Text(
                          "Calculate",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Kano",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFD31145)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          print("Reset");
                        },
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Kano",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

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

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
