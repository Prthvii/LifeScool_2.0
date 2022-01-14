import 'package:flutter/material.dart';
import 'package:lifescool/Api/getAuther.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/colorConverter.dart';

import 'PlayerScreen.dart';

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
          backgroundColor: Color(0xffF6F6F6),
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      color: Color(0xffF6F6F6),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              authorInfo['profileImageUrl']
                                                  .toString()),
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
                                      style: TextStyle(
                                          fontSize: 14, color: blckClr),
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
                            TabBar(
                              labelColor: Colors.white,
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
                                color: Color(0xffE6E6E6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              tabs: [
                                Tab(
                                  child: Text(
                                    "Shorts",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: themeOrange),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Courses",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: themeOrange),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Workshops",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: themeOrange),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  Container(),
                                  Container(),
                                  Container(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 20, vertical: 20),
                    //   child: Text(
                    //     "Courses",
                    //     style: TextStyle(
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.bold,
                    //         color: Color(0xff2F455C)),
                    //   ),
                    // ),
                    // Flexible(child: listViewOld())
                  ],
                ),
              ),
      ),
    );
  }

  Widget listViewOld() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(
        height: 20,
      ),
      shrinkWrap: true,
      itemCount: arrList != null ? arrList.length : 0,
      itemBuilder: (context, index) {
        final item = arrList != null ? arrList[index] : null;
        return HomeCards(item, index);
      },
    );
  }

  HomeCards(var item, int index) {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 18),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Container(
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image:
                                  NetworkImage(item['thumbnailUrl'].toString()),
                              fit: BoxFit.cover)),
                      height: 80,
                      width: 80,
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
                              // fontWeight: FontWeight.bold,
                              color:
                                  hexToColor(item['primaryColor'].toString())),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          item['courseNameMal'].toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xfffaf6f5)),
                        image: DecorationImage(
                            image: NetworkImage(
                                item['tutorProfileImage'].toString()),
                            fit: BoxFit.cover)),
                    height: 36,
                    width: 36,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    item['tutorName'].toString(),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: hexToColor(item['primaryColor'].toString())),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['chaptersCount'].toString() + " chapters",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          Text(
                            item['totalVideolength'].toString(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )
                        ],
                      ),
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
}
