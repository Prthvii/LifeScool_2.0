import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Screens/LiveClasses/Data/moduleDataList.dart';
import 'package:lifescool/Screens/LiveClasses/Data/moduleList.dart';
import 'package:lifescool/Screens/LiveClasses/DownloadsPage.dart';
import 'package:lifescool/Screens/LiveClasses/LinksPage.dart';
import 'package:lifescool/Screens/LiveClasses/LiveBatchesBriefPage.dart';
import 'package:lifescool/Screens/LiveClasses/Utils/catName.dart';
import 'package:lifescool/Screens/LiveClasses/webviewLiveClass.dart';
import 'package:video_player/video_player.dart';

class LiveClassScreen extends StatefulWidget {
  final id;
  final item;

  LiveClassScreen({this.id, this.item});
  @override
  _LiveClassScreenState createState() => _LiveClassScreenState();
}

class _LiveClassScreenState extends State<LiveClassScreen> {
  bool menutap = false;
  var moduleTap = 0;
  var title = "";
  var url = "";
  var img = "";
  var dec1 = "";
  var dec2 = "";
  // var type ="MIVIDEO";
  var type = "";

  var arrList = [];

  var arrCat = [];
  var arrLive = [];

  var isLoading = true;

  var moduleLoading = true;
  var isVdoLoading = true;

  var currentIndex = 3000;
  var currentPlaying = 0;
  var nowPlaying = 0;
  var livePlaying = 3000;
  //List<dynamic> data = [];

  VideoPlayerController _videoPlayerController1;

  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();

    print("xoxoxo");
    print(widget.id);

