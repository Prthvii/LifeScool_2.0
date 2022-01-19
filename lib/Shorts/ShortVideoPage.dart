import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifescool/Const/Constants.dart';
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
  var arrList = [];
  var isLoading = true;
  var name;
  var author_img;
  var likeTap = false;
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    controller.pause();
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

    controller =
        VideoPlayerController.network(arrList[index]['video_url'].toString());
    // controller = VideoPlayerController.network("https://player.vimeo.com/external/610710191.m3u8?s=575c9884196f073e46f79db69aa9676eed41dd6f&oauth2_token_id=1526368676");
    // setState(() {
    //   isLoading = true;
    // });
    await controller?.initialize();
    print("reachedd");
    controller?.setLooping(true);
    controller.play();

    print("intializedd");
    setState(() {
      isLoading = false;
      name = arrList[index]['title'].toString();
      author_img = arrList[index]['author_img'].toString();
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

      // Container(
      //   color: Colors.black,
      //   child: Stack(
      //     children: [
      //       // Positioned(
      //       //   child: Icon(
      //       //     Icons.bookmark_outline,
      //       //     color: Colors.white,
      //       //   ),
      //       //   // alignment: Alignment.topLeft,
      //       //   top: 15, left: 15,
      //       // ),
      //       // Align(
      //       //   alignment: Alignment.bottomCenter,
      //       //   child: Container(
      //       //     child: Padding(
      //       //       padding: const EdgeInsets.only(bottom: 16),
      //       //       child: Column(
      //       //         mainAxisAlignment: MainAxisAlignment.end,
      //       //         children: [
      //       //           Padding(
      //       //             padding: const EdgeInsets.only(right: 20),
      //       //             child: Row(
      //       //               children: [
      //       //                 Spacer(),
      //       //                 Icon(
      //       //                   Icons.share,
      //       //                   color: Colors.white,
      //       //                   size: 25,
      //       //                 )
      //       //               ],
      //       //             ),
      //       //           ),
      //       //           SizedBox(
      //       //             height: 16,
      //       //           ),
      //       //           Padding(
      //       //             padding: const EdgeInsets.symmetric(horizontal: 10),
      //       //             child: Row(
      //       //               children: [
      //       //                 Spacer(),
      //       //                 Column(
      //       //                   children: [
      //       //                     CircleAvatar(
      //       //                       backgroundColor: Colors.white,
      //       //                       child: Icon(
      //       //                         Icons.favorite,
      //       //                         color: Colors.red,
      //       //                       ),
      //       //                       radius: 20,
      //       //                     ),
      //       //                     SizedBox(
      //       //                       height: 3,
      //       //                     ),
      //       //                     Text(
      //       //                       "2.4k",
      //       //                       style: TextStyle(
      //       //                           color: Colors.white,
      //       //                           fontSize: 12,
      //       //                           fontWeight: FontWeight.w600),
      //       //                     )
      //       //                   ],
      //       //                 )
      //       //               ],
      //       //             ),
      //       //           ),
      //       //           SizedBox(
      //       //             height: 16,
      //       //           ),
      //       //           Row(
      //       //             children: [
      //       //               Expanded(
      //       //                 flex: 6,
      //       //                 child: Padding(
      //       //                   padding: const EdgeInsets.only(left: 15),
      //       //                   child: Text(
      //       //                     "നമ്മൾ തീർച്ചയായും അറിയേണ്ട 10 secret മൊബൈൽ കോഡുകൾ !!!",
      //       //                     maxLines: 2,
      //       //                     style: TextStyle(
      //       //                         fontSize: 16,
      //       //                         fontFamily: 'Mallu',
      //       //                         fontWeight: FontWeight.w400,
      //       //                         color: Colors.white),
      //       //                   ),
      //       //                 ),
      //       //               ),
      //       //               Expanded(
      //       //                 child: Padding(
      //       //                   padding: const EdgeInsets.only(right: 10),
      //       //                   child: Container(
      //       //                     height: 40,
      //       //                     width: 40,
      //       //                     decoration: BoxDecoration(
      //       //                         shape: BoxShape.circle,
      //       //                         image: DecorationImage(
      //       //                             image: NetworkImage(testImg),
      //       //                             fit: BoxFit.cover)),
      //       //                   ),
      //       //                 ),
      //       //               )
      //       //             ],
      //       //           ),
      //       //           // takeFullCourseWidget()
      //       //         ],
      //       //       ),
      //       //     ),
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
    );
  }

  takeFullCourseWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Color(0xff606060)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Text("Take full course", style: size14_600W),
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
            height: 150,
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
                    child: Row(
                      children: [
                        Spacer(),
                        Icon(Icons.volume_off_outlined,
                            color: Colors.white, size: 25)
                      ],
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Spacer(),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (likeTap == true) {
                                  setState(() {
                                    likeTap = false;
                                  });
                                } else {
                                  setState(() {
                                    likeTap = true;
                                  });
                                }
                              },
                              child: LikeIcon(),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "2.4k",
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
        SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Text('Following',
                  //     style: TextStyle(
                  //         fontSize: 17.0,
                  //         fontWeight: FontWeight.normal,
                  //         color: Colors.white70)),
                  // SizedBox(
                  //   width: 7,
                  // ),
                  // Container(
                  //   color: Colors.white70,
                  //   height: 10,
                  //   width: 1.0,
                  // ),
                  // SizedBox(
                  //   width: 7,
                  // ),
                  // Text('For You',
                  //     style: TextStyle(
                  //         fontSize: 17.0,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white))
                ]),
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
              likeTap = true;
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
