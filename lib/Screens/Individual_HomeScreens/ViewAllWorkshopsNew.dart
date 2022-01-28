import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifescool/Api/listWorkshop.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/colorConverter.dart';

import '../CourseIntro.dart';

class ViewAllWorkshopsNew extends StatefulWidget {
  final data;
  const ViewAllWorkshopsNew({Key key, this.data}) : super(key: key);

  @override
  _ViewAllWorkshopsNewState createState() => _ViewAllWorkshopsNewState();
}

class _ViewAllWorkshopsNewState extends State<ViewAllWorkshopsNew> {
  var arrList;
  var resList = [];

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
    var rsp = await listWorkshopApi();
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrList = rsp['attributes']['workshops'];

        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();
      });
    }
    print("11111111111111111111111111111");
    print(arrList);
    print("111111111111111111111111111111111");
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(99),
        child: SafeArea(
          child: AppBar(
            backgroundColor: liteBlue,
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
                          Text("Workshops", style: size20_700),
                        ],
                      ),
                      h(24),
                      Text(
                        "Live Workshops",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            color: Color(0xff348ADA)),
                      )
                    ],
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    "assets/svg/wrkshpExp.svg",
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
                  color: liteBlue,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, phasellus rhoncus libero justo uctus. ",
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
                          Container(
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xffF3FFF2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: grey2)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Text("All", style: size14_600),
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
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              shrinkWrap: true,
              itemCount: arrList != null ? arrList.length : 0,
              itemBuilder: (context, index) {
                final item = arrList != null ? arrList[index] : null;
                return list(item, index);
              },
            ),
          )
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
        itemCount: 10,
        itemBuilder: (context, index) {
          return newList(index);
        },
      ),
    );
  }

  newList(int index) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: grey2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                  "https://www.kindpng.com/picc/m/79-790695_landscape-icon-transparent-background-trees-icon-hd-png.png"),
              fit: BoxFit.contain,
              height: 32,
              width: 32,
            ),
            w(16),
            Text(
              "Gardening",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  list(var item, int index) {
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
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 12, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: 3,
                        // ),
                        // item['wctype'].toString() != "PAID"
                        //     ? Row(
                        //         children: [
                        //           Icon(
                        //             Icons.star,
                        //             size: 12,
                        //             color: hexToColor(
                        //                 item['prime_color'].toString()),
                        //           ),
                        //           SizedBox(
                        //             width: 3,
                        //           ),
                        //           Text(
                        //             "Free Workshop",
                        //             style: TextStyle(
                        //                 fontSize: 12,
                        //                 fontFamily: 'Nunito',
                        //                 fontWeight: FontWeight.bold,
                        //                 color: hexToColor(
                        //                     item['prime_color'].toString())),
                        //           )
                        //         ],
                        //       )
                        //     : Container(),
                        // SizedBox(
                        //   height: 3,
                        // ),
                        Text(
                          item['workshopNameEng'].toString(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                              color:
                                  hexToColor(item['prime_color'].toString())),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Nov 20 ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Nunito',
                                      color: darkBlue),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                      height: 12, width: 2, color: darkBlue),
                                ),
                                Text(
                                  "2.30pm - 5.30pm",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Nunito',
                                      color: darkBlue),
                                )
                              ],
                            ),
                            Spacer(),
                            Text(
                              "Geetha K",
                              // item['tutorName'].toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Color(0xfffaf6f5)),
                                  image: DecorationImage(
                                      image: NetworkImage(testImg
                                          // item['tutorProfileImage'].toString()
                                          ),
                                      fit: BoxFit.cover)),
                              height: 24,
                              width: 24,
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
}
