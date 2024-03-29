import 'package:flutter/material.dart';
import 'package:lifescool/Api/listCatAndSub.dart';
import 'package:lifescool/Api/searchItem.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/CourseIntro.dart';
import 'package:lifescool/Screens/PlayerScreen.dart';
import 'package:lifescool/Screens/SingleCourseScreen.dart';
import 'package:lifescool/Screens/TutorInfo/TutorInfo.dart';

import 'CategoryOpenedScreen.dart';

class FindCourse extends StatefulWidget {
  // const FindCourse({Key? key}) : super(key: key);

  @override
  _FindCourseState createState() => _FindCourseState();
}

class _FindCourseState extends State<FindCourse> {
  bool isExpanded = false;

  var arrList = [];

  bool isCourse = false;
  bool isWorkshop = false;
  bool isLiveBatch = false;
  var courselist = [];
  var workshoplist = [];
  var livebatchlist = [];

  var isSelected = 1;

  var catogeryItems = [];
  var isLoading = true;
  var isSearchActive = false;
  var token;
  var id;

  //List<dynamic> data = [];
  @override
  void initState() {
    super.initState();

    print("xoxoxo");
    this.getHome();

    setState(() {});
  }

  Future<String> getHome() async {
    var rsp = await listCatAndSub();
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrList = rsp['attributes']['categories'];

        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();
      });
      print("arrProdList");
      print(arrList);
    } else {
      showToastSuccess(rsp['attributes']['message'].toString());
    }

    setState(() {
      isLoading = false;
    });
    return "0";
  }

  Future<String> getsearch(cid, sid, key) async {
    setState(() {
      isLoading = true;
    });
    print("searchhhhhhhh");

    var rsp = await searchItemApi(cid, sid, key);
    print("searchhhhhhhh");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        courselist = rsp['attributes']['courselist'];
        workshoplist = rsp['attributes']['workshoplist'];
        livebatchlist = rsp['attributes']['livebatchlist'];

        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();
      });

      filterDown();
      print("searchhhhhhhh");
      print(courselist);
    } else {
      //showToastSuccess(rsp['attributes']['message'].toString());
    }

    setState(() {
      isLoading = false;
    });
    return "0";
  }

  Future<String> filterDown() async {

    if(workshoplist.isNotEmpty){
      isSelected=3;
    }

    if(livebatchlist.isNotEmpty){
      isSelected=2;
    }


    if(courselist.isNotEmpty){
      isSelected=1;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        titleSpacing: 1,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundColor: Color(0xffFEE9E4),
                  radius: 22,
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              w(8),
              Container(
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: greyClr,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      bottomLeft: Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24),
                          bottomRight: Radius.circular(24)),
                      color: greyClr),
                  child: TextField(
                    cursorColor: Colors.black54,
                    showCursor: true,
                    autofocus: false,
                    textInputAction: TextInputAction.go,
                    controller: searchController,
                    onEditingComplete: () {
                      setState(() {
                        isSearchActive = true;
                      });
                      getsearch("", "", searchController.text.toString());
                    },
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    decoration: new InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color:
                                isSearchActive == true ? Colors.black : greyClr,
                          ),
                          onPressed: () {
                            setState(() {
                              isSearchActive = false;
                            });
                          }),
                      border: InputBorder.none,
                      // prefixIcon: GestureDetector(
                      //   onTap: () {
                      //     getsearch(
                      //         "", "", searchController.text.toString());
                      //   },
                      //   child: Icon(
                      //     Icons.search,
                      //     size: 20,
                      //     color: Color(0xff2F455C),
                      //   ),
                      // ),
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff6D6D6D)),
                      hintText: "Search",
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
          :
          // searchList.isEmpty
          //         ? Opacity(
          //             opacity: 0,
          //           )
          //         :
          // listViewOld(),
          SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: isSearchActive == true ? listViewOld() : newListView(),
            )),
    );
  }

  // Widget listViewOld() {
  //   return ListView.separated(
  //     scrollDirection: Axis.vertical,
  //     physics: BouncingScrollPhysics(),
  //     separatorBuilder: (context, index) => SizedBox(
  //       height: 20,
  //     ),
  //     shrinkWrap: true,
  //     itemCount: courselist != null ? courselist.length : 0,
  //     itemBuilder: (context, index) {
  //       final item = courselist != null ? courselist[index] : null;
  //       return HomeCards(item, index);
  //     },
  //   );
  // }

  Widget listViewOld() {
    return Column(
      children: [
        h(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = 1;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: isSelected == 1 ? Color(0xffFEE9E4) : Colors.white,
                      border: Border.all(color: grey2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 19),
                    child: Text("Courses", style: size14_600),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = 2;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        color:
                            isSelected == 2 ? Color(0xffFEE9E4) : Colors.white,
                        border: Border.all(color: grey2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 19),
                      child: Text("Live Batches", style: size14_600),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = 3;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: isSelected == 3 ? Color(0xffFEE9E4) : Colors.white,
                      border: Border.all(color: grey2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 19),
                    child: Text("Workshops", style: size14_600),
                  ),
                ),
              ),
            ],
          ),
        ),
        h(16),
        Container(
            child: isSelected == 1
                ? Scrollbar(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                      shrinkWrap: true,
                      //  itemCount: 2,

                      itemCount: courselist != null ? courselist.length : 0,
                      itemBuilder: (context, index) {
                        final item =
                            courselist != null ? courselist[index] : null;
                        return HomeCards(item, index);
                      },
                    ),
                  )
                : isSelected == 2
                    ? Scrollbar(
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15,
                          ),
                          shrinkWrap: true,
                          //  itemCount: 2,

                          itemCount:
                              livebatchlist != null ? livebatchlist.length : 0,
                          itemBuilder: (context, index) {
                            final item = livebatchlist != null
                                ? livebatchlist[index]
                                : null;
                            return HomeCards(item, index);
                          },
                        ),
                      )
                    : Scrollbar(
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15,
                          ),
                          shrinkWrap: true,
                          //  itemCount: 2,

                          itemCount:
                              workshoplist != null ? workshoplist.length : 0,
                          itemBuilder: (context, index) {
                            final item = workshoplist != null
                                ? workshoplist[index]
                                : null;
                            return workshopCard(item, index);
                          },
                        ),
                      )),
        h(16)
      ],
    );
  }

  Widget newListView() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) => SizedBox(
        height: 24,
      ),
      shrinkWrap: true,
      itemCount: arrList != null ? arrList.length : 0,
      itemBuilder: (context, index) {
        final item = arrList != null ? arrList[index] : null;
        return newList(item, index);
      },
    );
  }

  newList(var item, int index) {
    return GestureDetector(
      onTap: () {
        print("tappp");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoryOpenedScreen(
                    id: item['id'].toString(),
                name: item['categoryName'].toString() ,
                  )),
        );
      },
      child: Container(
        height: 56,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Image(
                image: NetworkImage(item['categoryIconUrl'].toString()),
                fit: BoxFit.contain,
                height: 32,
                width: 32,
              ),
              w(16),
              Text(
                item['categoryName'].toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 18,
              )
            ],
          ),
        ),
      ),
    );
  }

  newGridItems(var item, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SingleCourse(
                  title: item["categoryName"].toString(),
                  id: item["id"].toString())),
        );
      },
      child: Container(
        height: 142,
        width: 170,
        decoration: BoxDecoration(
            color: greyClr, borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: NetworkImage(item["categoryIconUrl"].toString()),
              fit: BoxFit.contain,
              height: 50,
              // width: 60,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              item["categoryName"].toString(),
              style: TextStyle(
                  color: Color(0xff2F455C),
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }


  workshopCard(var item, int index) {
    final ss = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CourseIntro(
                id: item['id'].toString(),
              )),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
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
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(item['workshopThumbnail'].toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['workshopNameEng'].toString(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                              color: lifescoolBlue),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  item['workshopDuration'].toString(),
                                  style: size14_700Blue,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    height: 12,
                                    width: 1,
                                    color: lifescoolBlue,
                                  ),
                                ),
                                Text(
                                  item['displaydate'].toString(),
                                  style: size14_400Blue,
                                )
                              ],
                            ),
                            Spacer(),
                            Text(
                              item['authorName'].toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TutorInfo(
                                          id: item['authorUid'].toString())),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                    Border.all(color: Color(0xfffaf6f5)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            item['authorImageUrl']
                                                .toString()),
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
                )
              ],
            ),
          ),
          // shimmer()
        ],
      ),
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
                    cuid: item['courseUid'].toString(),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['courseNameEng'].toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Mallu',
                                    fontWeight: FontWeight.w700,
                                    color: darkBlue),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
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
                            width: 93,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            item['chaptersCount'].toString() + " chapters",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito',
                                color: darkBlue),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                                height: 12, width: 2, color: darkBlue),
                          ),
                          Text(
                            item['totalVideolength'].toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Nunito',
                                color: darkBlue),
                          )
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
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
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
            SizedBox(
              height: 7,
            ),
            item['announceText'] != null
                ? Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: gradientGreen,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        item['announceText'].toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff2FB134)),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget TopCategorySelect() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: grey2),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 19),
              child: Text("Courses", style: size14_600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: grey2),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 19),
                child: Text("Live Batches", style: size14_600),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: grey2),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 19),
              child: Text("Workshops", style: size14_600),
            ),
          ),
        ],
      ),
    );
  }
}
