import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Screens/LiveClasses/Data/moduleDataList.dart';
import 'package:lifescool/Screens/LiveClasses/Data/moduleList.dart';
import 'package:lifescool/Screens/LiveClasses/LiveBatchesBriefPage.dart';
import 'package:lifescool/Screens/LiveClasses/Utils/catName.dart';
import 'package:lifescool/Screens/LiveClasses/webviewLiveClass.dart';
import 'package:lifescool/Screens/webviewPlain.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:video_player/video_player.dart';
class LiveClassScreen extends StatefulWidget {
  final id;
  final item;

  LiveClassScreen({this.id,this.item});
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
  var type ="";

  var arrList = [];

  var arrCat = [];
  var arrLive = [];

  var isLoading = true;
  var isVdoLoading = true;

  var currentIndex = 3000;
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
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp != 0) {
      setState(() {
        arrCat = rsp['attributes']['response'];

        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();
      });
      print("arrCatList");
      print(arrCat);
      if (arrCat.isNotEmpty) {
        getData(arrCat[0]['id'], 0);
      }
    } else {}

    // setState(() {
    //   isLoading = false;
    // });
    return "0";
  }

  Future<String> getData(moduleID, index) async {
    setState(() {
      isLoading = true;
    });
    print("searchhhhhhhh");

    var rsp = await modulesDataListApi(moduleID);
    print("searchhhhhhhh");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrList = rsp['attributes']['response'];
        arrLive = rsp['attributes']['livedata'];


         title = arrList[0]['itemData']['title'];
         url = arrList[0]['itemData']['link'];
         img = arrList[0]['itemData']['thumbnail'];
         // dec1 = arrList[index]['itemData']['discTitle'];
         // dec2 = arrList[index]['itemData']['disc'];

        type= arrList[0]['itemType'];


         if(type=="MIVIDEO"){
           initializePlayer();
         }

      });
      print("searchhhhhhhh");
      print(arrList);
    } else {
      //showToastSuccess(rsp['attributes']['message'].toString());
    }

    setState(() {
      isLoading = false;
    });
    return "0";
  }

  Future<void> initializePlayer() async {
    setState(() {
    //  isLoading = false;
      isVdoLoading = true;
    });
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
    });
  }

  Future<void> selectCourse(index) async {
    title = arrList[index]['itemData']['title'];
    url = arrList[index]['itemData']['link'];
    img = arrList[index]['itemData']['thumbnail'];
    // dec1 = arrList[index]['itemData']['discTitle'];
    // dec2 = arrList[index]['itemData']['disc'];

    type= arrList[index]['itemType'];


    if(type=="MIVIDEO"){
      initializePlayer();
    }
  }

  Future<void> selectLive(index) async {

    setState(() {
      title = arrLive[index]['itemData']['title'];
      url = arrLive[index]['itemData']['link'];
      img = arrLive[index]['itemData']['thumbnail'];
      // dec1 = arrList[index]['itemData']['discTitle'];
      // dec2 = arrList[index]['itemData']['disc'];

      type= arrLive[index]['itemType'];


      if(type=="MIVIDEO"){
        initializePlayer();
      }
    });

  }
  Future<bool> _onBackPressed() async {
    _videoPlayerController1.pause();
  //  _videoPlayerController1.dispose();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => liveBatchesBriefPage(item: widget.item,)),
    );





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
        body: Column(
          children: [
            type!="MIVIDEO"?Stack(
              alignment: Alignment.center,
              children: [
          Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.network(img!=null?img:testImg, fit: BoxFit.cover),
                  decoration: BoxDecoration(gradient: gradientHOME),
                ),
                Align(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: Colors.black38,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WebViewLive(url: url,type: type,)),
                      );

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient:type=="GROUPLIVE"?gradientLive: gradientHOME),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Text(viewCatName(type), style: size14_700W),
                      ),
                    ),
                  ),
                )
              ],
            ):Stack(
              alignment: Alignment.center,
              children: [
                type=="MIVIDEO"?isVdoLoading == true
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
                    :Container(
                  height: MediaQuery.of(context).size.height * 0.3,
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
                  decoration: BoxDecoration(color: Colors.white),
                ): Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                 // child: Image.network(testImg, fit: BoxFit.cover),
                  decoration: BoxDecoration(color: Colors.black),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  title,

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
                                border: Border.all(color: Colors.black12)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                border: Border.all(color: Colors.black12)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  Expanded(child: menutap == true ? MenuItems() : moduleList())
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
                  Text(dec1,
                      style: size16_700Mallu),
                  h(4),
                  Text(
                      dec2,
                      style: size14_600grey)
                ],
              ),
            ),
            h(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: grey2),
                        borderRadius: BorderRadius.circular(10),
                        color: greyClr),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "Downloads",
                        style: size14_700Grey,
                      ),
                    ),
                  ),
                  w(8),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: grey2),
                        borderRadius: BorderRadius.circular(10),
                        color: greyClr),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "Links",
                        style: size14_700Grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Scrollbar(
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: arrList != null ? arrList.length : 0,
                          itemBuilder: (context, index) {
                            final item = arrList != null ? arrList[index] : null;
                            return ChaptersList(item, index);
                          },
                          separatorBuilder: (context, index) => h(8),
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

        selectCourse(index);
        setState(() {
          moduleTap = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: lifescool_highlight),
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
                      CircleAvatar(
                        radius: 2,
                        backgroundColor: Color(0xff6D6D6D),
                      ),
                      Text(
                        "2 mins",
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

  QuestionListNew(index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: liteRed),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.question_circle_fill,
                color: Color(0xffEA9985),
                size: 18,
              ),
              w(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("What did we learn today?", style: size16_400),
                  h(4),
                  Text(
                    "Quiz",
                    style: size14_600grey,
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
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
    return GestureDetector(
      onTap: () {
        print("index");
        print(index);
        getData(item['id'], index);
        setState(() {
          moduleTap = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: moduleTap == index ? themeOrange : greyClr,
        ),
        height: 58,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Text(
                item['moduleName'].toString(),
                style: moduleTap == index ? size14_700White : size14_700Red,
              ),
              h(5),
              Text(
                item['moduleNo'].toString(),
                style: moduleTap == index ? size14_700White : size14_700Red,
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
