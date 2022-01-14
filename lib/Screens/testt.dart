import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifescool/Const/Constants.dart';

import 'MyLearningTabs/Upcoming.dart';
import 'Settings.dart';

class SomePage extends StatefulWidget {
  const SomePage({Key key}) : super(key: key);

  @override
  _SomePageState createState() => _SomePageState();
}

class _SomePageState extends State<SomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.1),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
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
              floating: true,
              backgroundColor: Colors.white,
              forceElevated: innerBoxIsScrolled,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    labelColor: themeOrange,
                    isScrollable: true,
                    unselectedLabelColor: Color(0xffFE5C36),
                    labelStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    unselectedLabelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                        color: Color(0xffFE5C36)),
                    indicator: BoxDecoration(
                      color: Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tabs: <Tab>[
                      Tab(
                        text: 'Upcoming',
                      ),
                      Tab(text: 'Ongoing'),
                      Tab(text: 'Completed'),
                    ],
                    controller: _tabController,
                  ),
                ),
              ),
            ),
          ];
        },
        body: Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Upcoming(),
              Container(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
