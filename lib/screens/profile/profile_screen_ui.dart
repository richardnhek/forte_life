import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:forte_life/utils/device_utils.dart';
import 'package:provider/provider.dart';

class ProfileScreenUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final mq = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.topCenter, children: [
            Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                image: new DecorationImage(
                  image:
                      new AssetImage("assets/pictures/android/logo/logo.png"),
                  fit: BoxFit.contain,
                ),
              ),
              height: DeviceUtils.getResponsive(
                  appProvider: appProvider,
                  mq: mq,
                  onPhone: mq.size.height / 3.5,
                  onTablet: mq.size.height / 3.5),
              width: double.infinity,
              child: Text(""),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: DeviceUtils.getResponsive(
                      appProvider: appProvider,
                      mq: mq,
                      onPhone: mq.size.height / 5,
                      onTablet: mq.size.height / 5),
                  left: 25,
                  right: 25),
              child: Container(
                width: DeviceUtils.getResponsive(
                    appProvider: appProvider,
                    mq: mq,
                    onPhone: mq.size.width,
                    onTablet: mq.size.width),
                height: DeviceUtils.getResponsive(
                    appProvider: appProvider,
                    mq: mq,
                    onPhone: mq.size.height / 1.5,
                    onTablet: mq.size.height / 1.5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.16),
                          spreadRadius: 5,
                          offset: Offset(5, 5),
                          blurRadius: 10)
                    ]),
                child: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.edit,
                              color: Color(0xFF8AB84B),
                              size: 36,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Agent Test",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Kano"),
                      ),
                      SizedBox(
                        height: 2.5,
                      ),
                      Text(
                        "+855 20201016",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8B8B8B),
                            fontFamily: "Kano"),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Color(0xFFF4F5F6),
                        thickness: 1.5,
                      ),
                      // Text("Language"),
                      // Text("Contact & Support"),
                      // FlatButton(
                      //     onPressed: () {
                      //       print("Log Out");
                      //     },
                      //     child: Container(
                      //         padding: EdgeInsets.all(10),
                      //         decoration: BoxDecoration(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(10)),
                      //             border: Border.all(color: Color(0xFF8AB84B))),
                      //         child: Text("Log Out")))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: DeviceUtils.getResponsive(
                      appProvider: appProvider,
                      mq: mq,
                      onPhone: mq.size.height / 8,
                      onTablet: mq.size.height / 8)),
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Color(0xFF8AB84B),
                child: CircleAvatar(
                  radius: 44.5,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
