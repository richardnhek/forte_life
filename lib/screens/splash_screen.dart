import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forte_life/providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  CurvedAnimation curveAnimation;
  final splashDelay = 8;

  @override
  void initState() {
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
    super.initState();
  }

  Future<void> determineInitialRoute() async {
    Navigator.pushNamed(context, "/login");
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
