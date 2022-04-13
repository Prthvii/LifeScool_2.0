import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Shorts/Data/addToCache.dart';
import 'package:lifescool/Shorts/Data/listReels.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

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


  Future<String> getReels() async {
    var arrReels = [];
    var rsp = await reelsListApi("1");
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp != 0) {
      setState(() {
        arrReels = rsp['attributes']['shortslist'];
      });





    var clr = await  clearSharedPrefrence();
      var lst = await setSharedPrefrence(TOTALREELS,rsp['attributes']['totalIndexes'].toString());
    /// arrReels[i]['video_url']
    for (var i = 0; i < arrReels.length; i++) {
if(arrReels[i]['video_url_mp4_low']!=null&&arrReels[i]['thumbnail_url']!=null){
  var file = await DefaultCacheManager().getSingleFile(arrReels[i]['video_url_mp4_low']);
 var image = await DefaultCacheManager().getSingleFile(arrReels[i]['thumbnail_url']);

  print("fileee");
  print(file);
  var add = addCache(arrReels[i]['id'],arrReels[i]['uid'],arrReels[i]['title'],arrReels[i]['desc'],arrReels[i]['like'],arrReels[i]['targetType'],arrReels[i]['targetId'],arrReels[i]['targetUid'],arrReels[i]['targetBtnName'],arrReels[i]['targetJtwContent'],arrReels[i]['video_source'],file.path,arrReels[i]['author_id'],arrReels[i]['author_img'],image.path,arrReels[i]['videoDuration'],arrReels[i]['isLiked'], rsp['attributes']['page'].toString(),false);
}

    }
    // setState(() {
    //   isLoading = false;
    // });
    return "0";
  }
  }
  _loadWidget() async {
    var token = await getSharedPrefrence(TOKEN);

    if(token!=null){
        var reels = await   getReels();
    }
    print("tokennnn");
    print(token);
    return Timer(
        Duration(seconds: 1), token != null ? navigationHome : navigationLogin);
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
