import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forte_life/utils/device_utils.dart';
import 'package:forte_life/widgets/username_field.dart';
import 'package:provider/provider.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:forte_life/widgets/password_field.dart';

class LoginScreenUI extends StatelessWidget {
  LoginScreenUI(
      {this.usernameController,
      this.passwordController,
      this.onSignInPress,
      this.scaffoldKey});

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final Function onSignInPress;
  final scaffoldKey;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    final mq = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: mq.size.height / 4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/pictures/android/gradient1.png"),
                      fit: BoxFit.fill)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.size.width / 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/pictures/android/logo/logo.png"),
                            fit: BoxFit.contain)),
                  ),
                  constraints: BoxConstraints(maxWidth: 300, maxHeight: 52),
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
                  tec: usernameController,
                ),
                SizedBox(
                  height: 16,
                ),
                PasswordField(
                  hintText: "Password",
                  tec: passwordController,
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
                    onPressed: () => onSignInPress(context),
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
              height: mq.size.height / 4,
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
