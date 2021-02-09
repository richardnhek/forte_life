import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParametersProvider extends ChangeNotifier {
  //Parameters
  //Life Proposed's Name
  String _lpName = " ";
  String get lpName => _lpName;

  set lpName(String i) {
    _lpName = i.toUpperCase();
    notifyListeners();
  }

  //
  //Proposer's Name
  String _pName = " ";
  String get pName => _pName;

  set pName(String i) {
    _pName = i.toUpperCase();
    notifyListeners();
  }

  //
  // Life Proposed's Age
  String _lpAge = "0";

  String get lpAge => _lpAge;

  set lpAge(String i) {
    _lpAge = i;
    notifyListeners();
  }

  //
  // Proposer's Age
  String _pAge = "0";

  String get pAge => _pAge;

  set pAge(String i) {
    _pAge = i;
    notifyListeners();
  }

  //
  //Life Proposed's Gender
  String _lpGender = " ";
  String get lpGender => _lpGender;

  set lpGender(String i) {
    _lpGender = i.toUpperCase();
    notifyListeners();
  }

  //
  //Proposer's Gender
  String _pGender = " ";
  String get pGender => _pGender;

  set pGender(String i) {
    _pGender = i.toUpperCase();
    notifyListeners();
  }

  //
  //Proposer's Occupation
  String _pOccupation = " ";
  String get pOccupation => _pOccupation;

  set pOccupation(String i) {
    _pOccupation = i.toUpperCase();
    notifyListeners();
  }
  //

  //Life Proposed's Occupation
  String _lpOccupation = " ";
  String get lpOccupation => _lpOccupation;

  set lpOccupation(String i) {
    _lpOccupation = i.toUpperCase();
    notifyListeners();
  }
  //

  //Basic Sum Assured
  String _basicSA = "0";
  String get basicSA => _basicSA;

  set basicSA(String i) {
    _basicSA = i;
    notifyListeners();
  }
  //

  //Annual Premium
  String _annualP = "0";
  String get annualP => _annualP;

  set annualP(String i) {
    _annualP = i;
    notifyListeners();
  }

  //
  //Policy Term
  String _policyTerm = "0";
  String get policyTerm => _policyTerm;

  set policyTerm(String i) {
    _policyTerm = i;
    notifyListeners();
  }
  //

  //Ryder SA
  String _ryderSA = "0";
  String get ryderSA => _ryderSA;

  set ryderSA(String i) {
    _ryderSA = i;
    notifyListeners();
  }
  //

  //Get Rate

  //

  //Total Premium
  String _totalPremium = "0";
  String get totalPremium => _totalPremium;

  set totalPremium(String i) {
    _totalPremium = i;
    notifyListeners();
  }
  //
//
}
