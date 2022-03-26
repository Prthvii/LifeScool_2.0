import 'dart:async';
import 'dart:io';
/// latest date  == 26 -03 -22
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/CourseIntro.dart';
import 'package:lifescool/Screens/HomePage.dart';
import 'package:lifescool/Screens/PlayerScreen.dart';
import 'package:lifescool/Screens/TutorInfo/TutorInfo.dart';
import 'package:lifescool/Shorts/Data/addToCache.dart';
import 'package:lifescool/Shorts/Data/listReels.dart';
import 'package:lifescool/Shorts/share.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

import 'bookmark.dart';

class ShortsPlayerPage extends StatefulWidget {
  var highligts;

  ShortsPlayerPage({this.highligts});

  @override
  _ShortsPlayerPageState createState() => _ShortsPlayerPageState();
}

class _ShortsPlayerPageState extends State<ShortsPlayerPage> {
  VideoPlayerController controller0;
  VideoPlayerController controller1;
  VideoPlayerController controller2;
  VideoPlayerController controller3;
  VideoPlayerController controller4;
  VideoPlayerController controller5;
  VideoPlayerController controller6;
  VideoPlayerController controller7;
  VideoPlayerController controller8;
  VideoPlayerController controller9;

  var arrList = [];

  var isLoading = false;
  var isPlaying = true;
  var name;
  var nowPlaying = 0;
  var currentPage = 0;
  var author_img;
  var likeTap = false;
  var isMute = false;
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    controller0.pause();

    controller1.pause();
    controller2.pause();
    controller3.pause();
    controller4.pause();
    controller5.pause();
    controller6.pause();
    controller7.pause();
    controller8.pause();
    controller9.pause();

