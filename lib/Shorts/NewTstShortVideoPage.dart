import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/CourseIntro.dart';
import 'package:lifescool/Screens/HomePage.dart';
import 'package:lifescool/Screens/PlayerScreen.dart';
import 'package:lifescool/Screens/TutorInfo/TutorInfo.dart';
import 'package:lifescool/Shorts/Data/listReels.dart';
import 'package:lifescool/Shorts/share.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

import 'bookmark.dart';

class NewTstShortsPlayerPage extends StatefulWidget {
  var highligts;

  NewTstShortsPlayerPage({this.highligts});

  @override
  _ShortsPlayerPageState createState() => _ShortsPlayerPageState();
}

class _ShortsPlayerPageState extends State<NewTstShortsPlayerPage> {

  var arrList=[];
  var isLoading =true;
  var isMute =false;
  var isPlaying =false;
 var currentIndex =0;


  int index = 0;
  double _position = 0;
  double _buffer = 0;
  bool _lock = true;
  Map<String, VideoPlayerController> _controllers = {};
  Map<int, VoidCallback> _listeners = {};
  // Set<String> _urls ={
  // "https://player.vimeo.com/external/680745807.m3u8?s=fc2e549cbc2d98831fa0cca1ffda168d849d1c41&oauth2_token_id=1526368676",
  // "https://player.vimeo.com/external/680746373.m3u8?s=996c4c50ab72ba2aff434d5311e238995fb533ea&oauth2_token_id=1526368676",
  // "https://player.vimeo.com/external/680748430.m3u8?s=ae5b41cf276e5a6f7a0dedc91e152f13a6f5b41e&oauth2_token_id=1526368676",
  // "https://player.vimeo.com/external/680749047.m3u8?s=8a5e28eddaf7061b56f9821f41db161aea5c3b03&oauth2_token_id=1526368676",
  // "https://player.vimeo.com/external/680792261.m3u8?s=dcde5a6ae7c9df38959ebcdb330e567ccb652cf9&oauth2_token_id=1526368676",};
  Set<String> _urls ={};

  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);

    this.getHome();
    super.initState();


    super.initState();



    // _urls.add("https://player.vimeo.com/external/680745454.m3u8?s=9a45d5d07bee30c1a7184a2c8fd60c69e0c57b3d&oauth2_token_id=1526368676");


    // if (_urls.length > 0) {
    //   _initController(0).then((_) {
    //     _playController(0);
    //   });
    // }
    //
    // if (_urls.length > 1) {
    //   _initController(1).whenComplete(() => _lock = false);
    // }

    // setState(() {
    //   isLoading=false;
    // });
  }

  Future<String> getHome() async {
    var rsp = await reelsListApi("1");
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp != 0) {
      setState(() {
        arrList = rsp['attributes']['shortslist'];
      });
      for (var i = 0; i < arrList.length; i++) {

        var url =arrList[i]['video_url'].toString();
        _urls.add(url);
      }


    }


    if (_urls.length > 0) {
      _initController(0).then((_) {
        _playController(0);
      });
    }

    if (_urls.length > 1) {
      _initController(1).whenComplete(() => _lock = false);
    }
    setState(() {
      isLoading = false;
    });
    return "0";
  }

  @override
  void dispose() {
    _stopController( index);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    super.dispose();
  }

  VoidCallback _listenerSpawner(index) {
    return () {
      int dur = _controller(index).value.duration.inMilliseconds;
      int pos = _controller(index).value.position.inMilliseconds;
      int buf = _controller(index).value.buffered.last.end.inMilliseconds;

      setState(() {
        if (dur <= pos) {
          _position = 0;
          return;
        }
        _position = pos / dur;
        _buffer = buf / dur;
      });
      if (dur - pos < 1) {
        if (index < _urls.length - 1) {
          _nextVideo();
        }
      }
    };
  }

  VideoPlayerController _controller(int index) {
    return _controllers[_urls.elementAt(index)];
  }

  Future<void> _initController(int index) async {
    var controller = VideoPlayerController.network(_urls.elementAt(index));

    _controllers[_urls.elementAt(index)] = controller;
    await controller.initialize();
  }

  void _removeController(int index) {
    _controller(index).dispose();
    _controllers.remove(_urls.elementAt(index));
    _listeners.remove(index);
  }

  void _stopController(int index) {
    _controller(index).removeListener(_listeners[index]);
    _controller(index).pause();
    _controller(index).seekTo(Duration(milliseconds: 0));
  }

  void _playController(int index) async {
    if (!_listeners.keys.contains(index)) {
      _listeners[index] = _listenerSpawner(index);
    }
    _controller(index).addListener(_listeners[index]);
    await _controller(index).play();
    setState(() {});
  }

  void _previousVideo() {
    if (_lock || index == 0) {
      return;
    }
    _lock = true;

    _stopController(index);

    if (index + 1 < _urls.length) {
      _removeController(index + 1);
    }

    _playController(--index);

    if (index == 0) {
      _lock = false;
    } else {
      _initController(index - 1).whenComplete(() => _lock = false);
    }
  }

  void _nextVideo() async {


    if (_lock || index == _urls.length - 1) {
      return;
    }
    _lock = true;

    _stopController(index);

    if (index - 1 >= 0) {
      _removeController(index - 1);
    }

    _playController(++index);

    if (index == _urls.length - 1) {
      _lock = false;
    } else {
      _initController(index + 1).whenComplete(() => _lock = false);
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
                    "Demo",
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
        //  physics: _lock==true?NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics(),
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
            if(index>currentIndex){
              _nextVideo();
            }else{

              _playController(currentIndex-1);
            //  _previousVideo();
            }
            setState(() {
              currentIndex=index;
            });




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

                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.favorite,
                                  color: isMute == true
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
                             "1",
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
                            "Demo",
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

                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => TutorInfo(
                              //           id: arrList[nowPlaying]['author_id']
                              //               .toString())),
                              // );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(testImg),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                   takeFullCourseWidget()
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
        isPlaying == false
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
          child: Center(
            child: AspectRatio(
              aspectRatio: _controller(index).value.aspectRatio,
              child: Center(child: VideoPlayer(_controller(index))),
            ),
          ),
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
