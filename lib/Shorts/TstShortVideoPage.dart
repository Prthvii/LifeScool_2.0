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
import 'package:video_player/video_player.dart';

import 'bookmark.dart';

class TstShortsPlayerPage extends StatefulWidget {
  const TstShortsPlayerPage({Key key}) : super(key: key);

  @override
  _ShortsPlayerPageState createState() => _ShortsPlayerPageState();
}

class _ShortsPlayerPageState extends State<TstShortsPlayerPage> {
  VideoPlayerController controller;

  var arrList = [
    {
      'id': "11",
      'uid': ' e0dc2b79-6ce3-4b1f-ab9a-ecdd9f766451',
      'title': 'How to remove background of an image?',
      'desc': 'hh.',
      'like': '100',
      'targetType': 'OFF',
      'targetId': '0',
      'targetUid': '0',
      'targetBtnName': '',
      'targetJtwContent': 'Joined',
      'video_source': 'CUSTOMVIMEO',
      'video_url':
          ' https://player.vimeo.com/external/668160046.m3u8?s=2618ae937188da781165f55faa3bf741ef81292e&oauth2_token_id=1526368676',
      'author_id': ' 6a92d86f-3ce6-4d05-ba28-8ce95f0758a0',
      'author_img':
          'https://lifescool.app/lp/imgserver/uploads/attachments/pcm__7e4cc96d-af85-4612-95d8-a266d130413e_0.png',
      'thumbnail_url':
          'https://i.vimeocdn.com/video/1352838869-dae710fd749a00fb0c37cfcbc08f4164a69eb2269f6819e4e4108c5d53d4fe57-d_960x540?r=pad',
      'videoDuration': '1',
      'isLiked': false
    }
  ];
  var isLoading = true;
  var name;
  var nowPlaying = 0;
  var currentPlaying = 0;
  var author_img;
  var likeTap = false;
  var isMute = false;

