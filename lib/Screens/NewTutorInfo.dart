import 'package:flutter/material.dart';
import 'package:lifescool/Api/getAuther.dart';
import 'package:lifescool/Const/Constants.dart';

class TutorInfoNew extends StatefulWidget {
  final id;

  TutorInfoNew({this.id});
  @override
  _TutorInfoNewState createState() => _TutorInfoNewState();
}

class _TutorInfoNewState extends State<TutorInfoNew> {
  var arrList = [];
  var authorInfo;

  var isLoading = true;

  Future<String> getHome() async {
    var rsp = await getAutherApi(widget.id.toString());

    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrList = rsp['attributes']['authorCourses'];
        authorInfo = rsp['attributes']['authorInfo'];
      });
    }

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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 1,
          elevation: 0,
          backgroundColor: Colors.white,
          title: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xff2F455C),
                size: 23,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.31,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      authorInfo['profileImageUrl'].toString()),
                                  fit: BoxFit.contain)),
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authorInfo['authorName'].toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: blckClr),
                            ),
                            Text(
                              authorInfo['shortDescription'].toString(),
                              style: TextStyle(fontSize: 14, color: blckClr),
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
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      authorInfo['profile'].toString(),
                      style: TextStyle(
                          color: blckClr,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 16),
                    // TabBar(
                    //   labelColor: Colors.white,
                    //   unselectedLabelColor: Color(0xffFE5C36),
                    //   labelStyle: TextStyle(
                    //       fontSize: 14,
                    //       fontFamily: 'Nunito',
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white),
                    //   unselectedLabelStyle: TextStyle(
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.bold,
                    //       fontFamily: 'Nunito',
                    //       color: Color(0xffFE5C36)),
                    //   indicator: BoxDecoration(
                    //     color: Color(0xffE6E6E6),
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   tabs: [
                    //     Tab(
                    //       child: Text(
                    //         "Home",
                    //         style: TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w700,
                    //             color: themeOrange),
                    //       ),
                    //     ),
                    //     Tab(
                    //       child: Text(
                    //         "My Learning",
                    //         style: TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w700,
                    //             color: themeOrange),
                    //       ),
                    //     ),
                    //     Tab(
                    //       child: Text(
                    //         "My Learning",
                    //         style: TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w700,
                    //             color: themeOrange),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: greyClr),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text("Shorts", style: txt16_700Orng),
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: greyClr),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text("Courses", style: txt16_700Orng),
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: greyClr),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text("Workshop", style: txt16_700Orng),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, bottom: 16, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Shorts (8)", style: size14_700),
                        h8(),
                        Text("Playlists", style: txt12_400),
                        h8(),
                        playList(),
                        h16(),
                        Text("Videos", style: txt12_400),
                        h16(),
                        videos(),
                        h16(),
                        Text("Courses (8)", style: size14_700),
                        h8(),
                        Courses(),
                        h16(),
                        h8(),
                        Text("Workshops (1)", style: size14_700),
                        h8(),
                        Text("Upcoming", style: txt12_400),
                        h8(),
                        _upcomingWorkshops(),
                        h16(),
                        Text("Completed", style: txt12_400),
                        h8(),
                        _CompletedWorkshop(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _upcomingWorkshops() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(
        height: 16,
      ),
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) {
        return upcomingWrkList(index);
      },
    );
  }

  upcomingWrkList(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          Container(
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
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(wrkImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 18, right: 18, bottom: 7, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        // item['wctype'].toString() != "PAID"
                        //     ? Row(
                        //         children: [
                        //           Icon(
                        //             Icons.star,
                        //             size: 12,
                        //             color: hexToColor(
                        //                 item['prime_color'].toString()),
                        //           ),
                        //           SizedBox(
                        //             width: 3,
                        //           ),
                        //           Text(
                        //             "Free Workshop",
                        //             style: TextStyle(
                        //                 fontSize: 12,
                        //                 fontFamily: 'Nunito',
                        //                 fontWeight: FontWeight.bold,
                        //                 color: hexToColor(
                        //                     item['prime_color'].toString())),
                        //           )
                        //         ],
                        //       )
                        //     : Container(),
                        // SizedBox(
                        //   height: 3,
                        // ),
                        Text(
                          "ഗാർഡനിങ് : ഹോബിയ്ക്കപ്പുറം  പ്രൊഫഷണൽ ആയി തുടങ്ങുന്നതെങ്ങനെ? ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                              color: darkBlue),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "12" + " chapters",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Nunito',
                                      color: darkBlue),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                      height: 12, width: 1, color: darkBlue),
                                ),
                                Text(
                                  "1 hour",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Nunito',
                                      color: darkBlue),
                                )
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           TutorInfo(id: item['authorId'].toString())),
                                // );
                              },
                              child: Text(
                                "Geetha K",
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
                                    border:
                                        Border.all(color: Color(0xfffaf6f5)),
                                    image: DecorationImage(
                                        image: NetworkImage(testImg),
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
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: gradientRed,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Course free till Dec 25",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: themeOrange),
                    ),
                  ),
                )
              ],
            ),
          ),
          // shimmer()
        ],
      ),
    );
  }

  _CompletedWorkshop() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(
        height: 16,
      ),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return completedWrkshpList(index);
      },
    );
  }

  completedWrkshpList(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
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
                children: [
                  Container(
                    child: Text(
                      "ഗാർഡനിങ് : ഹോബിയ്ക്കപ്പുറം  പ്രൊഫഷണൽ ആയി തുടങ്ങുന്നതെങ്ങനെ? ",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Mallu',
                          fontWeight: FontWeight.bold,
                          color: darkBlue),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            "12" + " chapters",
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
                            "1 hour",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Nunito',
                                color: darkBlue),
                          )
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           TutorInfo(id: item['authorId'].toString())),
                          // );
                        },
                        child: Text(
                          "Geetha K",
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
                                  image: NetworkImage(testImg),
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

  Courses() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(
        height: 16,
      ),
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) {
        return _CoursesList(index);
      },
    );
  }

  _CoursesList(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
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
                                    image: NetworkImage(testImg),
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
                                "ഗാർഡനിങ് : ഹോബിയ്ക്കപ്പുറം  പ്രൊഫഷണൽ ആയി തുടങ്ങുന്നതെങ്ങനെ? ",
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            "12" + " chapters",
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
                            "1 hour",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Nunito',
                                color: darkBlue),
                          )
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           TutorInfo(id: item['authorId'].toString())),
                          // );
                        },
                        child: Text(
                          "Geetha K",
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
                                  image: NetworkImage(testImg),
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
                gradient: gradientRed,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Course free till Dec 25",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: themeOrange),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  h8() {
    return SizedBox(height: 8);
  }

  h16() {
    return SizedBox(height: 16);
  }

  playList() {
    return SizedBox(
      height: 225,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: 8,
        ),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return PlaylistItems(index);
        },
      ),
    );
  }

  PlaylistItems(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 188,
              width: 106,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(
                        "https://stylecaster.com/wp-content/uploads/2020/08/insta-reels.gif",
                      ),
                      fit: BoxFit.cover)),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 106,
                height: 42,
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      w8(),
                      Text(
                        "12",
                        style: size14_600W,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          width: 106,
          child: Text(
            "Easy Dancing videos list",
            style: size14_400,
            maxLines: 2,
          ),
        )
      ],
    );
  }

  videos() {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 10,
            childAspectRatio: 0.5),
        itemBuilder: (BuildContext context, int index) {
          return VideoItems(index);
        },
      ),
    );
  }

  VideoItems(int index) {
    return Container(
      height: 188,
      width: 106,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: NetworkImage(
                "https://stylecaster.com/wp-content/uploads/2020/08/insta-reels.gif",
              ),
              fit: BoxFit.cover)),
    );
  }

  w8() {
    return SizedBox(width: 8);
  }
}
