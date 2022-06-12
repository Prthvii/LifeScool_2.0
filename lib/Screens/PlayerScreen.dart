import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:lifescool/Api/courseDetails.dart';
import 'package:lifescool/Api/courseRating.dart';
import 'package:lifescool/Api/requestCertificate.dart';
import 'package:lifescool/Api/sendSeekPoint.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/colorConverter.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/Forum.dart';
import 'package:lifescool/Screens/courseIntroduction.dart';
import 'package:lifescool/Screens/paymentGateway.dart';
import 'package:lifescool/Screens/webviewPlain.dart';
import 'package:lifescool/widgets/titleDescription.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'CertificatePasscode.dart';

class PlayerScreen extends StatefulWidget {
  final id;
  final cuid;
  final introTrue;

  PlayerScreen({this.id, this.introTrue, this.cuid});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  var title;
  var reviewCriteria1;
  var reviewCriteria2;
  var reviewCriteria3;
  int selected = 0;
  var rating1 = 3.0;
  var rating2 = 3.0;
  var rating3 = 3.0;
  var arrList = [];
  var courseDetail = [];
  var lessons = [];

  var isLoading = true;
  var isVdoLoading = true;
  var isPlayable = true;
  var isRatable = false;
  var ratingPress = false;
  var rateButtonClick = false;
  var isFinishRating = false;
  var genrateCert = false;

  var url;
  var urlId = 0;
  var totalLength = 0;
  var exitPoint = 0;
  var courseFee = "0";
  var saleFee = "0";
  var isCourseFree = "PAID";
  ReceivePort _port = ReceivePort();

  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;

