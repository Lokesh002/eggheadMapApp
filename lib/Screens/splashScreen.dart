import 'package:egghead_practical/Screens/Login.dart';
import 'package:egghead_practical/backend/sharedPref.dart';
import 'package:egghead_practical/backend/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';

import 'mapScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SavedData savedData = SavedData();
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      getdata();
    });
  }

  getdata() async {
    print("hello");
    var x = await savedData.getLoggedIn();
    print(x);
    if (x) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MapScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  DateTime currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Container(
            width: screenSize.screenWidth * 50,
            height: screenSize.screenHeight * 50,
            child: Image.asset(
              "images/logo.png",
              fit: BoxFit.contain,
            ),
          ),
        ));
  }
}
