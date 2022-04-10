import 'dart:async';
import 'dart:io';

/// latest date  == 26 -03 -22
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Const/TextConstants.dart';
import 'package:lifescool/Const/TextConstants.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/CourseIntro.dart';
import 'package:lifescool/Screens/HomePage.dart';
import 'package:lifescool/Screens/PlayerScreen.dart';
import 'package:lifescool/Screens/TutorInfo/TutorInfo.dart';
import 'package:lifescool/Shorts/Data/addToCache.dart';
import 'package:lifescool/Shorts/Data/reelsPagination.dart';
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
  bool isReadmore = false;

  var isVideoStarted = false;

  var arrList = [];
  var arrReels = [];
  var page = 1;
  var isLoading = true;
  var isPlaying = true;
  var name;
  var nowPlaying = 0;
  var fetchNew = 5;
  var currentPage = 0;
  var currentIndex = 0;
  var author_img;
  var likeTap = false;
  var isMute = false;

  var videoHeight = 0.0;
  var videoWidth = 0.0;
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    controller0.pause();

    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
    // super.dispose();
  }

  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);

    this.getHome();

    super.initState();
  }

  final PageController controller = PageController(
    viewportFraction: 1,
  );

  void nextPage() async {
    await controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.bounceOut,
    );
  }

  void prevPage() async {
    await controller.previousPage(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  Future<String> getHome() async {
    var rsp = await getFromCache();

    print(rsp);

    // arrProdList = data;
    //
    if (rsp != 0) {
      setState(() {
        arrList = rsp;
      });
      print("reeeeels length");
      print(arrList.length);

      ControllerIndex(0);
      //setupController(0);
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


  HightlightIndex(index) async {
    print("indexxvdoo");
    print(widget.highligts);
    setState(() {
      isLoading = true;
    });
    controller0 =
        VideoPlayerController.network(widget.highligts['video_url'].toString());

    await controller0?.initialize();
    controller0?.setLooping(true);
    if (controller0.value.initialized) {
      setState(() {
        isLoading = false;
        isPlaying = true;
        isVideoStarted = true;
        print("falsaaaaaaaaayi");
        name = widget.highligts['title'].toString();
        author_img = widget.highligts['author_img'].toString();
        nowPlaying = index;
      });

      if (isMute == true) {
        controller0.setVolume(0.0);
      } else {
        controller0.setVolume(1.0);
      }
      controller0.play();
    }

    setState(() {
      currentIndex = index;
      videoHeight = controller0.value.size.height;
      videoWidth = controller0.value.size.width;
    });
  }
  ControllerIndex(index) async {
    print("indexxvdoo");



    if(widget.highligts!=null&&index==0){
      HightlightIndex(index);
    }else{
      controller0 = VideoPlayerController.file(
          File(arrList[index]['video_url'].toString()));

      await controller0?.initialize();
      controller0?.setLooping(true);
      if (controller0.value.initialized) {
        setState(() {
          isLoading = false;
          isPlaying = true;
          isVideoStarted = true;
          print("falsaaaaaaaaayi");
          name = arrList[index]['title'].toString();
          author_img = arrList[index]['author_img'].toString();
          nowPlaying = index;
        });

        if (isMute == true) {
          controller0.setVolume(0.0);
        } else {
          controller0.setVolume(1.0);
        }
        controller0.play();
      }

      setState(() {
        currentIndex = index;
        videoHeight = controller0.value.size.height;
        videoWidth = controller0.value.size.width;
      });
    }

  }

  Future<Null> setupController(index) async {
    if (arrList.length > 0) {
      if (widget.highligts == null) {
        //  Controller0();
      } else {
        HighlightController();
      }
    }

    print("bottom");

    // Timer(Duration(seconds: 3), () {
    //
    // });
  }

  TriggerNextTen(currentIndex) async {
    arrReels.clear();
    setState(() {
      fetchNew = 5;
      page = page + 1;
    });

    var totalIndex = await getSharedPrefrence(TOTALREELS);
    var lastAddedIndex = await getSharedPrefrence(LASTADEED);

    print("totaaaaaaaal");
    print(totalIndex);
    print(lastAddedIndex);

    if (int.parse(currentIndex.toString()) < int.parse(totalIndex.toString()) &&
        int.parse(lastAddedIndex.toString()) < page) {
      print("ulill work avndoo");
      var list = await getPaginationReels(page);
      if (list != null) {
        setState(() {
          arrReels = list;
        });
        for (var i = 0; i < arrReels.length; i++) {
          setState(() {
            arrList.add({
              "id": arrReels[i]["id"],
              "uid": arrReels[i]["uid"],
              "title": arrReels[i]["title"],
              "desc": arrReels[i]["desc"],
              "like": arrReels[i]["like"],
              "targetType": arrReels[i]["targetType"],
              "targetId": arrReels[i]["targetId"],
              "targetUid": arrReels[i]["targetUid"],
              "targetBtnName": arrReels[i]["targetBtnName"],
              "targetJtwContent": arrReels[i]["targetJtwContent"],
              "video_source": arrReels[i]["video_source"],
              "video_url": arrReels[i]["video_url"],
              "author_id": arrReels[i]["author_id"],
              "author_img": arrReels[i]["author_img"],
              "thumbnail_url": arrReels[i]["thumbnail_url"],
              "videoDuration": arrReels[i]["videoDuration"],
              "isLiked": arrReels[i]["isLiked"],
              "page": arrReels[i]["page"],
            });
          });
        }
      }
    }

    return;
    // var arrReels = [];
    //
    // var rsp = await reelsListApi(page);
    //
    // print(rsp);
    //
    // // arrProdList = data;
    // //
    // if (rsp != 0 ) {
    //
    //   arrReels = rsp['attributes']['shortslist'];
    //
    //   for (var i = 0; i < arrReels.length; i++) {
    //     if(arrReels[i]['video_url_mp4_low']!=""){
    //       var file = await DefaultCacheManager().getSingleFile(arrReels[i]['video_url_mp4_low']);
    //       var image = await DefaultCacheManager().getSingleFile(arrReels[i]['thumbnail_url']);
    //
    //       print("fetechingggg");
    //       print(arrReels[i]['id']);
    //
    //       setState(() {
    //         arrList.add(
    //             {
    //
    //               "id": arrReels[i]["id"],
    //               "uid": arrReels[i]["uid"],
    //               "title": arrReels[i]["title"],
    //               "desc":arrReels[i]["desc"],
    //               "like": arrReels[i]["like"],
    //               "targetType":arrReels[i]["targetType"],
    //               "targetId": arrReels[i]["targetId"],
    //               "targetUid": arrReels[i]["targetUid"],
    //               "targetBtnName": arrReels[i]["targetBtnName"],
    //               "targetJtwContent": arrReels[i]["targetJtwContent"],
    //               "video_source": arrReels[i]["video_source"],
    //               "video_url": file.path,
    //               "author_id":arrReels[i]["author_id"],
    //               "author_img":arrReels[i]["author_img"],
    //               "thumbnail_url": image.path,
    //               "videoDuration":arrReels[i]["videoDuration"],
    //               "isLiked": arrReels[i]["isLiked"],
    //               "page": "2",
    //
    //
    //
    //
    //             }
    //         );
    //       });
    //
    //
    //       var add = addCache(arrReels[i]['id'],arrReels[i]['uid'],arrReels[i]['title'],arrReels[i]['desc'],arrReels[i]['like'],arrReels[i]['targetType'],arrReels[i]['targetId'],arrReels[i]['targetUid'],arrReels[i]['targetBtnName'],arrReels[i]['targetJtwContent'],arrReels[i]['video_source'],file.path,arrReels[i]['author_id'],arrReels[i]['author_img'],image.path,arrReels[i]['videoDuration'],arrReels[i]['isLiked'], rsp['attributes']['page'].toString());
    //     }
    //
    //
    //
    //   }
    //   // setState(() {
    //   //   isLoading = false;
    //   // });
    //   return "1";
    // }
  }

  TriggerBack() async {
    if (page != 1) {
      page = page - 1;
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

  Widget feedVideos() {
    print("feeeeeeeeed");

    return Stack(
      children: [
        PageView.builder(
          controller: controller,
          itemCount: arrList != null ? arrList.length : 0,
          onPageChanged: (index) {
            setState(() {
              isVideoStarted = false;
            });
            if (index > currentIndex) {
              print("direction => munnot");

              setState(() {
                fetchNew = fetchNew - 1;
              });

              if (fetchNew == 0) {
                print("TRIGGER");
                print(fetchNew);
                TriggerNextTen(page);
              }
            } else {
              print("direction => backoot");

              TriggerBack();
              //  _previousVideo();
            }
            setState(() {
              currentIndex = index;
            });

            controller0.dispose();
            ControllerIndex(index);
          },
          allowImplicitScrolling: false,
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
                          setState(() {
                            isMute = false;
                          });
                          controller0.setVolume(1.0);
                        } else {
                          setState(() {
                            isMute = true;
                          });

                          controller0.setVolume(0.0);
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
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 20),
                  //   child: Row(
                  //     children: [Spacer(), shareIcon()],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 16,
                  // ),
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
                                  // : arrList[nowPlaying]['id'].toString(),
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
                                fontWeight: FontWeight.bold,
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
                  h(8),
                  buildText(
                    arrList[nowPlaying]
                    ['desc']
                        .toString(),
                  ),
                  h(2),
                  Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        child: Text(
                          (isReadmore ? 'Read Less' : 'Read More'),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            isReadmore = !isReadmore;
                          });
                        },
                      ),
                      w(16)
                    ],
                  ),
                  h(16),
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

    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (controller0.value.isPlaying) {
                setState(() {
                  isPlaying = false;
                });
                controller0?.pause();
              } else {
                controller0?.play();

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
            child: Center(
              child: AspectRatio(
                aspectRatio: controller0.value.aspectRatio,
                child: Container(
                    color: Colors.black,
                    child: Center(child: VideoPlayer(controller0))),
              ),
            ),
          ),
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
      ),
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

  Widget buildText(String text) {
    // if read more is false then show only 3 lines from text
    // else show full text
    final lines = isReadmore ? null : 2;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w100, color: Colors.white),
        maxLines: lines,

        // overflow properties is used to show 3 dot in text widget
        // so that user can understand there are few more line to read.
        overflow: isReadmore ? TextOverflow.visible : TextOverflow.ellipsis,
      ),
    );
  }
}
