import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';
import 'main_flow.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';

class AppController extends StatefulWidget {
  @override
  _AppControllerState createState() => _AppControllerState();
}

class _AppControllerState extends State<AppController> {
  final Map<String, Widget> routes = {
    "/": SplashScreen(),
    "/login": LoginScreen(),
    "/main_flow": MainFlow(),
    "/home": HomeScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: "/",
        onGenerateRoute: (RouteSettings settings) {
          Route screen;
          switch (settings.name) {
            default:
              {
                screen = MaterialPageRoute(
                  settings: settings,
                  builder: (BuildContext context) {
                    return routes[settings.name];
                  },
                );
                break;
              }
          }
          return screen;
        });
  }
}