  ChewieController _chewieController;
  var isSynopsis = false;
  var synopsisItem;
  var filesItem = [];
  var isFiles = false;
  //List<dynamic> data = [];
  @override
  void initState() {
    super.initState();
   // secureScreen();
    print("xoxoxo");
    print(widget.id);
    this.getHome();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    await FlutterWindowManager.addFlags(
        FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
  }

  Future<void> disposeScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    await FlutterWindowManager.addFlags(
        FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
  }

  @override
  void dispose() {
   // disposeScreen();
    setState(() {
      _videoPlayerController1.pause();
    });
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    _videoPlayerController1.dispose();
    setState(() {
      _videoPlayerController1.pause();
    });
    _chewieController.dispose();
    super.dispose();
  }

  ///downloadfile--
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void _download(String url) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      showToastSuccess("Downloading...");
      final id = await FlutterDownloader.enqueue(
        url: url,
        savedDir: '/storage/emulated/0/Download/',
        showNotification: true,
        openFileFromNotification: true,
      );
      print("downdload");
      print(id);
      showToastSuccess("Downloaded!");
    } else {
      print('Permission Denied');
    }
  }

  ///downloadfile--

  ///api----
  Future<String> getHome() async {
    var rsp = await courseDetails(widget.id);
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp != 0 && rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrList = rsp['attributes']['courseDetails'];
        print("arrList");
        print(arrList);
        courseFee = arrList[0]['feeMrp'];
        saleFee = arrList[0]['feePrice'];
        title = rsp['attributes']['lessons'][0]['chapterName'];
        isCourseFree = rsp['attributes']['courseDetails'][0]['cwtype'];
        reviewCriteria1 =
            rsp['attributes']['courseDetails'][0]['reviewCriteria1'];
        reviewCriteria2 =
            rsp['attributes']['courseDetails'][0]['reviewCriteria2'];
        reviewCriteria3 =
            rsp['attributes']['courseDetails'][0]['reviewCriteria3'];
        var rate = rsp['attributes']['courseDetails'][0]['showReview'];

        lessons = rsp['attributes']['lessons'];

        if (rate == 1) {
          isRatable = true;
        }

        if (rsp['attributes']['lessons'][0]['playable'].toString() == "1") {
          url = rsp['attributes']['lessons'][0]['video_url'];
          initializePlayer();
        } else {}

        if (rsp['attributes']['courseDetails'][0]['subscriptionStatus'] == 1) {
          isPlayable = true;
        } else {
          isPlayable = false;
          if (widget.introTrue == null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => CourseIntroduction(
                        id: widget.id.toString(),
                        cuid: widget.cuid.toString(),
                      )),
            );
          }
        }

        print(
            '```````````````````````````````````````````````````````urllllll```````````````````````````````````````````````````````');
        print(arrList);
        print(
            '````````````````````````````````````````````urllllll````````````````````````````````````````````');
        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();
      });
    } else {
      arrList = rsp['attributes']['courseDetails'];
    }

    setState(() {
      isLoading = false;
    });

    return "0";
  }

  ///api----

  ///video--

  Future<void> initializePlayer() async {
    var u ="https://player.vimeo.com/external/680748430.m3u8?s=ae5b41cf276e5a6f7a0dedc91e152f13a6f5b41e&oauth2_token_id=1526368676";

    //var file = await DefaultCacheManager().getSingleFile(u);
  _videoPlayerController1 = VideoPlayerController.network(url.toString());



 //_videoPlayerController1 = VideoPlayerController.file(File(file.path));


  //  _videoPlayerController1 = VideoPlayerController.network("https://firebasestorage.googleapis.com/v0/b/togo-be1ba.appspot.com/o/www.DVDPLay.Rest%20-%20Meppadiyan%20(2022)%20Malayalam%20HQ%20HDRip%20-%20400MB%20-%20x264%20-%20AAC%20-%20ESub.mkv?alt=media&token=bd5a2f1c-5ac5-416b-8e51-d0d7fa7e4118".toString());

    await _videoPlayerController1.initialize();

    setState(() {
      totalLength = _videoPlayerController1.value.duration.inSeconds;
    });

    print("timeeeeeee");
    print(totalLength);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: false,
    );

    // _chewieController.enterFullScreen();
    setState(() {
      isLoading = false;
      isVdoLoading = false;
    });
  }

  Future<String> exiT() async {
    exitPoint = _videoPlayerController1.value.position.inSeconds;
    print("okkkkkkkkkkkk");
    print(widget.id);
    print(lessons[urlId]['id']);
    print(exitPoint);
    print(totalLength);
    print("okkkkkkkkkkkk");
    var rsp =
        await sendSeek(widget.id, lessons[urlId]['id'], exitPoint, totalLength);
    print("senddd");
    print(rsp);
    return "0";
  }

  Future<bool> _onBackPressed() async {
    exiT();
    return Future<bool>.value(true);
  }

  ///video--
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          extendBody: true,
          // appBar: PreferredSize(
          //   preferredSize: Size.fromHeight(60),
          //   child: SafeArea(
          //     child: AppBar(
          //       //   backgroundColor: liteBlue,
          //       elevation: 0,
          //       titleSpacing: 1,
          //       flexibleSpace: Padding(
          //         padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Row(
          //                   children: [
          //                     GestureDetector(
          //                       onTap: () {
          //                         Navigator.pop(context);
          //                       },
          //                       child: CircleAvatar(
          //                         backgroundColor: Colors.black,
          //                         radius: 22,
          //                         child: Icon(
          //                           Icons.arrow_back,
          //                           size: 20,
          //                           color: Colors.white,
          //                         ),
          //                       ),
          //                     ),
          //
          //                   ],
          //                 ),
          //
          //               ],
          //             ),
          //
          //           ],
          //         ),
          //       ),
          //       automaticallyImplyLeading: false,
          //     ),
          //   ),
          // ),
          bottomNavigationBar:
              // isRatable == true
              //     ? rateButton()
              //     :
              isPlayable == false
                  ? Container(
                      height: 100,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.0),
                          Colors.white,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => paymentPage(
                                      amount: saleFee,
                                      id: widget.id,
                                      paid: isCourseFree,
                                    )),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 55, vertical: 25),
                          child: Container(
                            // margin: EdgeInsets.symmetric(horizontal: 55, vertical: 35),
                            // height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: (Colors.white),
                                  spreadRadius: 50,
                                  blurRadius: 10,
                                  offset: Offset(
                                    0,
                                    60,
                                  ),
                                ),
                              ],
                              color: Color(0xff2F455C),
                            ),
                            child: isCourseFree == "PAID"
                                ? RichText(
                                    text: TextSpan(
                                        text: "Unlock now for ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            fontFamily: 'Nunito',
                                            color: Colors.white),
                                        children: [
                                          TextSpan(
                                              text: "₹" + courseFee.toString(),
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  fontFamily: 'Nunito',
                                                  color: Colors.white70)),
                                          TextSpan(
                                              text: "  ₹" + saleFee.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  fontFamily: 'Nunito',
                                                  color: Colors.white)),
                                        ]),
                                  )
                                : RichText(
                                    text: TextSpan(
                                        text: "Unlock now for ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            fontFamily: 'Nunito',
                                            color: Colors.white),
                                        children: [
                                          // TextSpan(
                                          //     text: "₹" + courseFee.toString(),
                                          //     style: TextStyle(
                                          //         decoration:
                                          //         TextDecoration.lineThrough,
                                          //         fontWeight: FontWeight.w600,
                                          //         fontSize: 14,
                                          //         fontFamily: 'Nunito',
                                          //         color: Colors.white70)),
                                          TextSpan(
                                              text: "free",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  fontFamily: 'Nunito',
                                                  color: Colors.white)),
                                        ]),
                                  ),
                            // child: Text(
                            //   "Unlock now for ₹" + courseFee.toString(),
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: 16,
                            //       color: Colors.white),
                            // ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 1,
                    ),
          backgroundColor: Colors.grey[100],
          body: isLoading == true
              ? Container(
                  child: Center(
                  child: Image.asset(
                    "assets/images/loading.gif",
                    height: 40,
                  ),
                ))
              : SingleChildScrollView(
                  reverse: true,
                  child: Stack(
                    children: [
                      Container(
                          child: Column(
                        children: [
                          lessons.isEmpty
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: Center(
                                    child: Text("No Lessons Found"),
                                  ))
                              : lessons[selected]['playable'].toString() == "0"
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: Center(
                                        child: Text("Course Not Subscribed"),
                                      ))
                                  : isVdoLoading == true
                                      ? Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SpinKitThreeBounce(
                                                color: Color(0xffFD5C36),
                                                size: 20.0,
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Loading...',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          color: Colors.white,
                                          child: Center(
                                            child: _chewieController != null &&
                                                    _chewieController
                                                        .videoPlayerController
                                                        .value
                                                        .initialized
                                                ? Chewie(
                                                    controller:
                                                        ChewieController(
                                                      videoPlayerController:
                                                          _videoPlayerController1,
                                                      allowPlaybackSpeedChanging:
                                                          true,
                                                      showControls: true,
                                                      materialProgressColors:
                                                          ChewieProgressColors(
                                                        playedColor:
                                                            Colors.grey[900],
                                                        handleColor:
                                                            Colors.blue,
                                                        backgroundColor:
                                                            Colors.grey,
                                                        bufferedColor:
                                                            Colors.grey[400],
                                                      ),
                                                    ),
                                                  )
                                                : Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircularProgressIndicator(),
                                                      SizedBox(height: 20),
                                                      Text('Loading'),
                                                    ],
                                                  ),
                                          ),
                                        ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.65,
                            child: ListView(
                              children: [
                                titleDescription(
                                    data: arrList,
                                    id: widget.id.toString(),
                                    cuid: widget.cuid.toString()),
                                SizedBox(
                                  height: 20,
                                ),
                                _tabSection(context),
                              ],
                              padding: EdgeInsets.zero,
                              physics: AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                            ),
                          ),
                        ],
                      )),
                      Align(
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          color: Colors.black54,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back_outlined,
                                    color: Color(0xffFCFCFC),
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    title != null
                                        ? title.toString()
                                        : "Loading......",
                                    // arrList[0]["courseNameEng"].toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      // shadows: <Shadow>[
                                      //   Shadow(
                                      //     offset: Offset(0, 0),
                                      //     blurRadius: 2.0,
                                      //     color: Colors.black,
                                      //   ),
                                      // ],
                                      color: Color(0xffFCFCFC),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        alignment: Alignment.topLeft,
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget rateButton() {
    return GestureDetector(
      onTap: () {
        // _videoPlayerController1.pause();
        // _chewieController.pause();
        setState(() {
          rateButtonClick = true;
          isRatable = false;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff2FB134),
        ),
        child: Text(
          "Rate course",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xffE9E9E9),
                    borderRadius: BorderRadius.circular(10)),
                child: TabBar(
                  tabs: [
                    Tab(
                      text: "Lessons",
                    ),
                    Tab(text: "Forum"),
                  ],
                  indicatorColor: Colors.red,
                  indicator: BoxDecoration(
                    color: hexToColor(arrList[0]["primaryColor"].toString()),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  unselectedLabelColor:
                      hexToColor(arrList[0]["primaryColor"].toString()),
                  automaticIndicatorColorAdjustment: true,
                  labelStyle: bold14,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: TabBarView(
                  children: [
                    Container(
                      child: ratingPress == true
                          ? Container(
                              child: Center(
                                child: Image.asset(
                                  "assets/images/loading.gif",
                                  height: 30,
                                ),
                              ),
                            )
                          : isFinishRating == true
                              ? finishRatingBottomSheet()
                              : rateButtonClick == true
                                  ? ratingBottomSheet()
                                  : isSynopsis == true
                                      ? synopsisBottomSheet(synopsisItem)
                                      : isFiles == true
                                          ? filesBottomSheet(filesItem)
                                          : Lessons(),
                    ),
                    Container(
                      child: Forum(
                        id: widget.id,
                        isLocked: isPlayable,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom)),
            ],
          ),
        ),
      ),
    );
  }

  Widget Lessons() {
    return ListView(
      children: [
        Scrollbar(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: lessons != null ? lessons.length : 0,
            itemBuilder: (context, index) {
              final item = lessons != null ? lessons[index] : null;
              return LessonsList(item, index);
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: genrateCert == true
              ? null
              : () async {
                  // setState(() {
                  //   _videoPlayerController1.pause();
                  //
                  // });
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => CertificatePasscode(cuid: widget.cuid.toString(),cid: widget.id.toString(),)),
                  // );

                  setState(() {
                    genrateCert = true;
                  });

                  var rsp = await reqCertificate(widget.cuid);
                  if (rsp != 0) {
                    setState(() {
                      _videoPlayerController1.pause();
                    });
                    print("widget.cuid");
                    print(widget.cuid);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CertificatePasscode(
                                cuid: widget.id.toString(),
                                cid: widget.id.toString(),
                              )),
                    );
                  } else {
                    CertificatePopUp();
                  }

                  //     CertificateOK();
                  //  CertificatePopUp();
                  //  CertificatePopUp();

                  setState(() {
                    genrateCert = false;
                  });
                },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[400],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  genrateCert == true ? Icons.hourglass_bottom : Icons.lock,
                  color: Colors.white,
                  size: 15,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  genrateCert == true
                      ? "Fetching Data..."
                      : "Get Your Certificate",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white,
                    fontFamily: 'Nunito',
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void CertificatePopUp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16),
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(24)),
        scrollable: false,
        elevation: 10,
        content: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/alert.svg",
                          width: 49,
                          // height: ,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Ayyo...',
                                textAlign: TextAlign.left,
                                style: bold14,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                  "You can generate certificate only after watching all the videos. Please complete the final assessment to generate course certificate.",
                                  style: size14_400G),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => CertificatePasscode()),
                        // );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: themeOrange),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            "Okay",
                            style: txt14SemiWhite,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  void CertificateOK() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16),
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(24)),
        scrollable: false,
        elevation: 10,
        content: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 96),
                      child: Text(
                        "Please enter your name as you want in your certificate",
                        textAlign: TextAlign.start,
                        style: txt16Gry,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: greyClr,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          // controller: bodyController,
                          cursorColor: Colors.black,
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          autofocus: false,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 14),
                            hintText: "Write here",
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CertificatePasscode()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: themeOrange),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            "Okay",
                            style: txt14SemiWhite,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  LessonsList(var item, int index) {
    return item['playable'].toString() == "1"
        ? ExpansionTile(
            key: Key('builder ${selected.toString()}'),
            backgroundColor: Colors.white, textColor: Colors.black,
            initiallyExpanded: index == selected,
            tilePadding: EdgeInsets.only(left: 10, right: 15),
            onExpansionChanged: ((newState) {
              if (newState)
                setState(() {
                  Duration(seconds: 20000);
                  selected = index;
                });
              else
                setState(() {
                  //selected = -1;
                });
            }),
            // iconColor: Colors.green,
            childrenPadding: EdgeInsets.only(left: 40),
            //  textColor: Colors.green,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.green,
                ),
                Text(
                  item['videoDuration'].toString() + "min",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Nunito',
                      color: Colors.green),
                )
              ],
            ),
            title: Row(
              children: [
                Image(
                  image: NetworkImage(item['progressImg'] != null
                      ? item['progressImg'].toString()
                      : "https://www.freeiconspng.com/uploads/green-video-play-icon-13.jpeg"),
                  height: 15,
                  width: 15,
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: isVdoLoading == true
                        ? null
                        : () {
                            exiT();
                            setState(() {
                              _videoPlayerController1.pause();
                              isVdoLoading = true;
                              title = item['chapterName'].toString();

                              url = null;
                              url = item['video_url'].toString();
                              urlId = index;
                              initializePlayer();
                            });
                          },
                    child: Text(
                      (index + 1).toString() +
                          ". " +
                          item['chapterName'].toString(),
                      style: urlId == index ? txt14Selct : txt14,
                      maxLines: 2,
                    ),
                  ),
                )
              ],
            ),
            children: <Widget>[
              Row(
                children: [
                  lessonContainers("Synopsis", Color(0xff009113), Colors.white,
                      () async {
                    setState(() {
                      isSynopsis = true;
                      synopsisItem = item['synopsys'].toString();
                    });
                  }),
                  SizedBox(
                    width: 15,
                  ),
                  lessonContainers("Files", Color(0xffD0EBD4), Colors.green,
                      () async {
                    setState(() {
                      isFiles = true;

                      filesItem = item['files'];
                    });
                  }),
                  SizedBox(
                    width: 15,
                  ),
                  item['mcqstatus'].toString() == "OFF"
                      ? Container()
                      : lessonContainers(
                          "Link", Color(0xff009113), Colors.white, () async {
                          // setState(() {
                          //   isSynopsis = true;
                          //   synopsisItem = item['synopsys'].toString();
                          // });

                          setState(() {
                            _videoPlayerController1.pause();
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebPagePlain(
                                    url: item['mcqlink'].toString())),
                          );
                        }),
                ],
              )
            ],
          )
        : Container(
            padding: EdgeInsets.only(left: 10, right: 15),
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock,
                        size: 15,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          (index + 1).toString() +
                              ". " +
                              item['chapterName'].toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Nunito',
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  item['videoDuration'].toString() + "min",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Nunito',
                  ),
                )
              ],
            ),
          );
  }

  Widget lessonContainers(
      String Txt, Color clr, Color txtClr, GestureTapCallback onTapp) {
    return GestureDetector(
      onTap: onTapp,
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), color: clr),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            Txt,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: txtClr,
                fontSize: 14,
                fontFamily: 'Nunito'),
          ),
        ),
      ),
    );
  }

  synopsisBottomSheet(var txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Text(
                  "Synopsis",
                  style: bold16,
                ),
                Spacer(),
                IconButton(
                    icon: Icon(
                      Icons.clear,
                    ),
                    onPressed: () async {
                      setState(() {
                        isSynopsis = false;
                      });
                    })
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Html(
                data: txt.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ratingBottomSheet() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Text(
                    "Rate course",
                    style: bold16,
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          rateButtonClick = false;
                          isRatable = true;
                        });
                      })
                ],
              ),
            ),
          ),
          // Text(
          //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore ",
          //   style: txt14Semi,
          // ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.6,
              child: ListView(
                children: [
                  Text(
                    "Criteria 1",
                    style: txt16,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    reviewCriteria1.toString(),
                    style: txt14,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          rating1 = rating;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Criteria 2",
                    style: txt16,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    reviewCriteria2.toString(),
                    style: txt14,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          rating2 = rating;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Criteria 3",
                    style: txt16,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    reviewCriteria3.toString(),
                    style: txt14,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          rating3 = rating;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // Navigator.pop(context);
                      setState(() {
                        ratingPress = true;
                      });
                      var rsp = await postRatingApi(
                          widget.id, rating1, rating2, rating3);
                      print("rsppp");
                      print(rsp);
                      if (rsp != 0) {
                        setState(() {
                          isFinishRating = true;
                          showToastSuccess("Thank You for your review!");
                        });
                      }

                      // finishRatingBottomSheet();

                      setState(() {
                        ratingPress = false;
                      });
                    },
                    child: Text(
                      "Submit",
                      style: bold16,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                //shrinkWrap: true,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, top: 10),
          ),
        ],
      ),
    );
  }

  finishRatingBottomSheet() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Text(
                    "Rate course",
                    style: bold14,
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          isFinishRating = false;
                          rateButtonClick = false;
                          isRatable = false;
                        });
                      })
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(41),
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Thanks for the feedback",
                  style: txt16Semi,
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFinishRating = false;
                      rateButtonClick = false;
                      isRatable = false;
                    });
                  },
                  child: Text(
                    "Close",
                    style: bold16,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, top: 30),
          ),
        ],
      ),
    );
  }

  fileBuilder(var files) {
    return Flexible(
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.5,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => SizedBox(
            height: 10,
          ),
          itemCount: files != null ? files.length : 0,
          itemBuilder: (context, index) {
            final item = files != null ? files[index] : null;
            return txt(item, index);
          },
        ),
      ),
    );
  }

  txt(var item, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (index + 1).toString() + item['fileName'],
            style: txt14Semi,
          ),
          Spacer(),
          item['downloadable'] == 1
              ? GestureDetector(
                  onTap: () async {
                    _download(item['fileUrl'].toString());
                    // var status = await Permission.storage.status;
                    // if (!status.isGranted) {
                    //   await Permission.storage.request();
                    // }else{
                    //   final taskId = await FlutterDownloader.enqueue(
                    //     url: item['fileUrl'].toString(),
                    //     savedDir: '/storage/emulated/0/Download/',
                    //     showNotification: true, // show download progress in status bar (for Android)
                    //     openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                    //   );
                    // }

                    // if (await canLaunch(item['fileUrl'].toString())){
                    //   await launch(item['fileUrl'].toString());
                    //
                    //
                    // }else{
                    //   showToastSuccess("Cannot launch browser");
                    // }
                  },
                  child: Icon(
                    Icons.download_sharp,
                    color: Colors.black38,
                  ),
                )
              : SizedBox(
                  height: 1,
                ),
        ],
      ),
    );
  }

  filesBottomSheet(var files) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "Files",
                    style: bold16,
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          isFiles = false;
                        });
                      })
                ],
              ),
            ),
          ),
          fileBuilder(files),
        ],
      ),
    );
  }
}
