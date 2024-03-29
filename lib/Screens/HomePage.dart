import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifescool/Api/getUser.dart';
import 'package:lifescool/Api/homePageSuggestion.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/EnterNum.dart';
import 'package:lifescool/Screens/LiveClasses/LiveBatchesBriefPage.dart';
import 'package:lifescool/Screens/LiveClasses/LiveClassScreen.dart';
import 'package:lifescool/Screens/TutorInfo/TutorInfo.dart';
import 'package:lifescool/Screens/workshopForHome.dart';
import 'package:lifescool/Shorts/Data/addToCache.dart';
import 'package:lifescool/Shorts/Data/listReels.dart';
import 'package:lifescool/Shorts/HomeSuggestReels.dart';
import 'package:lifescool/Shorts/ShortVideoPage.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'Individual_HomeScreens/ViewAllCourses.dart';
import 'LiveClasses/LiveClassesNewHome.dart';
import 'MyLearningTabs/MyLearningNew.dart';
import 'PlayerScreen.dart';
import 'SearchSection/findCourse.dart';
import 'Workshop/ViewAllWorkshopsNew.dart';

class HomeScreen extends StatefulWidget {
  // const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var arrList = [];
  var arrSuggestedCourse = [];
  var arrSuggestedLiveBatch = [];
  var arrSuggestedWorkshops = [];
  var sliders = [];
  var arrReels = [];
  var resList = [];

