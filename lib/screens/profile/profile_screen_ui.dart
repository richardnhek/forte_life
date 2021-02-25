import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreenUI extends StatelessWidget {
  ProfileScreenUI({this.onLogOut});
  final Function onLogOut;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Stack(alignment: Alignment.topCenter, children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage(
                              "assets/pictures/android/logo/logo.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                      height: 50,
                      width: 250,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 125),
                    width: double.infinity,
                    height: mq.size.height / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.5),
                        color: Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.16),
                              blurRadius: 15,
                              spreadRadius: 1,
                              offset: Offset(3, 6)),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: "Kano"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 85),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.16),
                              blurRadius: 10,
                              offset: Offset(3, 6),
                              spreadRadius: 1.5)
                        ]),
                    child: CircleAvatar(
                      maxRadius: 40,
                      minRadius: 35,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.white,
                      child: Image(
                        alignment: Alignment.bottomCenter,
                        image: AssetImage("assets/icons/agent.png"),
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
