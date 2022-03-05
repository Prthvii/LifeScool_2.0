import 'package:flutter/material.dart';
import 'package:lifescool/Api/listCatAndSub.dart';
import 'package:lifescool/Api/searchItem.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/colorConverter.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/TutorInfo/TutorInfo.dart';

import 'PlayerScreen.dart';

class SingleCourse extends StatefulWidget {
  final title;
  final id;
  SingleCourse({
    this.title,
    this.id,
  });

  @override
  _SingleCourseState createState() => _SingleCourseState();
}

class _SingleCourseState extends State<SingleCourse> {
  var arrList = [];
  var title;

  var isLoading = true;
  var searchList = [];
  var catogeryItems = [];

  @override
  void initState() {
    super.initState();

    print("xoxoxo");
    getsearch(widget.id.toString());
    getHome();

    setState(() {
      title = widget.title;
    });
  }

  Future<String> getsearch(id) async {
    setState(() {
      isLoading = true;
    });
    var rsp = await searchItemApi(id, " ", " ");
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        searchList = rsp['attributes']['courselist'];

        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();
      });
      print("arrProdList");
      print(arrList);
    } else {
      //showToastSuccess(rsp['attributes']['message'].toString());
    }

    setState(() {
      isLoading = false;
    });
    return "0";
  }

  Future<String> getHome() async {
    var rsp = await listCatAndSub();
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        catogeryItems = rsp['attributes']['categories'];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 1,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: blckClr,
                  size: 23,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Text(
              title != null ? title.toString() : "",
              style: TextStyle(color: Colors.black),
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
                    ? SizedBox(
                        height: 1,
                      )
                    : listViewOld(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
          padding: const EdgeInsets.fromLTRB(18, 15, 18, 21),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(
                height: 5,
              ),
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
                              color:
                                  hexToColor(item['primaryColor'].toString())),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          // "maaaaaaaa",
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
                              fit: BoxFit.cover)),
                      height: 36,
                      width: 36,
                    ),
                  ),
                  SizedBox(
                    width: 5,
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
                      // "aaaaaaaaaaaaa",
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

  Widget newGrid() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: catogeryItems != null ? catogeryItems.length : 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
            childAspectRatio: 1),
        itemBuilder: (BuildContext context, int index) {
          final item = catogeryItems != null ? catogeryItems[index] : null;
          return newGridItems(item, index);
        },
      ),
    );
  }

  newGridItems(var item, int index) {
    return GestureDetector(
      onTap: () {
        getsearch(item['id'].toString());
        setState(() {
          title = item["categoryName"].toString();
        });
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
              fit: BoxFit.cover,
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
