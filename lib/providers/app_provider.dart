import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:flutter/services.dart';

class AppProvider extends ChangeNotifier {
  // Bottom Navigation Index
  int _activeTabIndex = 0;

  int get activeTabIndex => _activeTabIndex;

  set activeTabIndex(int i) {
    _activeTabIndex = i;
    notifyListeners();
  }
  //

  // LP and P are the same or not
  bool _differentPerson = true;
  bool get differentPerson => _differentPerson;

  set differentPerson(bool i) {
    _differentPerson = i;
    notifyListeners();
  }
  //

  void setAppOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  // Categories tab index is to tell the navigator which child the Categories tab is currently on
  int _categoriesTabIndex = 0;

  int get categoriesTabIndex => _categoriesTabIndex;

  set categoriesTabIndex(int i) {
    _categoriesTabIndex = i;
    notifyListeners();
  }
  //

  //Check type of device
  bool _isTablet = false;
  bool get isTablet => _isTablet;
  set isTablet(bool a) {
    _isTablet = a;
    notifyListeners();
  }

  Future<void> getDeviceType(double shortestSide) async {
    _isTablet = shortestSide >= 500.0;
    notifyListeners();
  }
  //
}
