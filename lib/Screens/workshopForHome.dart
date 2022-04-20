import 'package:flutter/material.dart';
import 'package:lifescool/Api/listWorkshop.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Screens/CourseIntro.dart';
import 'package:lifescool/Screens/TutorInfo/TutorInfo.dart';

class WorkshopForHome extends StatefulWidget {
  final arrWorkshop;

  WorkshopForHome({this.arrWorkshop});
  @override
  _WorkshopForHomeState createState() => _WorkshopForHomeState();
}

class _WorkshopForHomeState extends State<WorkshopForHome> {
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
    return Container(
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) => SizedBox(
          height: 15,
        ),
        shrinkWrap: true,
        // itemCount: 3,
        itemCount: widget.arrWorkshop != null ? widget.arrWorkshop.length : 0,
        itemBuilder: (context, index) {
          final item =
              widget.arrWorkshop != null ? widget.arrWorkshop[index] : null;
          // return list(index);
          return list(item, index);
        },
      ),
    );
  }

  Widget shimmer() {
    return Positioned(
        top: 0,
        right: 0,
        child: Card(
          // elevation: 6,
          margin: EdgeInsets.symmetric(horizontal: 17, vertical: 2),
          color: Color(0xffFBA33A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), bottomLeft: Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            child: Text("10% OFF",
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        ));
  }

  // list(var item, int index) {
  //   final ss = MediaQuery.of(context).size;
  //
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => CourseIntro(
  //               id: item['id'].toString(),
  //             )),
  //       );
  //     },
  //     child: Stack(
  //       children: [
  //         Container(
  //           margin: EdgeInsets.symmetric(horizontal: 17, vertical: 2),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(24),
  //             color: Colors.white,
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.black12,
  //                 spreadRadius: 1.5,
  //                 blurRadius: 5,
  //                 offset: Offset(0, 1),
  //               )
  //             ],
  //           ),
  //           child: Column(
  //             children: [
  //               Container(
  //                 height: ss.height * 0.2,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(24),
  //                     topRight: Radius.circular(24),
  //                   ),
  //                   image: DecorationImage(
  //                     image: NetworkImage(item['workshopThumbnail'].toString()),
  //                     fit: BoxFit.cover,
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(
  //                       left: 18, right: 18, bottom: 17, top: 5),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       SizedBox(
  //                         height: 3,
  //                       ),
  //                       item['wctype'].toString() != "PAID"
  //                           ? Row(
  //                         children: [
  //                           Icon(
  //                             Icons.star,
  //                             size: 12,
  //                             color: hexToColor(
  //                                 item['prime_color'].toString()),
  //                           ),
  //                           SizedBox(
  //                             width: 3,
  //                           ),
  //                           Text(
  //                             "Free Workshop",
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 fontFamily: 'Nunito',
  //                                 fontWeight: FontWeight.bold,
  //                                 color: hexToColor(
  //                                     item['prime_color'].toString())),
  //                           )
  //                         ],
  //                       )
  //                           : Container(),
  //                       SizedBox(
  //                         height: 3,
  //                       ),
  //                       Text(
  //                         item['workshopNameEng'].toString(),
  //                         style: TextStyle(
  //                             fontSize: 14,
  //                             fontWeight: FontWeight.bold,
  //                             fontFamily: 'Nunito',
  //                             color:
  //                             hexToColor(item['prime_color'].toString())),
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                         mainAxisSize: MainAxisSize.max,
  //                         children: [
  //                           Expanded(
  //                             flex: 1,
  //                             child: Container(
  //                               child: Row(
  //                                 children: [
  //                                   Container(
  //                                     height: 36,
  //                                     width: 36,
  //                                     decoration: BoxDecoration(
  //                                         shape: BoxShape.circle,
  //                                         border:
  //                                         Border.all(color: Colors.black12),
  //                                         image: DecorationImage(
  //                                             image: NetworkImage(
  //                                               item["authorImageUrl"]
  //                                                   .toString(),
  //                                             ),
  //                                             fit: BoxFit.cover)),
  //                                   ),
  //                                   SizedBox(
  //                                     width: 5,
  //                                   ),
  //                                   Flexible(
  //                                     child: Text(
  //                                       item['authorName'].toString(),
  //                                       maxLines: 2,
  //                                       style: TextStyle(
  //                                           fontSize: 12,
  //                                           fontWeight: FontWeight.w600),
  //                                       overflow: TextOverflow.ellipsis,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                           Expanded(
  //                             flex: 0,
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                   color: hexToColor(
  //                                       item['prime_color'].toString())),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.symmetric(
  //                                     horizontal: 10, vertical: 7),
  //                                 child: Column(
  //                                   children: [
  //                                     Text(
  //                                       item['displaydate'].toString(),
  //                                       // item['workshopDate'].toString(),
  //                                       style: TextStyle(
  //                                           fontSize: 12,
  //                                           fontWeight: FontWeight.w700,
  //                                           color: Colors.white),
  //                                       maxLines: 1,
  //                                     ),
  //                                     Text(
  //                                       item['workshopDuration'].toString(),
  //                                       style: TextStyle(
  //                                           fontSize: 10,
  //                                           fontWeight: FontWeight.w700,
  //                                           color: Colors.white),
  //                                     )
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           )
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //         // shimmer()
  //       ],
  //     ),
  //   );
  // }

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
                          item['workshopNameMalayalam'].toString(),
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
}