  var isLoading = true;
  var token;
  var id;
  var _urls = [
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-portrait-of-a-woman-in-a-pool-1259-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-man-holding-neon-light-1238-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-man-runs-past-ground-level-shot-32809-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-hands-holding-a-smart-watch-with-the-stopwatch-running-32808-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-rolling-slowly-on-roller-skates-during-sunset-34547-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-road-of-a-city-with-many-cars-at-night-34561-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-weeds-waving-in-the-breeze-1178-large.mp4",
  ];
  //List<dynamic> data = [];
  @override
  void initState() {
    super.initState();

    print("xoxoxo");
    this.getProfile();
    this.getVersion();
    //   this.getReels();

    setState(() {});
  }
  void _showUpdate(type) {
    showDialog(
      context: context,
      barrierDismissible: type=="FORCEUPDATE"?false:true,
      builder: (context) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
        elevation: 10,
        title: Text('New Update Found!'),
        titleTextStyle: TextStyle(
            fontSize: 16,
            letterSpacing: 0.6,
            color: Color(0xff333333),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold),
        content: Text('Update the app to access the latest features.'),
        actions: <Widget>[
          // FlatButton(
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          //   child: Text('No', style: TextStyle(color: Colors.deepOrangeAccent)),
          // ),
          FlatButton(
            onPressed: () {
              try {
                launch(
                    "https://play.google.com/store/apps/details?id=com.lifeplug.lifescool");
              } on PlatformException catch (e) {
                launch(
                    "https://play.google.com/store/apps/details?id=com.lifeplug.lifescool");
              } finally {
                launch(
                    "https://play.google.com/store/apps/details?id=com.lifeplug.lifescool");
              }
            },
            child: Text(
              'UPDATE',
              style: TextStyle(color: lifescoolBlue),
            ),
          ),
        ],
      ),
    );
  }
  Future<String> getVersion() async {
    var current = await getSharedPrefrence(VERSION);
    var type = await getSharedPrefrence(VERSIONTYPE);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.buildNumber;

    if (current != version) {
      _showUpdate(type);
    }
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
      print("reeeeels length");
      print(arrReels.length);
      var lst = await setSharedPrefrence(
          TOTALREELS, rsp['attributes']['totalIndexes'].toString());

      /// arrReels[i]['video_url']
      for (var i = 0; i < arrReels.length; i++) {
        var file = await DefaultCacheManager()
            .getSingleFile(arrReels[i]['video_url_mp4_low']);
        var image = await DefaultCacheManager()
            .getSingleFile(arrReels[i]['thumbnail_url']);

        print("homefileee");
        print(file);
        var add = addCache(
            arrReels[i]['id'],
            arrReels[i]['uid'],
            arrReels[i]['title'],
            arrReels[i]['desc'],
            arrReels[i]['like'],
            arrReels[i]['targetType'],
            arrReels[i]['targetId'],
            arrReels[i]['targetUid'],
            arrReels[i]['targetBtnName'],
            arrReels[i]['targetJtwContent'],
            arrReels[i]['video_source'],
            file.path,
            arrReels[i]['author_id'],
            arrReels[i]['author_img'],
            image.path,
            arrReels[i]['videoDuration'],
            arrReels[i]['isLiked'],
            rsp['attributes']['page'].toString(),
            false);
      }
      // setState(() {
      //   isLoading = false;
      // });
      return "0";
    }
  }

  Future<String> getProfile() async {
    token = await getSharedPrefrence(TOKEN);
    print("Profileeeeeeeeeeeeeeee");
    if (token == null) {
      var rsp = await getUserApi();
      print("Profileeeeeeeeeeeeeeee");
      print(rsp);
      if (rsp['attributes']['message'].toString() == "Success") {
        var token = await setSharedPrefrence(
            TOKEN, rsp['attributes']['studentInfo']['apiToken']);

        var number = await setSharedPrefrence(
            NUM, rsp['attributes']['studentInfo']['mobileNumber']);

        var mail = await setSharedPrefrence(
            MAIL, rsp['attributes']['studentInfo']['emailId']);
        var name = await setSharedPrefrence(
            NAME, rsp['attributes']['studentInfo']['fullname']);
        getHomePageSuggestion();
      } else {
        showToastSuccess(rsp['attributes']['message'].toString());

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EntNum()),
        );
      }
    } else {
      getHomePageSuggestion();
    }

    return "0";
  }

  Future<String> getHomePageSuggestion() async {
    print("suggesteddddddddd");

    var rsp = await homePageSuggestionApi();
    print("suggesteddddddddd");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrSuggestedCourse = rsp['attributes']['suggestedCourses'];
        arrReels = rsp['attributes']['suggestedShorts'];
        arrSuggestedWorkshops = rsp['attributes']['suggestedWorkshops'];
        arrSuggestedLiveBatch = rsp['attributes']['suggestedLiveBatches'];
        sliders = rsp['attributes']['sliders'];
        //resList = rsp['attributes']['resumeCourse'];
      });
    }

    setState(() {
      isLoading = false;
    });
    return "0";
  }

  Future<bool> _onBackPressed() {
    _showDialog();

    return Future<bool>.value(true);
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
        elevation: 10,
        title: Text('Confirm Exit!'),
        content: Text('Are you sure you want to exit?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'No',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text(
              'Yes',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        extendBody: false,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: (Colors.grey[300]),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, -1),
              ),
            ],
            color: Colors.white,
          ),
          height: 78,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ss.width * 0.06),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShortsPlayerPage()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_circle_outline,
                              color: themeOrange, size: 22),
                          Text(
                            "Shorts",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: themeOrange),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => MyLearningNew2()),
                      // );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                      ),
                      child: Container(
                        height: 62,
                        // width: 118,
                        decoration: BoxDecoration(
                            color: lifescool_highlight,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home_outlined,
                                color: themeOrange,
                                size: 20,
                              ),
                              Text(
                                "Home",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: themeOrange),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.only(
                //           topRight: Radius.circular(10),
                //           bottomRight: Radius.circular(10)),
                //     ),
                //     child: TabBar(
                //       labelColor: Colors.white,
                //       unselectedLabelColor: Color(0xffFE5C36),
                //       labelStyle: TextStyle(
                //           fontSize: 14,
                //           fontFamily: 'Nunito',
                //           fontWeight: FontWeight.bold,
                //           color: Colors.white),
                //       unselectedLabelStyle: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.bold,
                //           fontFamily: 'Nunito',
                //           color: Color(0xffFE5C36)),
                //       indicator: BoxDecoration(
                //         color: Color(0xffE6E6E6),
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       tabs: [
                //         Tab(
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Icon(Icons.home_outlined,
                //                   color: themeOrange, size: 22),
                //               Text(
                //                 "Home",
                //                 style: TextStyle(
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.w700,
                //                     color: themeOrange),
                //               )
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyLearningNew2()),
                      );
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lightbulb_outline,
                                color: themeOrange, size: 22),
                            Text(
                              "My Learning",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: themeOrange),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          title: Container(
              height: 30,
              child:
                  Image.asset('assets/images/lslogo.png', fit: BoxFit.cover)),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FindCourse()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: gradientHOME,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.white, size: 16),
                        w(10),
                        Text(
                          "Find what to learn",
                          style: txt14SemiWhite,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: isLoading == true
            ? Container(
                child: Center(
                  child: Image.asset(
                    "assets/images/loading.gif",
                    height: 40,
                  ),
                ),
              )
            : RefreshIndicator(
          onRefresh: () => getHomePageSuggestion(),
              child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          topCategory(),
                          banners(),
                          arrSuggestedCourse.isNotEmpty?Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 24, bottom: 8, right: 16),
                            child: Row(
                              children: [
                                Text(
                                  "Suggested courses",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewAllCourses()),
                                    );
                                  },
                                  child: Text(
                                    "View All",
                                    style: size14_700,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 10,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ):Container(),
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 15,
                            ),
                            shrinkWrap: true,
                            //  itemCount: 2,
                            itemCount: arrSuggestedCourse != null
                                ? arrSuggestedCourse.length
                                : 0,
                            itemBuilder: (context, index) {
                              final item = arrSuggestedCourse != null
                                  ? arrSuggestedCourse[index]
                                  : null;
                              return HomeCards(item, index);
                            },
                          ),
                          arrReels.isNotEmpty
                              ? Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 24, bottom: 8, right: 16),
                            child: Row(
                              children: [
                                Text(
                                  "Suggested shorts",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                                Spacer(),
                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               ShortsPlayerPage()),
                                //     );
                                //   },
                                //   child: Text(
                                //     "View All",
                                //     style: size14_700,
                                //   ),
                                // ),
                                SizedBox(
                                  width: 8,
                                ),
                                // Icon(
                                //   Icons.arrow_forward_ios_rounded,
                                //   size: 10,
                                //   color: Colors.black,
                                // )
                              ],
                            ),
                          ) :Container(),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 17, top: 2, bottom: 2),
                              child: HomeReels(
                                reelsArr: arrReels,
                              ),
                            ),
                          ),
                          arrSuggestedWorkshops.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 21, bottom: 8, right: 16),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Suggested workshops",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Nunito',
                                        ),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewAllWorkshopsNew()),
                                          );
                                        },
                                        child: Text(
                                          "View All",
                                          style: size14_700,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 10,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                          WorkshopForHome(
                            arrWorkshop: arrSuggestedWorkshops,
                          ),
                          arrSuggestedLiveBatch.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 21, bottom: 8, right: 16),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Suggested live batches",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Nunito',
                                        ),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewAllLiveClassesNew(
                                                        data: arrList)),
                                          );
                                        },
                                        child: Text(
                                          "View All",
                                          style: size14_700,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 10,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 15,
                            ),
                            shrinkWrap: true,
                            itemCount: arrSuggestedLiveBatch != null
                                ? arrSuggestedLiveBatch.length
                                : 0,
                            itemBuilder: (context, index) {
                              final item = arrSuggestedLiveBatch != null
                                  ? arrSuggestedLiveBatch[index]
                                  : null;
                              return LiveClassCards(item, index);
                            },
                          ),
                          h(16)
                        ],
                      ),
                    ),
                    Align(
                      child: resList.isNotEmpty
                          ? Container(
                              child: ContinueCourse(),
                            )
                          : Opacity(
                              opacity: 0,
                            ),
                      alignment: Alignment.bottomCenter,
                    )
                  ],
                ),
            ),
      ),
    );
  }

