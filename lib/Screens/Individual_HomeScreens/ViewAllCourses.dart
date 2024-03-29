import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifescool/Api/listCatAndSub.dart';
import 'package:lifescool/Api/searchItem.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/TutorInfo/TutorInfo.dart';

import '../PlayerScreen.dart';

class ViewAllCourses extends StatefulWidget {
  const ViewAllCourses({Key key}) : super(key: key);

  @override
  _ViewAllCoursesState createState() => _ViewAllCoursesState();
}

class _ViewAllCoursesState extends State<ViewAllCourses> {
  var arrList = [];
  var arrCat = [];
  var resList = [];

  var isLoading = true;
  var token;
  var id;
  var currentIndex = 900;

  //List<dynamic> data = [];
  @override
  void initState() {
    super.initState();

    print("xoxoxo");
    //  this.getProfile();
    this.getCat();
    this.getsearch("", "", "");
    setState(() {});
  }

  Future<String> getCat() async {
    var rsp = await listCatAndSub();
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrCat = rsp['attributes']['categories'];

        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();
      });
      print("arrCatList");
      print(arrCat);
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
        arrList = rsp['attributes']['courselist'];

        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();
      });
      print("searchhhhhhhh");
      print(arrList);
    } else {
      //showToastSuccess(rsp['attributes']['message'].toString());
    }

    setState(() {
      isLoading = false;
    });
    return "0";
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: liteYellow));
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
                        "Ready to access learning without fixed schedules.",
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
                          GestureDetector(
                            onTap: () {
                              this.getsearch("", "", "");
                              setState(() {
                                currentIndex = 900;
                              });
                            },
                            child: Container(
                              height: 56,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: currentIndex == 900
                                      ? liteYellow
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: grey2)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: Text("All", style: size14_600),
                              ),
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
          arrList.isEmpty
              ? Expanded(child: Center(child: Text("NO DATA")))
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 16,
                          ),
                          shrinkWrap: true,
                          //  itemCount: 5,
                          itemCount: arrList != null ? arrList.length : 0,
                          itemBuilder: (context, index) {
                            final item =
                                arrList != null ? arrList[index] : null;
                            return HomeCards(item, index);
                          },
                        ),
                        h(30)
                      ],
                    ),
                  ),
                ),
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
        itemCount: arrCat != null ? arrCat.length : 0,
        itemBuilder: (context, index) {
          final item = arrCat != null ? arrCat[index] : null;
          return newList(item, index);
        },
      ),
    );
  }

  newList(var item, int index) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          currentIndex = index;
        });
        var rsp = await getsearch(item['id'].toString(), "", "");
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: currentIndex == index ? liteYellow : Colors.white,
            border: Border.all(color: grey2)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
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
            ],
          ),
        ),
      ),
    );
  }

  HomeCards(var item, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayerScreen(
                    id: item['id'].toString(),
                    cuid: item['courseUid'].toString(),
                  )),
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LiveClassScreen()),
        // );
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
                        w(16),
                        Expanded(
                          child: Text(
                            item['courseNameEng'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Mallu',
                                fontWeight: FontWeight.w700,
                                color: darkBlue),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
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
                            maxLines: 2,
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
}
