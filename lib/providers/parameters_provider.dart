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
  int _lpAge = 0;

  int get lpAge => _lpAge;

  set lpAge(int i) {
    _lpAge = i;
    notifyListeners();
  }

  //
  // Proposer's Age
  int _pAge = 0;

  int get pAge => _pAge;

  set pAge(int i) {
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
  //Basic Sum Assured
  int _basicSA = 0;
  int get basicSA => _basicSA;

  set basicSA(int i) {
    _basicSA = i;
    notifyListeners();
  }
  //

  //Annual Premium
  int _annualP = 0;
  int get annualP => _annualP;

  set annualP(int i) {
    _annualP = i;
    notifyListeners();
  }

  //
  //Policy Term
  int _policyTerm = 0;
  int get policyTerm => _policyTerm;

  set policyTerm(int i) {
    _policyTerm = i;
    notifyListeners();
  }
  //
//
}
