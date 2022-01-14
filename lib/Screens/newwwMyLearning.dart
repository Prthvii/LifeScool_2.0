import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Screens/HomePage.dart';
import 'package:lifescool/Screens/MyLearningTabs/Upcoming.dart';
import 'package:lifescool/Shorts/ShortVideoPage.dart';

import 'Settings.dart';

class NewwwLearingg extends StatefulWidget {
  const NewwwLearingg({Key key}) : super(key: key);

  @override
  _NewwwLearinggState createState() => _NewwwLearinggState();
}

class _NewwwLearinggState extends State<NewwwLearingg> {
  @override
  Widget build(BuildContext context) {
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
            height: MediaQuery.of(context).size.height * 0.1,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.06),
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffE6E6E6),
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.44,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: greyBG,
                            radius: 20,
                            child: Icon(
                              Icons.person,
                              color: Color(0xff848484),
                              size: 20,
                            ),
                          ),
                          w(16),
                          Text("Rose MJ", style: size14_700),
                          Spacer(),
                          Icon(Icons.share, color: lifescoolBlue, size: 20),
                          w(16),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Settings()),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: themeOrange,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Text("Settings", style: size14_700W),
                              ),
                            ),
                          )
                        ],
                      ),
                      h(16),
                      Row(
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
                                SvgPicture.asset("assets/svg/saved.svg",
                                    height: 17),
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
                                SvgPicture.asset("assets/svg/certi.svg",
                                    height: 17),
                                h(4),
                                Text("Certificates", style: size14_700Red)
                              ],
                            ),
                          ),
                        ],
                      ),
                      h(16),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xffB6B6B6))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/refer.svg",
                                height: 60,
                              ),
                              w(22),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
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
                    ),
                    Upcoming(),
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
