import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forte_life/constants/constants.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:forte_life/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  CurvedAnimation curveAnimation;
  SharedPreferences prefs;
  AppProvider appProvider;
  final splashDelay = 8;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1600),
    );

    curveAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.1, 0.5, curve: Curves.linear),
    );

    animation = Tween(
      begin: 0.0001,
      end: 1.0,
    ).animate(curveAnimation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.stop();
        animationController.reverse();
      }
    });

    animationController.forward();
    runAppInitialization();
  }

  Future<void> determineInitialRoute() async {
    Navigator.pushNamed(context, "/login");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String accessToken = prefs.getString(APP_ACCESS_TOKEN) ?? '';

    if (accessToken.isEmpty) {
      Navigator.of(context).pushReplacementNamed("/login");
    } else {
      print(accessToken);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      try {
        await authProvider.getCurrentUser(token: accessToken);
        print("what's wrong");
        Navigator.of(context).pushReplacementNamed('/main_flow');
      } on DioError catch (error) {
        print('error $error');
      }
    }
  }

  Future<void> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load(path);

    final file = new File(
        "/storage/emulated/0/Android/data/com.reahu.forte_life/files/logo.png");
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }

  Future<void> getFontFileFromAssets() async {
    final data =
        await rootBundle.load("assets/fonts/LiberationSans-Regular.ttf");
    final dataBold =
        await rootBundle.load("assets/fonts/LiberationSans-Bold.ttf");
    final font = new File(
        "/storage/emulated/0/Android/data/com.reahu.forte_life/files/LiberationSans-Regular.ttf");
    final fontBold = new File(
        "/storage/emulated/0/Android/data/com.reahu.forte_life/files/LiberationSans-Bold.ttf");
    await font.writeAsBytes(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    await fontBold.writeAsBytes(dataBold.buffer
        .asUint8List(dataBold.offsetInBytes, dataBold.lengthInBytes));
  }

  Future<void> createPDFDir() async {
    final protectFolder = "protect";
    final educationFolder = "education";

    final pathProtect = Directory(
        "/storage/emulated/0/Android/data/com.reahu.forte_life/files/$protectFolder");
    final pathEducation = Directory(
        "/storage/emulated/0/Android/data/com.reahu.forte_life/files/$educationFolder");
    if (await pathProtect.exists()) {
      print("Protect Folder Already Created");
    } else
      pathProtect.create();
    if (await pathEducation.exists()) {
      print("Education Folder Already Created");
    } else
      pathEducation.create();
  }

  void runAppInitialization() async {
    AppProvider appProvider = Provider.of(context, listen: false);
    appProvider.setAppOrientation();
    await Future.delayed(const Duration(milliseconds: 4600));
    await appProvider.requestPermissions();
    await getExternalStorageDirectory();
    await getImageFileFromAssets("assets/pictures/android/logo/logo.png");
    await createPDFDir();
    await getFontFileFromAssets();
    await determineInitialRoute();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: animation,
          child: Image.asset(
            "assets/pictures/android/logo/logo.png",
            width: 400,
            height: 400,
          ),
        ),
      ),
    );
  }
}
