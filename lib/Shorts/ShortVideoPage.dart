import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/CourseIntro.dart';
import 'package:lifescool/Screens/HomePage.dart';
import 'package:lifescool/Screens/PlayerScreen.dart';
import 'package:lifescool/Screens/TutorInfo.dart';
import 'package:lifescool/Shorts/Data/listReels.dart';
import 'package:lifescool/Shorts/share.dart';
import 'package:video_player/video_player.dart';

import 'bookmark.dart';
import 'like.dart';

class ShortsPlayerPage extends StatefulWidget {
  const ShortsPlayerPage({Key key}) : super(key: key);

  @override
  _ShortsPlayerPageState createState() => _ShortsPlayerPageState();
}

class _ShortsPlayerPageState extends State<ShortsPlayerPage> {
  VideoPlayerController controller;
  VideoPlayerController controller1;
  VideoPlayerController controller2;
  VideoPlayerController controller3;
  VideoPlayerController controller4;
  VideoPlayerController controller5;
  VideoPlayerController controller6;
  VideoPlayerController controller7;
  VideoPlayerController controller8;
  VideoPlayerController controller9;
  VideoPlayerController controller10;
  var arrList = [];
  var isLoading = true;
  var name;
  var nowPlaying = 0;
  var author_img;
  var likeTap = false;
  var isMute = false;
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    controller.pause();
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
    var rsp = await reelsListApi();
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp != 0) {
      setState(() {
        arrList = rsp['attributes']['shortslist'];
      });

      loadController(0);
    }

    // setState(() {
    //   isLoading = false;
    // });
    return "0";
  }

  Future<Null> loadController(index) async {
    print(arrList[index]['video_url']);

    controller = VideoPlayerController.network(arrList[index]['video_url'].toString());


    await controller?.initialize();
    controller?.setLooping(true);
    controller.play();



    if(isMute==true){
      controller.setVolume(1.0);
      setState(() {
        isMute=false;
      });
    }else{
      controller.setVolume(0.0);
      setState(() {
        isMute=true;
      });
    }
    setState(() {
      isLoading = false;
      name = arrList[index]['title'].toString();
      author_img = arrList[index]['author_img'].toString();
      nowPlaying = index;
    });
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
          itemCount: arrList != null ? arrList.length : 0,
          onPageChanged: (index) {
            // index = (feedViewModel.videoSource.listVideos.length) % index;
            //  feedViewModel.changeVideo(index);

            controller.pause();

            loadController(index);
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
                      onTap: (){

                        if(isMute==true){
                          controller.setVolume(1.0);
                          setState(() {
                            isMute=false;
                          });
                        }else{
                          controller.setVolume(0.0);
                          setState(() {
                            isMute=true;
                          });
                        }

                      },
                      child: Row(
                        children: [
                          Spacer(),
                         isMute==true? Icon(Icons.volume_off_outlined,
                              color: Colors.white, size: 25): Icon(Icons.volume_up_rounded,
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
                              onTap: (){
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
                                  color: arrList[nowPlaying]['isLiked'] == true ? Colors.red : Colors.grey,
                                ),
                                radius: 20,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
    arrList[nowPlaying]['isLiked']==true? (int.parse(arrList[nowPlaying]['like']) +1).toString() :arrList[nowPlaying]['like'].toString(),
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
          child: GestureDetector(onTap: (){
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
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
      ],
    );
  }

  Widget videoCard(var item, int index) {
    print("vdoooolength");

    // print(controller.value.duration);

    //print(controller.value.size.width);
    print("vdoooolength");

    return Stack(
      children: [
        controller.value.initialized
            ?GestureDetector(
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
          child: SizedBox.expand(
              child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller.value.size.width ?? 0,
              height: controller.value.size.height ?? 0,
              // width: MediaQuery. of(context). size. width ,
              //   height: MediaQuery. of(context). size. height,
              child: VideoPlayer(controller),
            ),
          )),
        ):Container(
          color: Colors.black,
          child: Center(
            child: Image.asset(
              "assets/images/loading.gif",
              height: 40,
            ),
          ),
        ),





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
