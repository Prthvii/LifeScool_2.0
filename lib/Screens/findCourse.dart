import 'package:flutter/material.dart';
import 'package:lifescool/Api/listCatAndSub.dart';
import 'package:lifescool/Api/searchItem.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/colorConverter.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/PlayerScreen.dart';
import 'package:lifescool/Screens/SingleCourseScreen.dart';
import 'package:lifescool/Screens/TutorInfo.dart';

class FindCourse extends StatefulWidget {
  // const FindCourse({Key? key}) : super(key: key);

  @override
  _FindCourseState createState() => _FindCourseState();
}

class _FindCourseState extends State<FindCourse> {
  bool isExpanded = false;

  var arrList = [];
  var searchList = [];
  var catogeryItems = [];

  var isLoading = true;
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
        searchList = rsp['attributes']['courselist'];

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
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //   ),
        //   color: Colors.black,
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        elevation: 0, titleSpacing: 1,
        title: Row(
          children: [
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xff2F455C),
                  size: 23,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffE9E9E9)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextField(
                    cursorColor: Colors.black54,
                    showCursor: true,
                    autofocus: false,
                    textInputAction: TextInputAction.go,
                    controller: searchController,
                    onEditingComplete: () {
                      getsearch("", "", searchController.text.toString());
                    },
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          getsearch("", "", searchController.text.toString());
                        },
                        child: Icon(
                          Icons.search,
                          color: Color(0xff2F455C),
                        ),
                      ),
                      hintStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                      hintText: "Find a course to learn",
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListView(
          children: [
            isLoading == true
                ? Container(
                    child: Center(
                    child: Image.asset(
                      "assets/images/loading.gif",
                      height: 40,
                    ),
                  ))
                : searchList.isEmpty
                    ? Opacity(
                        opacity: 0,
                      )
                    : listViewOld(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                "Browse courses by category",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2F455C)),
              ),
            ),
            newGrid(),
          ],
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
      itemCount: searchList != null ? searchList.length : 0,
      itemBuilder: (context, index) {
        final item = searchList != null ? searchList[index] : null;
        return HomeCards(item, index);
      },
    );
  }

  Widget newGrid() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        // itemCount: catogeryItems != null ? catogeryItems.length : 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
            childAspectRatio: 1),
        itemCount: arrList != null ? arrList.length : 0,
        itemBuilder: (context, index) {
          final item = arrList != null ? arrList[index] : null;
          return newGridItems(item, index);
        },
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
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
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
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 17, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.red,
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
          padding: const EdgeInsets.fromLTRB(18, 15, 18, 21),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.star,
                    size: 12,
                    color: hexToColor(item['primaryColor'].toString()),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Free Course",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        color: hexToColor(item['primaryColor'].toString())),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Color(0xfffaf6f5)),
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
                              fontFamily: 'Nunito',
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
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
                              fit: BoxFit.contain)),
                      height: 36,
                      width: 36,
                    ),
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
                    child: Text(
                      item['tutorName'].toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            item['chaptersCount'].toString() + " chapters",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito',
                                color: Colors.white),
                          ),
                          Text(
                            item['totalVideolength'].toString(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Nunito',
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
