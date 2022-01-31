import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Screens/Settings.dart';

import 'HomePage.dart';
import 'MyLearningTabs/Upcoming.dart';

class MyLearningNew extends StatefulWidget {
  const MyLearningNew({Key key}) : super(key: key);

  @override
  _MyLearningNewState createState() => _MyLearningNewState();
}

class _MyLearningNewState extends State<MyLearningNew> {
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
            Text("Rose MJ", style: size14_700),
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
              ),
            ),
            h(20),
            Expanded(child: Upcoming()),
          ],
        ),
      ),
    );
  }
}
