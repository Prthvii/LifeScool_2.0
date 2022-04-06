import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Screens/CourseIntro.dart';
import 'package:lifescool/Screens/LiveClasses/LiveBatchesBriefPage.dart';
import 'package:lifescool/Shorts/NewTstShortVideoPage.dart';
import 'package:lifescool/Shorts/ShortVideoPage.dart';

import '../PlayerScreen.dart';
import 'Data/getAuther.dart';

class TutorInfo extends StatefulWidget {
  final id;

  TutorInfo({this.id});

  @override
  _TutorInfoState createState() => _TutorInfoState();
}

class _TutorInfoState extends State<TutorInfo> {
  var arrList = [];
  var authorInfo;

  var isLoading = true;

  final dataKeyShorts = new GlobalKey();
  final dataKeyCourses = new GlobalKey();
  final dataKeyLive = new GlobalKey();
  final dataKeyWorkshop = new GlobalKey();
  var isSelected = 1;
  var arrShorts = [];
  var arrCourses = [];
  var arrLive = [];
  var arrWorkshop = [];

  Future<String> getHome() async {
    var rsp = await getAutherApi(widget.id.toString());

    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrList = rsp['attributes']['authorCourses'];
        authorInfo = rsp['attributes']['authorInfo'];

        arrShorts = rsp['attributes']['authorShorts'];
        arrCourses = rsp['attributes']['authorCourses'];
        arrLive = rsp['attributes']['authorLivebatches'];
        arrWorkshop = rsp['attributes']['authorworkshops'];
      });
    }
    print("arrShorts");
    print(arrShorts);
    setState(() {
      isLoading = false;
    });
    return "0";
  }

  @override
  void initState() {
    super.initState();
    this.getHome();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.1),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
          ),
        ),
        body: isLoading == true
            ? Container(
                child: Center(
                child: Image.asset(
                  "assets/images/loading.gif",
                  height: 40,
                ),
              ))
            : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(
                              backgroundColor: lifescool_highlight,
                              radius: 22,
                              child: Icon(
                                Icons.arrow_back,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          w(12),
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        authorInfo['profileImageUrl']
                                            .toString()),
                                    fit: BoxFit.contain)),
                            height: 44,
                            width: 44,
                          ),
                          w(16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authorInfo['authorName'].toString(),
                                style: size14_700,
                              ),
                              Text(
                                authorInfo['shortDescription'].toString(),
                                style: size14_400,
                              )
                            ],
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: themeOrange,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Text(
                                "Follow",
                                style: size14_700W,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Text(
                        authorInfo['profile'].toString(),
                        style: TextStyle(
                            color: blckClr,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    h(16),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelected = 1;
                                });
                                Scrollable.ensureVisible(
                                    dataKeyShorts.currentContext);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    //color: greyClr
                                    color: isSelected == 1
                                        ? greyClr
                                        : Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Text("Shorts", style: txt16_700Orng),
                                ),
                              ),
                            ),
                            // SizedBox(width: 16),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelected = 2;
                                });

                                Scrollable.ensureVisible(
                                    dataKeyCourses.currentContext);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    //  color: Colors.white
                                    color: isSelected == 2
                                        ? greyClr
                                        : Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Text("Courses", style: txt16_700Orng),
                                ),
                              ),
                            ),
                            // SizedBox(width: 16),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelected = 3;
                                });

                                Scrollable.ensureVisible(
                                    dataKeyLive.currentContext);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    //  color: Colors.white
                                    color: isSelected == 3
                                        ? greyClr
                                        : Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Text("Live Batches",
                                      style: txt16_700Orng),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelected = 4;
                                });

                                Scrollable.ensureVisible(
                                    dataKeyWorkshop.currentContext);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    //color: Colors.white
                                    color: isSelected == 4
                                        ? greyClr
                                        : Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child:
                                      Text("Workshops", style: txt16_700Orng),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    h(16),
                    Expanded(child: FullScroll())
                  ],
                ),
              ),
      ),
    );
  }

  FullScroll() {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            h(16),
            arrShorts.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      "Shorts",
                      key: dataKeyShorts,
                      style: size14_700,
                    ),
                  )
                : Container(),
            h(8),
            arrShorts.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      "Playlist",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  )
                : Container(),
            h(8),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                height: 240,
                child: Scrollbar(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10,
                    ),
                    shrinkWrap: true,
                    itemCount: arrShorts != null ? arrShorts.length : 0,
                    itemBuilder: (context, index) {
                      final item = arrShorts != null ? arrShorts[index] : null;
                      return shortsList(item, index);
                    },
                  ),
                ),
              ),
            ),
            h(16),
            arrShorts.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      "Videos",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  )
                : Container(),
            h(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                // height: 324,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  //  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 90 / 158),
                  itemCount: arrShorts != null ? arrShorts.length : 0,
                  itemBuilder: (context, index) {
                    final item = arrShorts != null ? arrShorts[index] : null;
                    return videosGrid(item, index);
                  },
                ),
              ),
            ),
            h(16),
            arrCourses.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                        "Courses (" + arrCourses.length.toString() + ")",
                        key: dataKeyCourses,
                        style: size14_700),
                  )
                : Container(),
            h(8),
            ListView.separated(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => h(8),
              shrinkWrap: true,
              itemCount: arrCourses != null ? arrCourses.length : 0,
              itemBuilder: (context, index) {
                final item = arrCourses != null ? arrCourses[index] : null;
                return CoursesList(item, index);
              },
            ),
            h(16),
            arrLive.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                        "Live Batches (" + arrLive.length.toString() + ")",
                        key: dataKeyLive,
                        style: size14_700),
                  )
                : Container(),
            h(8),
            ListView.separated(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => h(8),
              shrinkWrap: true,
              itemCount: arrLive != null ? arrLive.length : 0,
              itemBuilder: (context, index) {
                final item = arrLive != null ? arrLive[index] : null;
                return CoursesList(item, index);
              },
            ),
            h(16),
            arrLive.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                        "Workshops (" + arrWorkshop.length.toString() + ")",
                        key: dataKeyWorkshop,
                        style: size14_700),
                  )
                : Container(),
            h(8),
            arrWorkshop.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      "Upcoming",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  )
                : Container(),
            h(8),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
              shrinkWrap: true,
              itemCount: arrWorkshop != null ? arrWorkshop.length : 0,
              itemBuilder: (context, index) {
                final item = arrWorkshop != null ? arrWorkshop[index] : null;
                return workshopListUpcoming(item, index);
              },
            ),
            h(16),
            arrWorkshop.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      "Completed",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  )
                : Container(),
            h(8),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => h(16),
              shrinkWrap: true,
              itemCount: arrWorkshop != null ? arrWorkshop.length : 0,
              itemBuilder: (context, index) {
                final item = arrWorkshop != null ? arrWorkshop[index] : null;
                return WorkshopsCompleted(item, index);
              },
            ),
            h(30)
          ],
        ),
      ),
    );
  }

  shortsList(var item, int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  // builder: (context) => MyLearningNew()),
                  builder: (context) => ShortsPlayerPage(
                        highligts: item,
                      )),
            );
          },
          child: Container(
            height: 188,
            width: 106,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(item['thumbnail_url'].toString()),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
              color: themeOrange,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 42,
                    width: 106,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 20,
                          ),
                          w(8),
                          Text(" ", style: size14_600W)
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: Colors.black26),
                  ),
                )
              ],
            ),
          ),
        ),
        h(8),
        SizedBox(
          child: Text(
            item['title'].toString(),
            style: size14_400,
            maxLines: 2,
          ),
          width: 106,
        )
      ],
    );
  }

  videosGrid(var item, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              // builder: (context) => MyLearningNew()),
              builder: (context) => ShortsPlayerPage(
                    highligts: item,
                  )),
        );
      },
      child: Container(
        width: 90,
        height: 158,
        color: themeOrange,
        child:
            Image.network(item['thumbnail_url'].toString(), fit: BoxFit.cover),
      ),
    );
  }

  CoursesList(var item, int index) {
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['courseNameEng'].toString(),
                                style: size16_700Mallu,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
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
                            item['chaptersCount'].toString() + "chapters",
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
            // item['announceText'] != null
            //     ? Container(
            //         alignment: Alignment.centerLeft,
            //         width: double.infinity,
            //         decoration: BoxDecoration(
            //           gradient: gradientGreen,
            //           borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.circular(24),
            //               bottomRight: Radius.circular(24)),
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 16, vertical: 8),
            //           child: Text(
            //             item['announceText'].toString(),
            //             style: TextStyle(
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w700,
            //                 color: Color(0xff2FB134)),
            //           ),
            //         ),
            //       )
            //     : Container()
          ],
        ),
      ),
    );
  }

  LiveList(var item, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => liveBatchesBriefPage(
                    item: item,
                  )),
        );
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['courseNameEng'].toString(),
                                style: size16_700Mallu,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
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
            // item['announceText'] != null
            //     ? Container(
            //         alignment: Alignment.centerLeft,
            //         width: double.infinity,
            //         decoration: BoxDecoration(
            //           gradient: gradientGreen,
            //           borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.circular(24),
            //               bottomRight: Radius.circular(24)),
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 16, vertical: 8),
            //           child: Text(
            //             item['announceText'].toString(),
            //             style: TextStyle(
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w700,
            //                 color: Color(0xff2FB134)),
            //           ),
            //         ),
            //       )
            //     : Container()
          ],
        ),
      ),
    );
  }

  workshopListUpcoming(var item, int index) {
    final ss = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CourseIntro(
                    id: item['id'].toString(),
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
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
            Container(
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                image: DecorationImage(
                  image: NetworkImage(item['workshopThumbnail'].toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['workshopNameMalayalam'].toString(),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          color: lifescoolBlue),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            // Text(
                            //   "Nov 20",
                            //   style: size14_700Blue,
                            // ),
                            // Padding(
                            //   padding:
                            //   const EdgeInsets.symmetric(horizontal: 5),
                            //   child: Container(
                            //     height: 12,
                            //     width: 1,
                            //     color: lifescoolBlue,
                            //   ),
                            // ),
                            Text(
                              item['courseDuration'].toString(),
                              style: size14_400Blue,
                            )
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TutorInfo(
                                      id: item['authorId'].toString())),
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
                                  builder: (context) => TutorInfo(
                                      id: item['authorId'].toString())),
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
            ),
            // h(12),
            Container(
              alignment: Alignment.centerLeft,
              height: 32,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text("Enroll now for free", style: size12_700Blue),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24)),
                gradient: gradientBlue,
              ),
            )
          ],
        ),
      ),
    );
  }

  WorkshopsCompleted(var item, int index) {
    final ss = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CourseIntro(
                    id: item['id'].toString(),
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
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
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['workshopNameMalayalam'].toString(),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          color: lifescoolBlue),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            // Text(
                            //   "12" + " chapters",
                            //   style: size14_700Blue,
                            // ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 5),
                            //   child: Container(
                            //     height: 12,
                            //     width: 1,
                            //     color: lifescoolBlue,
                            //   ),
                            // ),
                            Text(
                              item['courseDuration'].toString(),
                              style: size14_400Blue,
                            )
                          ],
                        ),
                        Spacer(),
                        Text(
                          item['tutorName'].toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TutorInfo(
                                      id: item['authorId'].toString())),
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
            ),
          ],
        ),
      ),
    );
  }
}