    this.getCat();
    setState(() {});
  }

  Future<String> getCat() async {
    var rsp = await modulesListBatchApi(widget.id);

    if (rsp != 0) {
      setState(() {
        arrCat = rsp['attributes']['response'];
      });

      if (arrCat.isNotEmpty) {
        print("arrCat[0]");
        print(arrCat[0]);
        getData(arrCat[0]['id'], 0);
      }
    } else {
      setState(() {
        isLoading = false;
        moduleLoading = false;
      });
    }

    return "0";
  }

  Future<String> getData(moduleID, index) async {
    setState(() {
      // isLoading = true;
      moduleLoading = true;
      currentPlaying = index + 1;
    });

    print("searchhhhhhhh");

    var rsp = await modulesDataListApi(moduleID);

    // arrProdList = data;
    //
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrList = rsp['attributes']['response'];
        arrLive = rsp['attributes']['livedata'];

        type = arrList[index]['itemType'];

        print("daaaaaaaaaaaata");
        print(arrList[index]);
        if (type == "MIVIDEO") {
          title = arrList[index]['itemName'];
          url = arrList[index]['itemData']['videohls'];
          img = arrList[index]['itemData']['thumbnail'];
          // dec1 = arrList[index]['itemData']['title'];
          // dec2 = arrList[index]['itemData']['desc'];

          initializePlayer();
        } else {
          title = arrList[index]['itemName'];
          url = arrList[index]['itemData']['link'];
          img = arrList[index]['itemData']['thumbnail'];

          // dec1 = arrList[index]['itemData']['title'];
          // dec2 = arrList[index]['itemData']['desc'];

          setState(() {
            isLoading = false;
            moduleLoading = false;
          });
        }
      });
      print("searchhhhhhhh");
      print(url);
    } else {
      setState(() {
        isLoading = false;
        moduleLoading = false;
      });

      //showToastSuccess(rsp['attributes']['message'].toString());
    }

    return "0";
  }

  Future<void> initializePlayer() async {
    print("url");
    print(url);
    setState(() {
      //  isLoading = false;
      isVdoLoading = true;
    });
    //_videoPlayerController1 = VideoPlayerController.network("https://player.vimeo.com/external/685172136.m3u8?s=c2bad28611536ff026a7181fef97d52416f07a2e&oauth2_token_id=1526368676".toString());
    _videoPlayerController1 = VideoPlayerController.network(url.toString());
    //  _videoPlayerController1 = VideoPlayerController.network("https://firebasestorage.googleapis.com/v0/b/togo-be1ba.appspot.com/o/www.DVDPLay.Rest%20-%20Meppadiyan%20(2022)%20Malayalam%20HQ%20HDRip%20-%20400MB%20-%20x264%20-%20AAC%20-%20ESub.mkv?alt=media&token=bd5a2f1c-5ac5-416b-8e51-d0d7fa7e4118".toString());

    await _videoPlayerController1.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: false,
    );

    setState(() {
      isLoading = false;
      isVdoLoading = false;
      moduleLoading = false;
    });
  }

  Future<void> selectCourse(index) async {
    if (_videoPlayerController1.value.isPlaying) {
      _videoPlayerController1.pause();
    }

    type = arrList[index]['itemType'];

    if (type == "MIVIDEO") {
      title = arrList[index]['itemName'];
      url = arrList[index]['itemData']['videohls'];
      img = arrList[index]['itemData']['thumbnail'];

      // dec1 = arrList[index]['itemData']['title'];
      // dec2 = arrList[index]['itemData']['desc'];

      initializePlayer();
    } else {
      title = arrList[index]['itemName'];
      url = arrList[index]['itemData']['link'];
      print("Courseeeeeee");
      print(url);
      img = arrList[index]['itemData']['thumbnail'];

      // dec1 = arrList[index]['itemData']['title'];
      // dec2 = arrList[index]['itemData']['desc'];

      setState(() {
        isLoading = false;
        moduleLoading = false;
      });
    }
  }

  Future<void> selectLive(index) async {
    if (_videoPlayerController1.value.isPlaying) {
      _videoPlayerController1.pause();
    }
    setState(() {
      title = arrLive[index]['itemName'];
      url = arrLive[index]['itemData']['url'];
      img = arrLive[index]['itemData']['thumbnail'];

      // dec1 = "";
      // dec2 = arrList[index]['itemData']['dateTime'];

      type = arrLive[index]['itemType'];

      if (type == "MIVIDEO") {
        initializePlayer();
      }
    });
  }

  Future<bool> _onBackPressed() async {
    print("baaack");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => liveBatchesBriefPage(
                item: widget.item,
              )),
    );
    _videoPlayerController1.pause();
    //  _videoPlayerController1.dispose();

    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0.1),
            child: AppBar(elevation: 0, backgroundColor: Colors.white)),
        body: isLoading == true
            ? Container(
                child: Center(
                child: Image.asset(
                  "assets/images/loading.gif",
                  height: 40,
                ),
              ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  type != "MIVIDEO"
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Image.network(
                                  widget.item['thumbnailUrl'].toString(),
                                  fit: BoxFit.cover),
                              decoration: BoxDecoration(gradient: gradientHOME),
                            ),
                            Align(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                color: Colors.black38,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  if (type == "GROUPLIVE") {
                                    FlutterWebBrowser.openWebPage(
                                      url: url,
                                      customTabsOptions: CustomTabsOptions(
                                        colorScheme: CustomTabsColorScheme.dark,
                                        toolbarColor: themeOrange,
                                        secondaryToolbarColor: Colors.green,
                                        navigationBarColor: imgBgClr,
                                        addDefaultShareMenuItem: false,
                                        instantAppsEnabled: false,
                                        showTitle: true,
                                        urlBarHidingEnabled: false,
                                      ),
                                      safariVCOptions:
                                          SafariViewControllerOptions(
                                        barCollapsingEnabled: true,
                                        preferredBarTintColor: Colors.green,
                                        preferredControlTintColor: Colors.amber,
                                        dismissButtonStyle:
                                            SafariViewControllerDismissButtonStyle
                                                .close,
                                        modalPresentationCapturesStatusBarAppearance:
                                            true,
                                      ),
                                    );

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => WebPage100Ms(id: url)),
                                    // );

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => WebViewLive(url: url,type: type,)),
                                    // );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WebViewLive(
                                                url: url,
                                                type: type,
                                              )),
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: type == "GROUPLIVE"
                                          ? gradientLive
                                          : gradientHOME),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Text(viewCatName(type),
                                        style: size14_700W),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            type == "MIVIDEO"
                                ? isVdoLoading == true
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: Center(
                                          child: _chewieController != null &&
                                                  _chewieController
                                                      .videoPlayerController
                                                      .value
                                                      .initialized
                                              ? Chewie(
                                                  controller: ChewieController(
                                                    videoPlayerController:
                                                        _videoPlayerController1,
                                                    allowPlaybackSpeedChanging:
                                                        true,
                                                    showControls: true,
                                                    materialProgressColors:
                                                        ChewieProgressColors(
                                                      playedColor:
                                                          Colors.grey[900],
                                                      handleColor: Colors.blue,
                                                      backgroundColor:
                                                          Colors.grey,
                                                      bufferedColor:
                                                          Colors.grey[400],
                                                    ),
                                                  ),
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CircularProgressIndicator(),
                                                    SizedBox(height: 20),
                                                    Text('Loading'),
                                                  ],
                                                ),
                                        ),
                                        decoration:
                                            BoxDecoration(color: Colors.white),
                                      )
                                : Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    // child: Image.network(testImg, fit: BoxFit.cover),
                                    decoration:
                                        BoxDecoration(color: Colors.black),
                                  ),
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(widget.item['courseNameEng'],
                        style: size16_700Mallu),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (menutap == true) {
                              setState(() {
                                menutap = false;
                              });
                            } else {
                              setState(() {
                                menutap = true;
                              });
                            }

                            print("menttaap");
                            print(menutap);
                          },
                          child: menutap == true
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: themeOrange,
                                      border:
                                          Border.all(color: Colors.black12)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Icon(
                                      Icons.close,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                  height: 58,
                                  width: 62,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: greyClr,
                                      border:
                                          Border.all(color: Colors.black12)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Icon(
                                      Icons.list,
                                      size: 25,
                                      color: Color(0xff6D6D6D),
                                    ),
                                  ),
                                  height: 58,
                                  width: 62,
                                ),
                        ),
                        w(16),
                        Expanded(
                            child: menutap == true ? MenuItems() : moduleList())
                        // Expanded(child: MenuItems())
                      ],
                    ),
                  ),
                  h(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Module " +
                                (moduleTap + 1).toString() +
                                " : " +
                                arrCat[moduleTap]['moduleTitle'].toString(),
                            style: size16_700Mallu),
                        h(4),
                        Text(arrCat[moduleTap]['desc'].toString(),
                            style: size14_600grey)
                      ],
                    ),
                  ),
                  h(12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DownloadsPage()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: grey2),
                                borderRadius: BorderRadius.circular(10),
                                color: greyClr),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "Downloads",
                                style: size14_700Grey,
                              ),
                            ),
                          ),
                        ),
                        w(8),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LinksPage()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: grey2),
                                borderRadius: BorderRadius.circular(10),
                                color: greyClr),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "Links",
                                style: size14_700Grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: moduleLoading == true
                          ? Container(
                              child: Center(
                              child: Image.asset(
                                "assets/images/loading.gif",
                                height: 40,
                              ),
                            ))
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  Scrollbar(
                                    child: ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          arrList != null ? arrList.length : 0,
                                      itemBuilder: (context, index) {
                                        final item = arrList != null
                                            ? arrList[index]
                                            : null;
                                        return ChaptersList(item, index);
                                      },
                                      separatorBuilder: (context, index) =>
                                          h(8),
                                    ),
                                  ),
                                  h(10),
                                  liveClassMessgaes()
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  ChaptersList(var item, int index) {
    return GestureDetector(
      onTap: () {
        print("index");
        print(index);
        // getData(item['id'], index);
        setState(() {
          nowPlaying = index;
          livePlaying = 3000;
        });
        selectCourse(index);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: nowPlaying == index ? lifescool_highlight : Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (index + 1).toString(),
                style: size16_400,
              ),
              w(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['itemData']['title'].toString(), style: size16_400),
                  h(4),
                  Wrap(
                    spacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        catsName(item['itemType'].toString()),
                        style: size14_600grey,
                      ),
                      item['itemData']['duration'].toString() == ""
                          ? Container()
                          : CircleAvatar(
                              radius: 2,
                              backgroundColor: Color(0xff6D6D6D),
                            ),
                      item['itemData']['duration'].toString() == ""
                          ? Container()
                          : Text(
                              item['itemData']['duration'].toString(),
                              style: size14_600grey,
                            )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  liveClassMessgaes() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(height: 8),
      shrinkWrap: true,
      itemCount: arrLive != null ? arrLive.length : 0,
      itemBuilder: (context, index) {
        final item = arrLive != null ? arrLive[index] : null;
        return GestureDetector(
          onTap: () {
            selectLive(index);
            setState(() {
              nowPlaying = 3000;
              livePlaying = index;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:
                    livePlaying == index ? lifescool_highlight : Colors.white,
                border: Border.all(color: Colors.green)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 10,
                    child: Icon(
                      Icons.sensors_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                    backgroundColor: Colors.green,
                  ),
                  w(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['itemData']['title'].toString(),
                        style: size16_400,
                      ),
                      h(4),
                      Wrap(
                        spacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "LIVE",
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          CircleAvatar(
                            radius: 2,
                            backgroundColor: Color(0xff6D6D6D),
                          ),
                          Text(
                            item['itemData']['dateTime'].toString(),
                            style: size14_600grey,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  moduleList() {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: 8,
        ),
        shrinkWrap: true,
        itemCount: arrCat != null ? arrCat.length : 0,
        itemBuilder: (context, index) {
          final item = arrCat != null ? arrCat[index] : null;
          return ModuleList(item, index);
        },
      ),
    );
  }

  MenuItems() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Cont(Icons.notes, "Course Brief"),
          Cont(Icons.receipt_outlined, "News"),
          Cont(Icons.share, "Share"),
        ],
      ),
    );
  }

  ModuleList(var item, int index) {
    return item['displayStatus'] == "OFF"
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: greyClr,
            ),
            height: 58,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.lock,
                    size: 22,
                  ),
                  // color: Colors,
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              print("index");
              print(index);
              getData(item['id'], 0);

              setState(() {
                moduleTap = index;
                nowPlaying = 0;
                livePlaying = 3000;
              });

              if (_videoPlayerController1.value.isPlaying) {
                _videoPlayerController1.pause();
                //_videoPlayerController1.dispose();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: moduleTap == index ? themeOrange : greyClr,
              ),
              height: 58,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Text(
                      item['moduleName'].toString(),
                      style:
                          moduleTap == index ? size14_700White : size14_700Red,
                    ),
                    h(5),
                    Text(
                      item['moduleNo'].toString(),
                      style:
                          moduleTap == index ? size14_700White : size14_700Red,
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget Cont(IconData icn, String txt) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: greyClr,
            border: Border.all(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(
                icn,
                size: 20,
                color: Color(0xff6D6D6D),
              ),
              w(10),
              Text(txt, style: size14_700Grey)
            ],
          ),
        ),
        height: 58,
      ),
    );
  }
}
