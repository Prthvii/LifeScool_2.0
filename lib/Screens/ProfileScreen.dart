import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifescool/Api/getUser.dart';
import 'package:lifescool/Api/myCourse.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/ProfileTabs/AllTab.dart';
import 'package:lifescool/ProfileTabs/CompletedTab.dart';
import 'package:lifescool/ProfileTabs/InProgressTab.dart';
import 'package:lifescool/Screens/PlayerScreen.dart';
import 'package:lifescool/Screens/Settings.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  // const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var arrList = [];

  var isLoading = true;
  var name;
  var phn;
  var dob;
  var mobileNumber;

  //List<dynamic> data = [];
  @override
  void initState() {
    super.initState();

    print("xoxoxo");
    this.getProfile();
    this.getHome();

    setState(() {});
  }

  Future<String> getProfile() async {
    var rsp = await getUserApi();
    print("Profileeeeeeeeeeeeeeee");
    print(rsp);
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        name = rsp['attributes']['studentInfo']['fullname'];
        dob = rsp['attributes']['studentInfo']['dob'];
        mobileNumber = rsp['attributes']['studentInfo']['mobileNumber'];
      });
    }

    setState(() {
      isLoading = false;
    });
    return "0";
  }

  Future<String> getHome() async {
    var rsp = await myCourseApi();
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp != 0 && rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrList = rsp['attributes']['subscribedCourses'];

        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();
      });
      print("arrProdList");
      print(arrList);
    }

    setState(() {
      isLoading = false;
    });
    return "0";
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: isLoading == true
          ? Container(
              child: Center(
                child: Image.asset(
                  "assets/images/loading.gif",
                  height: 40,
                ),
              ),
            )
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      gradient: gradientLeftRyt,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 18,
                                  )),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Settings()),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                      size: 18,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _appBarElement(
                                    Icons.person,
                                    name != null ? name : "",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _appBarElement2(
                                    CupertinoIcons.phone_fill,
                                    mobileNumber != null ? mobileNumber : "",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              GestureDetector(
                                child: Text(
                                  "Contact Support",
                                  style: profileToptxt,
                                ),
                                onTap: () async {
                                  var url = 'tel:' + "9459452255";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    showToastSuccess("Unable to make call");
                                    throw 'Could not launch $url';
                                  }
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var url = 'mailto:' + "mail@lifescool.app";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    showToastSuccess("Unable to create email");
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Text(
                                  "Share Feedback",
                                  style: profileToptxt,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    _openPlay();
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                    size: 18,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            top: 20,
                            bottom: 10,
                          ),
                          child: Text(
                            "Courses",
                            style: bold16DarkBlue,
                          ),
                        ),
                        _tabs(),
                      ],
                    ),
                  ),
                  // arrList.length != 0
                  //     ? Expanded(
                  //         child: ListView.separated(
                  //           scrollDirection: Axis.vertical,
                  //           physics: BouncingScrollPhysics(),
                  //           separatorBuilder: (context, index) => SizedBox(
                  //             height: 10,
                  //           ),
                  //           shrinkWrap: true,
                  //           //itemCount: 10,
                  //
                  //           itemCount: arrList != null ? arrList.length : 0,
                  //           itemBuilder: (context, index) {
                  //             final item =
                  //                 arrList != null ? arrList[index] : null;
                  //             return list(item, index);
                  //           },
                  //         ),
                  //       )
                  //     : Expanded(
                  //         child: Center(
                  //         child: Text("No Course Subscribed yet!"),
                  //       )),
                ],
              ),
            ),
    );
  }

  Widget _appBarElement(IconData iccon, String txt) {
    return Row(
      children: [
        Icon(
          iccon,
          color: Colors.white,
          size: 20,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          txt,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  Widget _appBarElement2(IconData iccon, String txt) {
    return Row(
      children: [
        Icon(
          iccon,
          color: Colors.white,
          size: 20,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          txt,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  list(var item, int index) {
    return GestureDetector(
      onTap: () {
        print('tap');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayerScreen(
                    id: item['id'].toString(),
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          boxShadow: [shadw],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  img(item['thumbnailUrl'].toString()),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          item['courseNameEng'].toString(),
                          style: bold14,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          item['courseNameMal'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: bold14,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    item['tutorName'].toString(),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Text(
                    item['learningStatus'].toString(),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget img(var img) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)),
      height: 35,
      width: 35,
    );
  }

  Widget _tabs() {
    return DefaultTabController(
      length: 3,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              labelColor: Color(0xff2F455C),
              labelStyle: TextStyle(
                  color: Color(0xff2F455C),
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w900),
              unselectedLabelStyle: TextStyle(
                  color: Color(0xff141215),
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w500),
              tabs: [
                Tab(
                  text: "All",
                ),
                Tab(
                  text: "In-progress",
                ),
                Tab(
                  text: "Completed",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AllTab(),
                  InProgresstab(),
                  CompletedTab(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _openPlay() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.lifeplug.lifeschool';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
