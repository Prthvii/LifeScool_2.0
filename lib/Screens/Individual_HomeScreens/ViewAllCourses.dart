import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifescool/Api/getUser.dart';
import 'package:lifescool/Api/listCourse.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';

import '../EnterNum.dart';
import '../NewTutorInfo.dart';
import '../PlayerScreen.dart';

class ViewAllCourses extends StatefulWidget {
  const ViewAllCourses({Key key}) : super(key: key);

  @override
  _ViewAllCoursesState createState() => _ViewAllCoursesState();
}

class _ViewAllCoursesState extends State<ViewAllCourses> {
  var arrList = [];
  var resList = [];

  var isLoading = true;
  var token;
  var id;

  //List<dynamic> data = [];
  @override
  void initState() {
    super.initState();

    print("xoxoxo");
    this.getProfile();
    setState(() {});
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
        getHome();
      } else {
        showToastSuccess(rsp['attributes']['message'].toString());

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EntNum()),
        );
      }
    } else {
      getHome();
    }

    return "0";
  }

  Future<String> getHome() async {
    var rsp = await listCourseApi();
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrList = rsp['attributes']['courselist'];
        resList = rsp['attributes']['resumeCourse'];
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(99),
        child: SafeArea(
          child: AppBar(
            backgroundColor: liteYellow,
            elevation: 0,
            titleSpacing: 1,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 22,
                              child: Icon(
                                Icons.arrow_back,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          w(12),
                          Text("Courses", style: size20_700),
                        ],
                      ),
                      h(24),
                      Text(
                        "Self paced Learning",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            color: Color(0xffCB9200)),
                      )
                    ],
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    "assets/svg/courseExp.svg",
                    height: 88,
                    width: 102,
                  )
                ],
              ),
            ),
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 110,
            child: Stack(
              children: [
                Container(
                  height: 70,
                  color: liteYellow,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                        "Recorded videos and additional resources that are accessible anytime, anywhere.",
                        style: size16_400),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    // bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: grey2)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Text("All", style: size14_600),
                            ),
                          ),
                          w(16),
                          Expanded(child: categoryList())
                        ],
                      ),
                    ))
              ],
            ),
          ),
          h(16),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                final item = arrList != null ? arrList[index] : null;
                return HomeCards(item, index);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget categoryList() {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        // physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => SizedBox(
          width: 10,
        ),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return newList(index);
        },
      ),
    );
  }

  newList(int index) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: grey2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                  "https://www.kindpng.com/picc/m/79-790695_landscape-icon-transparent-background-trees-icon-hd-png.png"),
              fit: BoxFit.contain,
              height: 32,
              width: 32,
            ),
            w(16),
            Text(
              "Gardening",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  HomeCards(var item, int index) {
    return Container(
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
                item['cwtype'].toString() != "PAID"
                    ? Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.star, size: 12, color: darkBlue),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Free Course",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                                color: darkBlue),
                          )
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayerScreen(
                                id: item['id'].toString(),
                                cuid: item['courseUid'].toString(),
                              )),
                    );
                  },
                  child: Container(
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
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              // Text(
                              //   item['courseNameMal'].toString(),
                              //   maxLines: 3,
                              //   overflow: TextOverflow.ellipsis,
                              //   style: TextStyle(
                              //       fontFamily: 'Nunito',
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.w600),
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayerScreen(
                                    id: item['id'].toString(),
                                    cuid: item['courseUid'].toString(),
                                  )),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            item['chaptersCount'].toString() + " chapters",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito',
                                color: darkBlue),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                                height: 12, width: 1, color: darkBlue),
                          ),
                          Text(
                            item['totalVideolength'].toString(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Nunito',
                                color: darkBlue),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TutorInfoNew(
                                  id: item['authorId'].toString())),
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           TutorInfo(id: item['authorId'].toString())),
                        // );
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
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: gradientYellow,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Course free till Dec 25",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffCB9200)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
