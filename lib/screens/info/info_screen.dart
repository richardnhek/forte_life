import 'package:flutter/material.dart';
import 'package:forte_life/widgets/bullet_point.dart';
import 'package:forte_life/widgets/field_title.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return SafeArea(
      child: SingleChildScrollView(
          child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 20, vertical: mq.size.height / 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: mq.size.height / 36),
              child: FieldTitle(
                fieldTitle: "For Life Proposed",
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF8AB84B)),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  BulletPoint(
                    bulletTitle: "The policy years range from 10 to 35 years",
                  ),
                  BulletPoint(
                    bulletTitle:
                        "The plan is valid for people of age 1 to 59 years old",
                  ),
                  BulletPoint(
                    bulletTitle:
                        "The plan is limited to people under age 69 years old",
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
