import 'package:flutter/material.dart';
import 'package:lifescool/Api/searchItem.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Screens/LiveClasses/LiveBatchesBriefPage.dart';
import 'package:lifescool/Screens/PlayerScreen.dart';
import 'package:lifescool/Screens/TutorInfo.dart';

class CategoryOpenedScreen extends StatefulWidget {
 final id;
 CategoryOpenedScreen({this.id});

  @override
  _CategoryOpenedScreenState createState() => _CategoryOpenedScreenState();
}

class _CategoryOpenedScreenState extends State<CategoryOpenedScreen> {



  bool isExpanded = false;

  var arrLive = [];
  var arrWorkshop = [];
  var searchList = [];
  var catogeryItems = [];

  var isLoading = true;
  var isSelected = 1;
  var token;
  var id;

  //List<dynamic> data = [];
  @override
  void initState() {
    super.initState();

    print("xoxoxo");
    this.getsearch("","","");

    setState(() {});
  }



  Future<String> getsearch(cid, sid, key) async {
    setState(() {
      isLoading = true;
    });
    print("searchhhhhhhh");

    var rsp = await searchItemApi(widget.id, sid, key);
    print("searchhhhhhhh");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        searchList = rsp['attributes']['courselist'];
        arrLive = rsp['attributes']['livebatchlist'];
        arrWorkshop = rsp['attributes']['workshoplist'];

        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();
      });
      print("searchhhhhhhh");
      print(searchList);
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
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
      ),
      body: Column(
        children: [
          h(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isSelected=1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                         color: isSelected==1?Color(0xffFEE9E4):Colors.white,
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
                  onTap: (){
                    setState(() {
                      isSelected=2;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(

                      decoration: BoxDecoration(
                          color: isSelected==2?Color(0xffFEE9E4):Colors.white,
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
                  onTap: (){
                    setState(() {
                      isSelected=3;
                    });
                  },
                  child: Container(

                    decoration: BoxDecoration(
                        color: isSelected==3?Color(0xffFEE9E4):Colors.white,
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
          isSelected==1?Expanded(
            child: Scrollbar(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
                shrinkWrap: true,
                //  itemCount: 2,

                itemCount: searchList != null ? searchList.length : 0,
                itemBuilder: (context, index) {
                  final item = searchList != null ? searchList[index] : null;
                  return HomeCards(item,index);
                },
              ),
            ),
          ):isSelected==2?Expanded(
            child: Scrollbar(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
                shrinkWrap: true,
                //  itemCount: 2,

                itemCount: arrLive != null ? arrLive.length : 0,
                itemBuilder: (context, index) {
                  final item = arrLive != null ? arrLive[index] : null;
                  return HomeCards(item,index);
                },
              ),
            ),
          ):Expanded(
            child: Scrollbar(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
                shrinkWrap: true,
                //  itemCount: 2,

                itemCount: arrWorkshop != null ? arrWorkshop.length : 0,
                itemBuilder: (context, index) {
                  final item = arrWorkshop != null ? arrWorkshop[index] : null;
                  return HomeCards(item,index);
                },
              ),
            ),
          ),
          h(16)
        ],
      ),
    );
  }

  // HomeCards(int index) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 17, vertical: 2),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(24),
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black12,
  //           spreadRadius: 1.5,
  //           blurRadius: 5,
  //           offset: Offset(0, 1),
  //         )
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
  //           child: Column(
  //             children: [
  //               // item['cwtype'].toString() != "PAID"
  //               //     ? Row(
  //               //   children: [
  //               //     SizedBox(
  //               //       width: 5,
  //               //     ),
  //               //     Icon(Icons.star, size: 12, color: darkBlue),
  //               //     SizedBox(
  //               //       width: 3,
  //               //     ),
  //               //     Text(
  //               //       "Free Course",
  //               //       style: TextStyle(
  //               //           fontSize: 12,
  //               //           fontFamily: 'Nunito',
  //               //           fontWeight: FontWeight.bold,
  //               //           color: darkBlue),
  //               //     )
  //               //   ],
  //               // )
  //               //     : Container(),
  //               // SizedBox(
  //               //   height: 5,
  //               // ),
  //               GestureDetector(
  //                 onTap: () {
  //                   // Navigator.push(
  //                   //   context,
  //                   //   MaterialPageRoute(
  //                   //       builder: (context) => PlayerScreen(
  //                   //         id: item['id'].toString(),
  //                   //         cuid: item['courseUid'].toString(),
  //                   //       )),
  //                   // );
  //                 },
  //                 child: Container(
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 2),
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             color: imgBgClr,
  //                             borderRadius: BorderRadius.circular(15),
  //                             border: Border.all(color: Color(0xfffaf6f5)),
  //                             // image: DecorationImage(
  //                             //     image: NetworkImage(
  //                             //         item['thumbnailUrl'].toString()),
  //                             //     fit: BoxFit.cover)
  //                           ),
  //                           height: 62,
  //                           width: 62,
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: 10,
  //                       ),
  //                       Expanded(
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               "ഗാർഡനിങ് : ഹോബിയ്ക്കപ്പുറം  പ്രൊഫഷണൽ ആയി തുടങ്ങുന്നതെങ്ങനെ?",
  //                               // item['courseNameEng'].toString(),
  //                               style: TextStyle(
  //                                   fontSize: 16,
  //                                   fontFamily: 'Mallu',
  //                                   fontWeight: FontWeight.bold,
  //                                   color: darkBlue),
  //                               maxLines: 3,
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                             // Text(
  //                             //   item['courseNameMal'].toString(),
  //                             //   maxLines: 3,
  //                             //   overflow: TextOverflow.ellipsis,
  //                             //   style: TextStyle(
  //                             //       fontFamily: 'Nunito',
  //                             //       fontSize: 14,
  //                             //       fontWeight: FontWeight.w600),
  //                             // ),
  //                           ],
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Row(
  //                 children: [
  //                   GestureDetector(
  //                     onTap: () {
  //                       // Navigator.push(
  //                       //   context,
  //                       //   MaterialPageRoute(
  //                       //       builder: (context) => PlayerScreen(
  //                       //             id: item['id'].toString(),
  //                       //             cuid: item['courseUid'].toString(),
  //                       //           )),
  //                       // );
  //                     },
  //                     // child: Container(
  //                     //   decoration: BoxDecoration(
  //                     //       borderRadius: BorderRadius.circular(10),
  //                     //       color: darkBlue                   //   child: Padding(
  //                     //     padding: const EdgeInsets.symmetric(
  //                     //         horizontal: 12, vertical: 7),
  //                     //     child: Column(
  //                     //       crossAxisAlignment: CrossAxisAlignment.start,
  //                     //       children: [
  //                     //         Text(
  //                     //           item['chaptersCount'].toString() + " chapters",
  //                     //           style: TextStyle(
  //                     //               fontSize: 12,
  //                     //               fontWeight: FontWeight.w700,
  //                     //               fontFamily: 'Nunito',
  //                     //               color: Colors.white),
  //                     //         ),
  //                     //         Text(
  //                     //           item['totalVideolength'].toString(),
  //                     //           style: TextStyle(
  //                     //               fontSize: 12,
  //                     //               fontWeight: FontWeight.w500,
  //                     //               fontFamily: 'Nunito',
  //                     //               color: Colors.white),
  //                     //         )
  //                     //       ],
  //                     //     ),
  //                     //   ),
  //                     // ),
  //                     child: Row(
  //                       children: [
  //                         Text(
  //                           // item['chaptersCount'].toString()
  //                           "12" + " chapters",
  //                           style: TextStyle(
  //                               fontSize: 14,
  //                               fontWeight: FontWeight.w700,
  //                               fontFamily: 'Nunito',
  //                               color: darkBlue),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(horizontal: 5),
  //                           child: Container(
  //                               height: 12, width: 1, color: darkBlue),
  //                         ),
  //                         Text(
  //                           "1 hour",
  //                           // item['totalVideolength'].toString(),
  //                           style: TextStyle(
  //                               fontSize: 14,
  //                               fontWeight: FontWeight.w500,
  //                               fontFamily: 'Nunito',
  //                               color: darkBlue),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   Spacer(),
  //                   GestureDetector(
  //                     onTap: () {
  //                       // Navigator.push(
  //                       //   context,
  //                       //   MaterialPageRoute(
  //                       //       builder: (context) =>
  //                       //           TutorInfo(id: item['authorId'].toString())),
  //                       // );
  //                     },
  //                     child: Text(
  //                       "Geetha K",
  //                       // item['tutorName'].toString(),
  //                       style: TextStyle(
  //                         fontSize: 12,
  //                         fontWeight: FontWeight.w600,
  //                         fontFamily: 'Nunito',
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 5,
  //                   ),
  //                   GestureDetector(
  //                     onTap: () {
  //                       // Navigator.push(
  //                       //   context,
  //                       //   MaterialPageRoute(
  //                       //       builder: (context) =>
  //                       //           TutorInfo(id: item['authorId'].toString())),
  //                       // );
  //                     },
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         color: imgBgClr,
  //                         shape: BoxShape.circle,
  //                         border: Border.all(color: Color(0xfffaf6f5)),
  //                         // image: DecorationImage(
  //                         //     image: NetworkImage(
  //                         //         item['tutorProfileImage'].toString()),
  //                         //     fit: BoxFit.cover)
  //                       ),
  //                       height: 24,
  //                       width: 24,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: 7,
  //         ),
  //         // item['announceText'] != null
  //         //     ? Container(
  //         //         alignment: Alignment.centerLeft,
  //         //         width: double.infinity,
  //         //         decoration: BoxDecoration(
  //         //           gradient: gradientRed,
  //         //           borderRadius: BorderRadius.only(
  //         //               bottomLeft: Radius.circular(24),
  //         //               bottomRight: Radius.circular(24)),
  //         //         ),
  //         //         child: Padding(
  //         //           padding:
  //         //               const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //         //           child: Text(
  //         //             item['announceText'].toString(),
  //         //             style: TextStyle(
  //         //                 fontSize: 12,
  //         //                 fontWeight: FontWeight.w700,
  //         //                 color: themeOrange),
  //         //           ),
  //         //         ),
  //         //       )
  //         //     : Container()
  //       ],
  //     ),
  //   );
  // }

  HomeCards(var item, int index) {
    return GestureDetector(
      onTap: () {
        print('tap');
        if(isSelected==1){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayerScreen(
                  id: item['id'].toString(),
                  cuid: item['courseUid'].toString(),
                )),
          );
        }
        if(isSelected==2){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => liveBatchesBriefPage(item: item,)),
          );
        }

      },
      child:  Container(
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
}
