import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifescool/Api/getUser.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Screens/LiveClasses/LiveBatchesBriefPage.dart';
import 'package:lifescool/Screens/LiveClasses/LiveClassScreen.dart';
import 'package:lifescool/Screens/MyLearningTabs/Data/myLearning.dart';
import 'package:lifescool/Screens/MyLearningTabs/SavedShortsMyLearning.dart';
import 'package:lifescool/Screens/PlayerScreen.dart';
import 'package:lifescool/Screens/Settings.dart';
import 'package:lifescool/Screens/TutorInfo/TutorInfo.dart';
import 'package:lifescool/Shorts/ShortVideoPage.dart';

import '../HomePage.dart';

class MyLearningNew2 extends StatefulWidget {
  const MyLearningNew2({Key key}) : super(key: key);

  @override
  _MyLearningNew2State createState() => _MyLearningNew2State();
}

class _MyLearningNew2State extends State<MyLearningNew2> {
  final dataKeyUpcoming = new GlobalKey();
  final dataKeyOngoing = new GlobalKey();
  final dataKeyCompleted = new GlobalKey();
  var isSelected = 1;
  var arrUpcoming = [];
  var arrOngoing = [];
  var arrCompleted = [];

  var userName = "";
  var isLoading = true;

  @override
  void initState() {
    super.initState();

    print("xoxoxo");
    this.getData();
    this.getProfile();

    setState(() {});
  }

