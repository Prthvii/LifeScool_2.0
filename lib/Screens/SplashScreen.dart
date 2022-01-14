import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lottie/lottie.dart';

import 'HomePage.dart';
import 'InitialScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    this._loadWidget();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Center(
              child: Lottie.asset(
                "assets/images/splash.json",
                height: 160,
                repeat: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/images/beta.png",
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Center(
                    child: Image.asset(
                      "assets/images/loading.gif",
                      height: 40,
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  _loadWidget() async {
    var token = await getSharedPrefrence(TOKEN);
    print("tokennnn");
    print(token);
    return Timer(
        Duration(seconds: 4), token != null ? navigationHome : navigationLogin);
  }

  void navigationHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void navigationLogin() {
    print("login");
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => InitialScreen()));
  }
}