//  sliders
  Widget bannerss() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 10,left: 10,right: 10),
        child: Row(
          children: [
            Container(
              height: 180,
              width: 360,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                      image: AssetImage("assets/images/banner1.jpg"))),
            ),
            w(16),
            Container(
              height: 180,
              width: 360,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                      image: AssetImage("assets/images/banner2.jpg"))),
            ),
            w(16),
            Container(
              height: 180,
              width: 360,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                      image: AssetImage("assets/images/banner3.jpg"))),
            ),
          ],
        ),
      ),
    );
  }


  Widget banners(){
    return Padding(
      padding: const EdgeInsets.only(left: 10,top: 10,right: 15),
      child: SizedBox(
        height: 180,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(
            width: 10,
          ),
          shrinkWrap: true,
          itemCount: sliders != null ? sliders.length : 0,
          itemBuilder: (context, index) {
            final item = sliders != null ?sliders[index] : null;

            return GestureDetector(
              onTap: (){
                print("taaaap");
                print(item['targetType'].toString());
                if(item['targetType'].toString()=="OPENLINK"){
                  FlutterWebBrowser.openWebPage(
                    url:  item['targetId'],
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
                    safariVCOptions: SafariViewControllerOptions(
                      barCollapsingEnabled: true,
                      preferredBarTintColor: Colors.green,
                      preferredControlTintColor: Colors.amber,
                      dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
                      modalPresentationCapturesStatusBarAppearance: true,
                    ),
                  );
                }
                if(item['targetType'].toString()=="COURSE"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayerScreen(
                          id: item['id'].toString(),
                          cuid: item['targetId'].toString(),
                        )),
                  );
                }
                if(item['targetType'].toString()=="BATCH"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LiveClassScreen(
                          id: item['targetId'].toString(),
                          item: item,
                        )),
                  );
                }
              },
              child: Container(
                height: 180,
                width: 360,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                        image: NetworkImage(item['url'].toString()))),
              ),
            );
          },
        ),
      ),
    );
  }
  HomeCards(var item, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayerScreen(
                    id: item['id'].toString(),
                    cuid: item['courseUid'].toString(),
                  )),
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LiveClassScreen()),
        // );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 17, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1.5,
              blurRadius: 5,
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0xfffaf6f5)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        item['thumbnailUrl'].toString()),
                                    fit: BoxFit.cover)),
                            height: 62,
                            width: 62,
                          ),
                        ),
                        w(16),
                        Expanded(
                          child: Text(
                            item['courseNameEng'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Mallu',
                                fontWeight: FontWeight.w700,
                                color: darkBlue),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            item['chaptersCount'].toString() + " chapters",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito',
                                color: darkBlue),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                                height: 12, width: 2, color: darkBlue),
                          ),
                          Text(
                            item['totalVideolength'].toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Nunito',
                                color: darkBlue),
                          )
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TutorInfo(id: item['authorId'].toString())),
                          );
                        },
                        child: Text(
                          item['tutorName'].toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TutorInfo(id: item['authorId'].toString())),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Color(0xfffaf6f5)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      item['tutorProfileImage'].toString()),
                                  fit: BoxFit.cover)),
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 7,
            ),
            item['announceText'] != null
                ? Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: gradientGreen,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        item['announceText'].toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff2FB134)),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  LiveClassCards(var item, int index) {
    return GestureDetector(
      onTap: () {
        print("tapppppppp");
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LiveClassScreen()),
        // );
        //-----------------------------------------------
        if(item['isApplied'].toString() ==
            "true" &&
            item['startFlag'] == "1"){
          print("yessssssss");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LiveClassScreen(
                  id: item['courseUid'].toString(),
                  item: item,
                )),
          );

        }else{
          print("nooooo");

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => liveBatchesBriefPage(
                  item: item,
                )),
          );
        }

        //-----------------------------------------------

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => PlayerScreen(
        //         id: item['id'].toString(),
        //         cuid: item['courseUid'].toString(),
        //       )),
        // );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 17, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1.5,
              blurRadius: 5,
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['courseNameEng'].toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Mallu',
                                    fontWeight: FontWeight.w700,
                                    color: darkBlue),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0xfffaf6f5)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        item['thumbnailUrl'].toString()),
                                    fit: BoxFit.cover)),
                            height: 62,
                            width: 93,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            item['courseDuration'].toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito',
                                color: darkBlue),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                                height: 12, width: 2, color: darkBlue),
                          ),
                          Text(
                            item['totalVideolength'].toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Nunito',
                                color: darkBlue),
                          )
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TutorInfo(id: item['authorId'].toString())),
                          );
                        },
                        child: Text(
                          item['tutorName'].toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TutorInfo(id: item['authorId'].toString())),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Color(0xfffaf6f5)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      item['tutorProfileImage'].toString()),
                                  fit: BoxFit.cover)),
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 7,
            ),
            item['announceText'] != null
                ? Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: gradientGreen,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        item['announceText'].toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff2FB134)),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget shimmer() {
    return Positioned(
        bottom: 0,
        left: 0,
        child: Card(
          // elevation: 6,
          margin: EdgeInsets.symmetric(horizontal: 17, vertical: 2),
          color: Color(0xffFBA33A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), bottomLeft: Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            child: Text("Enroll now for free!",
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        ));
  }

  Widget LangTop({Color clr}) {
    return Positioned(
        top: 0,
        right: 0,
        child: Card(
          // elevation: 6,
          margin: EdgeInsets.symmetric(horizontal: 17, vertical: 2),
          color: Color(0xffFBA33A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), bottomLeft: Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            child: Text("Free",
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ),
        ));
  }

  Widget ContinueCourse() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayerScreen(
                    id: resList[0]['id'].toString(),
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: darkBlue),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "Continue your course",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffFCFCFC)),
                  ),
                  Spacer(),
                  Image(
                    image: NetworkImage(resList[0]['progressImg'] != null
                        ? resList[0]['progressImg'].toString()
                        : "https://www.freeiconspng.com/uploads/green-video-play-icon-13.jpeg"),
                    height: 15,
                    width: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    resList[0]['percentageCompleted'].toString(),
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffFCFCFC)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        resList.clear();
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        image: DecorationImage(
                            image: NetworkImage(resList[0]['thumbnailUrl'] !=
                                    null
                                ? resList[0]['thumbnailUrl'].toString()
                                : "https://www.freeiconspng.com/uploads/green-video-play-icon-13.jpeg"),
                            fit: BoxFit.cover)),
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resList[0]['courseNameEng'].toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Mallu',
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFCFCFC)),
                        ),
                        Text(
                          resList[0]['courseNameMal'].toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffFCFCFC)),
                          maxLines: 1,
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void SuccessPurchase() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(12)),
        elevation: 10,
        // title: Text(
        //   'Payment Successful',
        //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        // ),
        content: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Stack(
                children: [
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    top: 5,
                    right: 0,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset('assets/images/success.json',
                            height: 80, width: 80, repeat: false),
                        Text(
                          'Your registration has been successful!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'You are enrolled for',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Course name",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Happy Learning!',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget topCategory() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewAllCourses()),
                );
              },
              child: Container(
                height: 123,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2, top: 2),
                      child: Container(
                        height: 86,
                        width: 113,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          "assets/svg/courseExp.svg",
                          height: 86,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffFFFBEB),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Courses",
                        style: size14_700,
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xffFFFBEB),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1.5,
                      blurRadius: 5,
                      offset: Offset(0, 1),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ViewAllLiveClassesNew(data: arrList)),
                );
              },
              child: Container(
                height: 123,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2, top: 2),
                      child: Container(
                        height: 86,
                        width: 113,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          "assets/svg/liveExp.svg",
                          height: 86,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffF3FFF2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Live Batches",
                        style: size14_700,
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xffF3FFF2),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1.5,
                      blurRadius: 5,
                      offset: Offset(0, 1),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewAllWorkshopsNew()),
                );
              },
              child: Container(
                height: 123,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2, top: 2),
                      child: Container(
                        height: 86,
                        width: 113,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          "assets/svg/wrkshpExp.svg",
                          height: 86,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffEBF5FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Workshops",
                        style: size14_700,
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xffEBF5FF),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1.5,
                      blurRadius: 5,
                      offset: Offset(0, 1),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
