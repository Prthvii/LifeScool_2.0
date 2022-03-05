import 'package:flutter/material.dart';
import 'package:lifescool/Api/getAuther.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/colorConverter.dart';
import 'package:lifescool/Screens/TutorInfo/TutorInfoRest.dart';

import '../PlayerScreen.dart';

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
                                // setState(() {
                                //   isSelected = 1;
                                // });
                                // Scrollable.ensureVisible(dataKeyUpcoming.currentContext);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: greyClr
                                    // color: isSelected == 1 ? greyClr : Colors.white
                                    ),
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
                                // setState(() {
                                //   isSelected = 2;
                                // });
                                //
                                // Scrollable.ensureVisible(dataKeyOngoing.currentContext);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                    // color: isSelected == 1 ? greyClr : Colors.white
                                    ),
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
                                // setState(() {
                                //   isSelected = 3;
                                // });
                                //
                                // Scrollable.ensureVisible(dataKeyCompleted.currentContext);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                    // color: isSelected == 1 ? greyClr : Colors.white
                                    ),
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
                                // setState(() {
                                //   isSelected = 3;
                                // });
                                //
                                // Scrollable.ensureVisible(dataKeyCompleted.currentContext);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                    // color: isSelected == 1 ? greyClr : Colors.white
                                    ),
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
                    Expanded(child: TutorPageRestItems())
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