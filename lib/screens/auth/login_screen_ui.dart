import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forte_life/utils/device_utils.dart';
import 'package:forte_life/widgets/username_field.dart';
import 'package:provider/provider.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:forte_life/widgets/password_field.dart';

class LoginScreenUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    final mq = MediaQuery.of(context);
    TextEditingController usrName = TextEditingController();
    TextEditingController passWrd = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: DeviceUtils.getResponsive(
                  appProvider: appProvider,
                  mq: mq,
                  onPhone: mq.size.height / 4,
                  onTablet: mq.size.height / 4),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/pictures/android/gradient1.png"),
                      fit: BoxFit.fill)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: DeviceUtils.getResponsive(
                    appProvider: appProvider,
                    mq: mq,
                    onPhone: mq.size.width / 8,
                    onTablet: mq.size.width / 8),
                right: DeviceUtils.getResponsive(
                    appProvider: appProvider,
                    mq: mq,
                    onPhone: mq.size.width / 8,
                    onTablet: mq.size.width / 8),
                bottom: DeviceUtils.getResponsive(
                    appProvider: appProvider,
                    mq: mq,
                    onPhone: 0.0,
                    onTablet: 0.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 300,
                  height: 52,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/pictures/android/logo/logo.png"),
                          fit: BoxFit.contain)),
                ),
                SizedBox(
                  height: DeviceUtils.getResponsive(
                      appProvider: appProvider,
                      mq: mq,
                      onPhone: 50.0,
                      onTablet: 50.0),
                ),
                UserNameField(
                  hintText: "Username",
                  tec: usrName,
                ),
                SizedBox(
                  height: 16,
                ),
                PasswordField(
                  hintText: "Password",
                  tec: passWrd,
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFF6ABFBC), Color(0xFF8AB84B)])),
                  child: FlatButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () => {
                      {Navigator.pushNamed(context, "/main_flow")}
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Kano",
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: DeviceUtils.getResponsive(
                  appProvider: appProvider,
                  mq: mq,
                  onPhone: mq.size.height / 4,
                  onTablet: mq.size.height / 4),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/pictures/android/gradient2.png"),
                      fit: BoxFit.fill)),
            ),
          ),
        ],
      ),
    );
  }
}
