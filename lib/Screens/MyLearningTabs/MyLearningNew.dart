import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifescool/Api/getUser.dart';
import 'package:lifescool/Api/searchItem.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Screens/LiveClasses/LiveBatchesBriefPage.dart';
import 'package:lifescool/Screens/MyLearningTabs/Data/myLearning.dart';
import 'package:lifescool/Screens/PlayerScreen.dart';
import 'package:lifescool/Screens/Settings.dart';
import 'package:lifescool/Screens/TutorInfo.dart';

import '../HomePage.dart';
import 'Upcoming.dart';

class MyLearningNew extends StatefulWidget {
  const MyLearningNew({Key key}) : super(key: key);

  @override
  _MyLearningNewState createState() => _MyLearningNewState();
}

class _MyLearningNewState extends State<MyLearningNew> {
  final dataKeyUpcoming = new GlobalKey();
  final dataKeyOngoing = new GlobalKey();
  final dataKeyCompleted= new GlobalKey();
  var isSelected = 1;
  var arrUpcoming = [];
  var arrOngoing = [];
  var arrCompleted = [];

 var userName="";
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
        arrUpcoming =rsp['attributes']['upcoming'];
        arrOngoing =rsp['attributes']['ongoing'];
        arrCompleted =rsp['attributes']['completed'];


      });
      print("searchhhhhhhh");
      print(arrUpcoming);
    } else {

    }

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
    return Scaffold(

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
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: themeOrange,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text("Settings", style: size14_700W),
                ),
              ),
            )
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
              child: Row(
                children: [
                  Container(
                    height: 56,
                    width: 117,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: lifescool_highlight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/svg/saved.svg", height: 17),
                        h(4),
                        Text("Saved", style: size14_700Red)
                      ],
                    ),
                  ),
                  w(16),
                  Container(
                    height: 56,
                    width: 117,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: lifescool_highlight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/svg/certi.svg", height: 17),
                        h(4),
                        Text("Certificates", style: size14_700Red)
                      ],
                    ),
                  ),
                ],
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
                              "You earn upto 25 for referring a friend and your friend gets 250. You recieve a reward for 300 when they enroll in a course.",
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
                    onTap: (){
                      setState(() {
                        isSelected=1;
                      });
                      Scrollable.ensureVisible(dataKeyUpcoming.currentContext);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isSelected==1?Color(0xffFEE9E4):greyClr),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text("Upcoming", style: txt16_700Orng),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isSelected=2;
                      });

                      Scrollable.ensureVisible(dataKeyOngoing.currentContext);

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isSelected==2?Color(0xffFEE9E4):greyClr),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text("Ongoing", style: txt16_700Orng),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isSelected=3;
                      });

                      Scrollable.ensureVisible(dataKeyCompleted.currentContext);

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isSelected==3?Color(0xffFEE9E4):greyClr),
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
            arrUpcoming.isNotEmpty?Text( "Upcoming ("+arrUpcoming.length.toString()+")", style: size14_700, key: dataKeyUpcoming ):Container(),
            h(8),
            Upcoming(),
            h(24),
            arrOngoing.isNotEmpty?Text("Ongoing ("+arrOngoing.length.toString()+")", style: size14_700,key: dataKeyOngoing):Container(),
            h(8),
            Ongoing(),
            h(24),
            arrCompleted.isNotEmpty?Text("Completed ("+arrCompleted.length.toString()+")", style: size14_700, key: dataKeyCompleted,):Container(),
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
        return UpcomingList(item,index);
      },
    );
  }

  UpcomingList(var item,int index) {
    return GestureDetector(
      onTap: (){
        var grade = item['type'].toString();
        switch(grade) {
          case "Course": {

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

          case "Workshop": {



          }
          break;

          case "Live batch": {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => liveBatchesBriefPage(item: item,)),
            );

          }
          break;



          default: { print("Invalid choice"); }
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
                      item['type']=="Course"?Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: NetworkImage(item['progressImg'] != null
                                ?item['progressImg'].toString()
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
                      ): Row(
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
                                  image: NetworkImage(item['tutorProfileImage'].toString()),
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
        return OngoingList(item,index);
      },
    );
  }

  OngoingList(var item,int index) {
    return GestureDetector(
      onTap: (){
        var grade = item['type'].toString();
        switch(grade) {
          case "Course": {

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

          case "Workshop": {



          }
          break;

          case "Live batch": {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => liveBatchesBriefPage(item: item,)),
            );

          }
          break;



          default: { print("Invalid choice"); }
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
                      item['type']=="Course"?Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: NetworkImage(item['progressImg'] != null
                                ?item['progressImg'].toString()
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
                      ): Row(
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
                                  image: NetworkImage(item['tutorProfileImage'].toString()),
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
        return CompletedList(item,index);
      },
    );
  }

  CompletedList(var item,int index) {
    return GestureDetector(
      onTap: (){
        var grade = item['type'].toString();
        switch(grade) {
          case "Course": {

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

          case "Workshop": {



          }
          break;

          case "Live batch": {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => liveBatchesBriefPage(item: item,)),
            );

          }
          break;



          default: { print("Invalid choice"); }
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
                      item['type']=="Course"?Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: NetworkImage(item['progressImg'] != null
                                ?item['progressImg'].toString()
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
                      ): Row(
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
                                  image: NetworkImage(item['tutorProfileImage'].toString()),
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