  int index = 0;
  double _position = 0;
  double _buffer = 0;
  bool _lock = true;
  bool _unlock = true;
  Map<String, VideoPlayerController> _controllers = {};
  Map<int, VoidCallback> _listeners = {};
  Set<String> _urls = {
    "https://player.vimeo.com/external/668160046.m3u8?s=2618ae937188da781165f55faa3bf741ef81292e&oauth2_token_id=1526368676",
    "https://player.vimeo.com/external/668160876.m3u8?s=2837e0e42f31dae5213223e4c2418b10588e920e&oauth2_token_id=1526368676",
    "https://firebasestorage.googleapis.com/v0/b/videostreaming-test.appspot.com/o/vid%2FSnaptik_6745671851688692998_tiktok.mp4?alt=media&token=e6c76be2-9d8e-4be6-aedc-89ddd4985871",

    "https://firebasestorage.googleapis.com/v0/b/videostreaming-test.appspot.com/o/vid%2FSnaptik_6842407707551599878_carlos-barrios%20(1).mp4?alt=media&token=965f5080-2771-4477-bd9d-defc7b581c5d",

    // "https://firebasestorage.googleapis.com/v0/b/videostreaming-test.appspot.com/o/vid%2FSnaptik_6856769842385620229_alex.mp4?alt=media&token=b70d853b-760a-45ee-b5d3-44cef7e4db7f",

    "https://player.vimeo.com/external/668161382.m3u8?s=b94fd0c7c643711d26848b242381cec975d09198&oauth2_token_id=1526368676",
    "https://player.vimeo.com/external/668162628.m3u8?s=137eb5c6088b73ac2773d1970493ee09dc3f06cb&oauth2_token_id=1526368676",
  };
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // controller.pause();
    _stopController(index);
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
    super.dispose();
  }

  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);

    // this.getHome();
    super.initState();

    if (_urls.length > 0) {
      _initController(0).then((_) {
        _playController(0);
      });
    }

    if (_urls.length > 1) {
      _initController(1).whenComplete(() => _lock = false);
    }

    //
    //
    // if (_urls.length > 3) {
    //   _initController(3).whenComplete(() => _lock = false);
    // }
    // if (_urls.length > 4) {
    //   _initController(4).whenComplete(() => _lock = false);
    // }
    setState(() {
      isLoading = false;
      name = "demoo";
      author_img = "fff";
      nowPlaying = index;
    });
  }

  Future<String> getHome() async {
    var rsp = await reelsListApi();
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp != 0) {
      setState(() {
        arrList = rsp['attributes']['shortslist'];
      });
      print("arrList");
      print(arrList);
      loadController(0);
    }

    // setState(() {
    //   isLoading = false;
    // });
    return "0";
  }

  Future<Null> loadController(index) async {
    print(arrList[index]['video_url']);

    controller =
        VideoPlayerController.network(arrList[index]['video_url'].toString());

    await controller?.initialize();
    controller?.setLooping(true);
    controller.play();

    if (isMute == true) {
      controller.setVolume(1.0);
      setState(() {
        isMute = false;
      });
    } else {
      controller.setVolume(0.0);
      setState(() {
        isMute = true;
      });
    }
    setState(() {
      isLoading = false;
      name = arrList[index]['title'].toString();
      author_img = arrList[index]['author_img'].toString();
      nowPlaying = index;
    });
  }

  ///newww
  VoidCallback _listenerSpawner(index) {
    return () {
      int dur = _controller(index).value.duration.inMilliseconds;
      int pos = _controller(index).value.position.inMilliseconds;
      int posi = _controller(index).value.position.inSeconds;
      int buf = _controller(index).value.buffered.last.end.inMilliseconds;

      setState(() {
        print("possssss");
        print(posi);
        //
        // if(posi==1){
        //   _nextVideo();
        // }
        if (dur <= pos) {
          _position = 0;
          return;
        }
        _position = pos / dur;
        _buffer = buf / dur;
      });
      if (dur - pos < 1) {
        if (index < _urls.length - 1) {
          //  _nextVideo();
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
    setState(() {
      currentPlaying = index;
    });
  }

  void _previousVideo() {
    _stopController(index);
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
    _stopController(index);

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
      // _initController(index + 2).whenComplete(() => _lock = false);
      // _initController(index + 2).whenComplete(() => _lock = false);

    }
  }

  void _checkController(int index) async {
    print("intializeed  + " + index.toString());

    print(_controller(index + 1).value.initialized);
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
              color: Colors.black,
              child: Center(
                child: Image.asset(
                  "assets/images/loading.gif",
                  height: 40,
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
          controller.pause();
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
          // physics: _lock==true?NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics(),
          itemCount: _urls != null ? _urls.length : 0,

          onPageChanged: (indexx) {
            // index = (feedViewModel.videoSource.listVideos.length) % index;
            //  feedViewModel.changeVideo(index);

            if (indexx < index) {
              //   _stopController(currentPlaying);
              setState(() {
                // _controller(indexx+1).pause();
              });
              _previousVideo();
              print("peviosss");
              print(indexx);

              _checkController(index);
            } else {
              //  _stopController(currentPlaying);

              setState(() {
                // _controller(indexx-1).pause();
              });
              _nextVideo();

              print("nexxxt");
              print(indexx);
              _checkController(index);
            }

            // controller.pause();
            //
            // loadController(index);
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            // final item = _urls != null ? arrList[index] : null;
            //  index = (feedViewModel.videoSource.listVideos.length) % index;
            return videoCard(index);
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
                          controller.setVolume(1.0);
                          setState(() {
                            isMute = false;
                          });
                        } else {
                          controller.setVolume(0.0);
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
                              controller.pause();
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
            child: Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black12),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              height: 48,
              width: 48,
            ),
          ),
        ),
      ],
    );
  }

  Widget videoCard(int index) {
    print("vdoooolength");

    // print(controller.value.duration);

    //print(controller.value.size.width);
    print("vdoooolength");

    return Stack(
      children: [
        // _lock==false ?
        GestureDetector(
          onTap: () {
            if (controller.value.isPlaying) {
              controller?.pause();
            } else {
              controller?.play();
            }
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
        //       "assets/images/tiktokloading.gif",
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