    controller0.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
    controller7.dispose();
    controller8.dispose();
    controller9.dispose();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    super.dispose();
  }

  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);

    this.getHome();
    super.initState();
  }

  Future<String> getHome() async {
    var rsp = await getFromCache();
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp != 0) {
      setState(() {
        arrList = rsp;
      });

      setupController(0);
    }

    // setState(() {
    //   isLoading = false;
    // });
    return "0";
  }

  HighlightController() async {
    controller0 =
        VideoPlayerController.network(widget.highligts['video_url'].toString());

    await controller0?.initialize();
    controller0?.setLooping(true);
    if (controller0.value.initialized) {
      setState(() {
        isLoading = false;
        print("falsaaaaaaaaayi");
        name = widget.highligts['title'].toString();
        author_img = widget.highligts['author_img'].toString();
        nowPlaying = 0;
      });
      controller0.play();
    }
  }


  ControllerIndex(index) async {
    controller0 =
        VideoPlayerController.file(File(arrList[0]['video_url'].toString()));

    await controller0?.initialize();
    controller0?.setLooping(true);
    if (controller0.value.initialized) {
      setState(() {
        isLoading = false;
        print("falsaaaaaaaaayi");
        name = arrList[0]['title'].toString();
        author_img = arrList[0]['author_img'].toString();
        nowPlaying = 0;
      });
      controller0.play();
    }
  }
  Controller0() async {
    controller0 =
        VideoPlayerController.file(File(arrList[0]['video_url'].toString()));

    await controller0?.initialize();
    controller0?.setLooping(true);
    if (controller0.value.initialized) {
      setState(() {
        isLoading = false;
        print("falsaaaaaaaaayi");
        name = arrList[0]['title'].toString();
        author_img = arrList[0]['author_img'].toString();
        nowPlaying = 0;
      });
      controller0.play();
    }
  }

  Controller1() async {
    controller1 =
        VideoPlayerController.network(arrList[1]['video_url'].toString());

    await controller1?.initialize();
    controller1?.setLooping(true);

    if (controller1.value.initialized) {
      setState(() {
        isLoading = false;
        print("falsaaaaaaaaayi");
        name = arrList[0]['title'].toString();
        author_img = arrList[0]['author_img'].toString();
        nowPlaying = 0;
      });
      controller0.play();
    }
  }

  Controller2() async {
    controller2 =
        VideoPlayerController.network(arrList[2]['video_url'].toString());

    await controller2?.initialize();
    controller2?.setLooping(true);
  }

  Controller3() async {
    controller3 =
        VideoPlayerController.network(arrList[3]['video_url'].toString());

    await controller3?.initialize();
    controller3?.setLooping(true);
  }

  Controller4() async {
    controller4 =
        VideoPlayerController.network(arrList[4]['video_url'].toString());

    await controller4?.initialize();
    controller4?.setLooping(true);
  }

  Controller5() async {
    controller5 =
        VideoPlayerController.network(arrList[5]['video_url'].toString());

    await controller5?.initialize();
    controller5?.setLooping(true);
  }

  Controller6() async {
    controller6 =
        VideoPlayerController.network(arrList[6]['video_url'].toString());

    await controller6?.initialize();
    controller6?.setLooping(true);
  }

  Controller7() async {
    controller7 =
        VideoPlayerController.network(arrList[7]['video_url'].toString());

    await controller7?.initialize();
    controller7?.setLooping(true);
  }

  Controller8() async {
    controller8 =
        VideoPlayerController.network(arrList[8]['video_url'].toString());

    await controller8?.initialize();
    controller8?.setLooping(true);
  }

  Controller9() async {
    controller9 =
        VideoPlayerController.network(arrList[9]['video_url'].toString());

    await controller9?.initialize();
    controller9?.setLooping(true);
  }

  Future<Null> setupController(index) async {
    if (arrList.length > 0) {
      if (widget.highligts == null) {
        Controller0();
      } else {
        HighlightController();
      }
    }
    if (arrList.length > 1) {
      Controller1();
    }

    if (arrList.length > 2) {
      Controller2();
    }

    if (arrList.length > 3) {
      Controller3();
    }

    if (arrList.length > 4) {
      Controller4();
    }

    if (arrList.length > 5) {
      Controller5();
    }

    //   setState(() {
    //     isLoading = false;
    //     print("falsaaaaaaaaayi");
    //     name = arrList[index]['title'].toString();
    //     author_img = arrList[index]['author_img'].toString();
    //     nowPlaying = index;
    //   });
    // controller0.play();
    if (arrList.length > 6) {
      Controller6();
    }

    if (arrList.length > 7) {
      Controller7();
    }

    if (arrList.length > 8) {
      Controller8();
    }

    if (arrList.length > 9) {
      Controller9();
    }
    print("bottom");

    // Timer(Duration(seconds: 3), () {
    //
    // });
  }

  Future<Null> playControllers(index) async {
    if (isMute == true) {
      muteAll(index);
    } else {
      unmuteAll(index);
    }
    print("plaaaaaay");
    print(index);
    setState(() {
      isLoading = false;
      isPlaying = true;
      name = arrList[index]['title'].toString();
      author_img = arrList[index]['author_img'].toString();
      nowPlaying = index;
    });
    switch (index) {
      case 0:
        {
          controller0.play();
          controller1.pause();
        }
        break;

      case 1:
        {
          controller0.pause();
          controller1.play();
          controller2.pause();

          print("111111111111");
        }
        break;

      case 2:
        {
          controller1.pause();
          controller2.play();
          controller3.pause();
        }
        break;

      case 3:
        {
          controller2.pause();
          controller3.play();
          controller4.pause();
        }
        break;

      case 4:
        {
          controller3.pause();
          controller4.play();
          controller3.pause();
        }
        break;

      case 5:
        {
          controller4.pause();
          controller5.play();
          controller6.pause();
        }
        break;

      case 6:
        {
          controller5.pause();
          controller6.play();
          controller7.pause();
        }
        break;
      case 7:
        {
          controller6.pause();
          controller7.play();
          controller8.pause();
        }
        break;

      case 8:
        {
          controller7.pause();
          controller8.play();
          controller9.pause();
        }
        break;
      case 9:
        {
          controller8.pause();
          controller9.play();
          controller0.pause();
        }
        break;

      default:
        {
          controller0.play();
        }
        break;
    }
  }

  Future<Null> pauseControllers(index) async {
    print("plaaaaaay");
    print(index);
    switch (index) {
      case 0:
        {
          controller0.pause();
        }
        break;

      case 1:
        {
          controller1.pause();
        }
        break;

      case 2:
        {
          controller2.pause();
        }
        break;

      case 3:
        {
          controller3.pause();
        }
        break;

      case 4:
        {
          controller4.pause();
        }
        break;

      case 5:
        {
          controller5.pause();
        }
        break;

      case 6:
        {
          controller6.pause();
        }
        break;
      case 7:
        {
          controller7.pause();
        }
        break;

      case 8:
        {
          controller8.pause();
        }
        break;
      case 9:
        {
          controller9.pause();
        }
        break;

      default:
        {
          controller0.pause();
        }
        break;
    }
  }

  Future<Null> resumeControllers(index) async {
    print("plaaaaaay");
    print(index);
    switch (index) {
      case 0:
        {
          controller0.play();
        }
        break;

      case 1:
        {
          controller1.play();
        }
        break;

      case 2:
        {
          controller2.play();
        }
        break;

      case 3:
        {
          controller3.play();
        }
        break;

      case 4:
        {
          controller4.play();
        }
        break;

      case 5:
        {
          controller5.play();
        }
        break;

      case 6:
        {
          controller6.play();
        }
        break;
      case 7:
        {
          controller7.play();
        }
        break;

      case 8:
        {
          controller8.play();
        }
        break;
      case 9:
        {
          controller9.play();
        }
        break;

      default:
        {
          controller0.play();
        }
        break;
    }
  }

  checkPlaying(var stat) {
    bool playing;

    if (stat == 0) {
      playing = controller0.value.isPlaying;
    }
    if (stat == 1) {
      playing = controller1.value.isPlaying;
    }
    if (stat == 2) {
      playing = controller2.value.isPlaying;
    }
    if (stat == 3) {
      playing = controller3.value.isPlaying;
    }
    if (stat == 4) {
      playing = controller4.value.isPlaying;
    }

    if (stat == 5) {
      playing = controller5.value.isPlaying;
    }

    if (stat == 6) {
      playing = controller6.value.isPlaying;
    }

    if (stat == 7) {
      playing = controller7.value.isPlaying;
    }

    if (stat == 8) {
      playing = controller8.value.isPlaying;
    }
    if (stat == 9) {
      playing = controller9.value.isPlaying;
    }
    return playing;
  }

  checkIntitializing(var stat) {
    bool playing;

    if (stat == 0) {
      playing = controller0.value.initialized;
    }
    if (stat == 1) {
      playing = controller1.value.initialized;
    }
    if (stat == 2) {
      playing = controller2.value.initialized;
    }
    if (stat == 3) {
      playing = controller3.value.initialized;
    }
    if (stat == 4) {
      playing = controller4.value.initialized;
    }

    if (stat == 5) {
      playing = controller5.value.initialized;
    }

    if (stat == 6) {
      playing = controller6.value.initialized;
    }

    if (stat == 7) {
      playing = controller7.value.initialized;
    }

    if (stat == 8) {
      playing = controller8.value.initialized;
    }
    if (stat == 9) {
      playing = controller9.value.initialized;
    }
    return playing;
  }

  Future<Null> muteAtIndex(index) async {
    switch (index) {
      case 0:
        {
          controller0.setVolume(0.0);
        }
        break;

      case 1:
        {
          controller1.setVolume(0.0);
        }
        break;

      case 2:
        {
          controller2.setVolume(0.0);
        }
        break;

      case 3:
        {
          controller3.setVolume(0.0);
        }
        break;

      case 4:
        {
          controller4.setVolume(0.0);
        }
        break;

      case 5:
        {
          controller5.setVolume(0.0);
        }
        break;

      case 6:
        {
          controller6.setVolume(0.0);
        }
        break;
      case 7:
        {
          controller7.setVolume(0.0);
        }
        break;

      case 8:
        {
          controller8.setVolume(0.0);
        }
        break;
      case 9:
        {
          controller9.setVolume(0.0);
        }
        break;

      default:
        {
          controller0.setVolume(0.0);
        }
        break;
    }
  }

  Future<Null> unmuteAtIndex(index) async {
    switch (index) {
      case 0:
        {
          controller0.setVolume(1.0);
        }
        break;

      case 1:
        {
          controller1.setVolume(1.0);
        }
        break;

      case 2:
        {
          controller2.setVolume(1.0);
        }
        break;

      case 3:
        {
          controller3.setVolume(1.0);
        }
        break;

      case 4:
        {
          controller4.setVolume(1.0);
        }
        break;

      case 5:
        {
          controller5.setVolume(1.0);
        }
        break;

      case 6:
        {
          controller6.setVolume(1.0);
        }
        break;
      case 7:
        {
          controller7.setVolume(1.0);
        }
        break;

      case 8:
        {
          controller8.setVolume(1.0);
        }
        break;
      case 9:
        {
          controller9.setVolume(1.0);
        }
        break;

      default:
        {
          controller0.setVolume(1.0);
        }
        break;
    }
  }

  Future<Null> muteAll(index) async {
    if (arrList.length > 0) {
      controller0.setVolume(0.0);
    }
    if (arrList.length > 1) {
      controller1.setVolume(0.0);
    }

    if (arrList.length > 2) {
      controller2.setVolume(0.0);
    }

    if (arrList.length > 3) {
      controller3.setVolume(0.0);
    }

    if (arrList.length > 4) {
      controller4.setVolume(0.0);
    }

    if (arrList.length > 5) {
      controller5.setVolume(0.0);
    }

    if (arrList.length > 6) {
      controller6.setVolume(0.0);
    }

    if (arrList.length > 7) {
      controller7.setVolume(0.0);
    }

    if (arrList.length > 8) {
      controller8.setVolume(0.0);
    }

    if (arrList.length > 9) {
      controller9.setVolume(0.0);
    }
  }

  Future<Null> unmuteAll(index) async {
    if (arrList.length > 0) {
      controller0.setVolume(1.0);
    }
    if (arrList.length > 1) {
      controller1.setVolume(1.0);
    }

    if (arrList.length > 2) {
      controller2.setVolume(1.0);
    }

    if (arrList.length > 3) {
      controller3.setVolume(1.0);
    }

    if (arrList.length > 4) {
      controller4.setVolume(1.0);
    }

    if (arrList.length > 5) {
      controller5.setVolume(1.0);
    }

    if (arrList.length > 6) {
      controller6.setVolume(1.0);
    }

    if (arrList.length > 7) {
      controller7.setVolume(1.0);
    }

    if (arrList.length > 8) {
      controller8.setVolume(1.0);
    }

    if (arrList.length > 9) {
      controller9.setVolume(1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.1),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: isLoading == true
          ? Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/images/loadingShorts.json",
                  height: 85, width: 144),
              Divider(
                color: Color(0xffB6B6B6),
                indent: 150,
                endIndent: 150,
              ),
              h(5),
              Text(
                "Good things, when short, \nare twice as good",
                textAlign: TextAlign.center,
                style: size14_400,
              )
            ],
          ),
        ),
      )
          : feedVideos(),
    );
  }

  takeFullCourseWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: GestureDetector(
        onTap: () {
          controller0.pause();
          var type = arrList[nowPlaying]['targetType'].toString();
          switch (type) {
            case "COURSE":
              {
                print("COURSE");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlayerScreen(
                        id: arrList[nowPlaying]['targetId'].toString(),
                        cuid: arrList[nowPlaying]['targetUid'].toString(),
                      )),
                );
              }
              break;

            case "WORKSHOP":
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CourseIntro(
                        id: arrList[nowPlaying]['targetId'].toString(),
                      )),
                );
              }
              break;

            case "LIVEBATCH":
              {
                showToastSuccess("Live Batch");
              }
              break;

            case "JWT":
              {
                showToastSuccess("Join Meeting");
              }
              break;

            default:
              {
                print("Invalid choice");
              }
              break;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayerScreen(
                  id: arrList[nowPlaying][''].toString(),
                  cuid: arrList[nowPlaying][''].toString(),
                )),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff606060)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Text(
                    arrList[nowPlaying]['targetBtnName'] != null
                        ? arrList[nowPlaying]['targetBtnName'].toString()
                        : "",
                    style: size14_600W),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget feedVideos() {
    print("feeeeeeeeed");

    return Stack(
      children: [
        PageView.builder(
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
          ),
          itemCount: arrList != null ? arrList.length : 0,
          onPageChanged: (index) {
            // index = (feedViewModel.videoSource.listVideos.length) % index;
            //  feedViewModel.changeVideo(index);

            // controller.pause();
            // if(index==1){
            //   controller.pause();
            //   controller1.play();
            // }
            //
            // if(index==2){
            //   controller1.pause();
            //   controller2.play();
            // }
            // loadController(index);
            playControllers(index);
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final item = arrList != null ? arrList[index] : null;
            //  index = (feedViewModel.videoSource.listVideos.length) % index;
            return videoCard(item, index);
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
            height: 120,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () {
                        if (isMute == true) {
                          unmuteAtIndex(nowPlaying);
                          unmuteAll(nowPlaying);

                          setState(() {
                            isMute = false;
                          });
                        } else {
                          muteAtIndex(nowPlaying);
                          muteAll(nowPlaying);

                          setState(() {
                            isMute = true;
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Spacer(),
                          isMute == true
                              ? Icon(Icons.volume_off_outlined,
                              color: Colors.white, size: 25)
                              : Icon(Icons.volume_up_rounded,
                              color: Colors.white, size: 25)
                        ],
                      ),
                    ),
                  ),
                  h(16),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      children: [Spacer(), bookmarkIcon()],
                    ),
                  ),
                  h(16),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      children: [Spacer(), shareIcon()],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Spacer(),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (arrList[nowPlaying]['isLiked'] == true) {
                                  setState(() {
                                    arrList[nowPlaying]['isLiked'] = false;
                                  });
                                } else {
                                  setState(() {
                                    arrList[nowPlaying]['isLiked'] = true;
                                  });
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.favorite,
                                  color: arrList[nowPlaying]['isLiked'] == true
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                radius: 20,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              arrList[nowPlaying]['isLiked'] == true
                                  ? (int.parse(arrList[nowPlaying]['like']) + 1)
                                  .toString()
                                  : arrList[nowPlaying]['like'].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            name == null ? "" : name,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Mallu',
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              controller0.pause();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TutorInfo(
                                        id: arrList[nowPlaying]['author_id']
                                            .toString())),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(arrList[nowPlaying]
                                      ['author_img']
                                          .toString()),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  arrList[nowPlaying]['targetType'].toString() == "OFF"
                      ? Container()
                      : takeFullCourseWidget()
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Opacity(
              opacity: 0.25,
              child: Container(
                decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                height: 48,
                width: 48,
              ),
            ),
          ),
        ),
        isPlaying == true
            ? Align(
          alignment: Alignment.center,
          child: Container(),
        )
            : Align(
          alignment: Alignment.center,
          //  child: Icon(Icons.play_arrow, color: Colors.white, size: 30),
          child: Image.asset(
            "assets/images/pauseReels.png",
            height: 40,
          ),
        )
      ],
    );
  }

  Widget videoCard(var item, int index) {
    print("vdoooolength");

    print(index);
    print("vdoooolength");

    return Stack(
      children: [
        // checkIntitializing(index)==true
        //     ?

        GestureDetector(
          onTap: () {
            if (checkPlaying(index) == true) {
              pauseControllers(index);
              setState(() {
                isPlaying = false;
              });
            } else {
              resumeControllers(index);
              setState(() {
                isPlaying = true;
              });
            }
            // if (controller0.value.isPlaying) {
            //   controller0?.pause();
            // } else {
            //   controller0?.play();
            // }
          },
          onDoubleTap: () {
            setState(() {
              arrList[index]['isLiked'] = true;
            });
          },
          child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: index == 1
                      ? controller1.value.size.width ?? 0
                      : index == 2
                      ? controller2.value.size.width ?? 0
                      : index == 3
                      ? controller3.value.size.width ?? 0
                      : index == 4
                      ? controller4.value.size.width ?? 0
                      : index == 5
                      ? controller5.value.size.width ?? 0
                      : index == 6
                      ? controller6.value.size.width ?? 0
                      : index == 7
                      ? controller7.value.size.width ?? 0
                      : index == 8
                      ? controller8.value.size.width ??
                      0
                      : index == 9
                      ? controller9
                      .value.size.width ??
                      0
                      : controller0
                      .value.size.width ??
                      0,
                  height: index == 1
                      ? controller1.value.size.height ?? 0
                      : index == 2
                      ? controller2.value.size.height ?? 0
                      : index == 3
                      ? controller3.value.size.height ?? 0
                      : index == 4
                      ? controller4.value.size.height ?? 0
                      : index == 5
                      ? controller5.value.size.height ?? 0
                      : index == 6
                      ? controller6.value.size.height ?? 0
                      : index == 7
                      ? controller7.value.size.height ?? 0
                      : index == 8
                      ? controller8.value.size.height ??
                      0
                      : index == 9
                      ? controller9
                      .value.size.height ??
                      0
                      : controller0
                      .value.size.height ??
                      0,
                  // width: MediaQuery. of(context). size. width ,
                  //   height: MediaQuery. of(context). size. height,
                  child: VideoPlayer(index == 1
                      ? controller1
                      : index == 2
                      ? controller2
                      : index == 3
                      ? controller3
                      : index == 4
                      ? controller4
                      : index == 5
                      ? controller5
                      : index == 6
                      ? controller6
                      : index == 7
                      ? controller7
                      : index == 8
                      ? controller8
                      : index == 9
                      ? controller9
                      : controller0),
                ),
              )),
        )

        //     :Container(
        //   color: Colors.black,
        //   child: Center(
        //     child: Image.asset(
        //       "assets/images/loading.gif",
        //       height: 40,
        //     ),
        //   ),
        // )
        ,

        // video.controller != null
        //     ? GestureDetector(
        //         onTap: () {
        //           if (video.controller.value.isPlaying) {
        //             video.controller?.pause();
        //           } else {
        //             video.controller?.play();
        //           }
        //         },
        //         child: SizedBox.expand(
        //             child: FittedBox(
        //           fit: BoxFit.cover,
        //           child: SizedBox(
        //             width: video.controller?.value.size.width ?? 0,
        //             height: video.controller?.value.size.height ?? 0,
        //             child: VideoPlayer(video.controller),
        //           ),
        //         )),
        //       )
        //     : Container(
        //         color: Colors.white,
        //         child: Center(
        //           child: Text("Loading"),
        //         ),
        //       ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // VideoDescription(video.user, video.videoTitle, video.songName),
                // ActionsToolbar(video.likes, video.comments,
                //     "https://www.andersonsobelcosmetic.com/wp-content/uploads/2018/09/chin-implant-vs-fillers-best-for-improving-profile-bellevue-washington-chin-surgery.jpg"
                // ),
              ],
            ),
            SizedBox(height: 20)
          ],
        ),
      ],
    );
  }
}