  Future<String> getData() async {
    setState(() {
      isLoading = true;
    });
    print("searchhhhhhhh");

    var rsp = await myLearningApi();
    print("searchhhhhhhh");
    print(rsp);

    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrUpcoming = rsp['attributes']['upcoming'];
        arrOngoing = rsp['attributes']['ongoing'];
        arrCompleted = rsp['attributes']['completed'];
      });
      print("searchhhhhhhh");
      print(arrUpcoming);
    } else {}

    setState(() {
      isLoading = false;
    });
    return "0";
  }

  Future<String> getProfile() async {
    var rsp = await getUserApi();
    print("Profileeeeeeeeeeeeeeee");
    print(rsp);
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        userName = rsp['attributes']['studentInfo']['fullname'];
        // dob = rsp['attributes']['studentInfo']['dob'];
        // mobileNumber = rsp['attributes']['studentInfo']['mobileNumber'];
      });
    }

    setState(() {
      isLoading = false;
    });
    return "0";
  }

  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
            // height: 78,
            height: 78,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ss.width * 0.06),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
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
                            Icon(
                              Icons.play_circle_outline,
                              color: themeOrange,
                              size: 20,
                            ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              // builder: (context) => MyLearningNew()),
                              builder: (context) => HomeScreen()),
                        );
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                  Icons.lightbulb_outline,
                                  color: themeOrange,
                                  size: 20,
                                ),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: greyBG,
              radius: 22,
              child: Icon(
                Icons.person,
                color: Color(0xff848484),
                size: 20,
              ),
            ),
            w(16),
            Text(userName, style: size14_700),
            Spacer(),
            Icon(Icons.notifications, color: lifescoolBlue, size: 20),
            w(16),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  );
                },
                icon: Icon(Icons.settings, color: lifescoolBlue, size: 20))
          ],
        ),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        },
        child: Column(
          children: [
            h(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SavedShorts()),
                  );
                },
                child: Container(
                  height: 56,
                  width: double.infinity,
                  // width: 117,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: lifescool_highlight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/svg/saved.svg", height: 17),
                      w(12),
                      Text("Saved Shorts", style: size14_700Red)
                    ],
                  ),
                ),
              ),
            ),
            h(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 107,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffB6B6B6))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/refer.svg",
                        height: 60,
                      ),
                      w(22),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Refer a friend & earn rewards",
                                style: size14_700),
                            h(4),
                            Text(
                              "You earn upto 25 for referring a friend and your friend gets 250. You receive a reward for 300 when they enroll in a course.",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff3E3E3E)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            h(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected = 1;
                      });
                      Scrollable.ensureVisible(dataKeyUpcoming.currentContext);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isSelected == 1 ? Color(0xffFEE9E4) : greyClr),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text("Upcoming", style: txt16_700Orng),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected = 2;
                      });

                      Scrollable.ensureVisible(dataKeyOngoing.currentContext);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isSelected == 2 ? Color(0xffFEE9E4) : greyClr),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text("Ongoing", style: txt16_700Orng),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected = 3;
                      });

                      Scrollable.ensureVisible(dataKeyCompleted.currentContext);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isSelected == 3 ? Color(0xffFEE9E4) : greyClr),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text("Completed", style: txt16_700Orng),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            h(20),
            Expanded(child: FullScroll()),
          ],
        ),
      ),
    );
  }

  FullScroll() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            arrUpcoming.isNotEmpty
                ? Text("Upcoming (" + arrUpcoming.length.toString() + ")",
                    style: size14_700, key: dataKeyUpcoming)
                : Container(),
            h(8),
            Upcoming(),
            h(24),
            arrOngoing.isNotEmpty
                ? Text("Ongoing (" + arrOngoing.length.toString() + ")",
                    style: size14_700, key: dataKeyOngoing)
                : Container(),
            h(8),
            Ongoing(),
            h(24),
            arrCompleted.isNotEmpty
                ? Text(
                    "Completed (" + arrCompleted.length.toString() + ")",
                    style: size14_700,
                    key: dataKeyCompleted,
                  )
                : Container(),
            h(8),
            Completed()
          ],
        ),
      ),
    );
  }

  Upcoming() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(
        height: 16,
      ),
      shrinkWrap: true,
      itemCount: arrUpcoming != null ? arrUpcoming.length : 0,
      itemBuilder: (context, index) {
        final item = arrUpcoming != null ? arrUpcoming[index] : null;
        return UpcomingList(item, index);
      },
    );
  }

  UpcomingList(var item, int index) {
    return GestureDetector(
      onTap: () {
        var grade = item['type'].toString();
        switch (grade) {
          case "Course":
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlayerScreen(
                          id: item['id'].toString(),
                          cuid: item['courseUid'].toString(),
                        )),
              );
            }
            break;

          case "Workshop":
            {}
            break;

          case "Live batch":
            {



              // if(item['isApplied'].toString() ==
              //     "true" &&
              //     item['startFlag'] == "1"){
              //
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => LiveClassScreen(
              //           id: item['courseUid'].toString(),
              //           item: item,
              //         )),
              //   );
              //
              // }

             // else{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => liveBatchesBriefPage(
                        item: item,
                      )),
                );
           //   }

            }
            break;

          default:
            {
              print("Invalid choice");
            }
            break;
        }
      },
      child: Container(
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['type'].toString(),
                    style: size14_700Red,
                  ),
                  h(8),
                  Text(
                    item['courseNameEng'].toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Mallu',
                        fontWeight: FontWeight.bold,
                        color: darkBlue),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      item['type'] == "Course"
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: NetworkImage(item['progressImg'] !=
                                          null
                                      ? item['progressImg'].toString()
                                      : "https://www.freeiconspng.com/uploads/green-video-play-icon-13.jpeg"),
                                  height: 15,
                                  width: 15,
                                ),
                                w(5),
                                Text(
                                  item['learningProgress'],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Nunito',
                                      color: darkBlue),
                                ),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_today,
                                    size: 13, color: themeOrange),
                                w(5),
                                Text(
                                  item['displayText'],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Nunito',
                                      color: darkBlue),
                                ),
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
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
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
          ],
        ),
      ),
    );
  }

  Ongoing() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(
        height: 16,
      ),
      shrinkWrap: true,
      itemCount: arrOngoing != null ? arrOngoing.length : 0,
      itemBuilder: (context, index) {
        final item = arrOngoing != null ? arrOngoing[index] : null;
        return OngoingList(item, index);
      },
    );
  }

  OngoingList(var item, int index) {
    return GestureDetector(
      onTap: () {
        var grade = item['type'].toString();
        switch (grade) {
          case "Course":
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlayerScreen(
                          id: item['id'].toString(),
                          cuid: item['courseUid'].toString(),
                        )),
              );
            }
            break;

          case "Workshop":
            {}
            break;

          case "Live batch":
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => liveBatchesBriefPage(
                          item: item,
                        )),
              );
            }
            break;

          default:
            {
              print("Invalid choice");
            }
            break;
        }
      },
      child: Container(
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['type'].toString(),
                    style: size14_700Red,
                  ),
                  h(8),
                  Text(
                    item['courseNameEng'].toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Mallu',
                        fontWeight: FontWeight.bold,
                        color: darkBlue),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      item['type'] == "Course"
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: NetworkImage(item['progressImg'] !=
                                          null
                                      ? item['progressImg'].toString()
                                      : "https://www.freeiconspng.com/uploads/green-video-play-icon-13.jpeg"),
                                  height: 15,
                                  width: 15,
                                ),
                                w(5),
                                Text(
                                  item['learningProgress'],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Nunito',
                                      color: darkBlue),
                                ),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_today,
                                    size: 13, color: themeOrange),
                                w(5),
                                Text(
                                  item['displayText'],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Nunito',
                                      color: darkBlue),
                                ),
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
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
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
          ],
        ),
      ),
    );
  }

  Completed() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(
        height: 16,
      ),
      shrinkWrap: true,
      itemCount: arrCompleted != null ? arrCompleted.length : 0,
      itemBuilder: (context, index) {
        final item = arrCompleted != null ? arrCompleted[index] : null;
        return CompletedList(item, index);
      },
    );
  }

  CompletedList(var item, int index) {
    return GestureDetector(
      onTap: () {
        var grade = item['type'].toString();
        switch (grade) {
          case "Course":
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlayerScreen(
                          id: item['id'].toString(),
                          cuid: item['courseUid'].toString(),
                        )),
              );
            }
            break;

          case "Workshop":
            {}
            break;

          case "Live batch":
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => liveBatchesBriefPage(
                          item: item,
                        )),
              );
            }
            break;

          default:
            {
              print("Invalid choice");
            }
            break;
        }
      },
      child: Container(
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['type'].toString(),
                    style: size14_700Red,
                  ),
                  h(8),
                  Text(
                    item['courseNameEng'].toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Mallu',
                        fontWeight: FontWeight.bold,
                        color: darkBlue),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      item['type'] == "Course"
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: NetworkImage(item['progressImg'] !=
                                          null
                                      ? item['progressImg'].toString()
                                      : "https://www.freeiconspng.com/uploads/green-video-play-icon-13.jpeg"),
                                  height: 15,
                                  width: 15,
                                ),
                                w(5),
                                Text(
                                  item['learningProgress'],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Nunito',
                                      color: darkBlue),
                                ),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_today,
                                    size: 13, color: themeOrange),
                                w(5),
                                Text(
                                  item['displayText'],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Nunito',
                                      color: darkBlue),
                                ),
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
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
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
          ],
        ),
      ),
    );
  }
}
