import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class Brief extends StatefulWidget {
  final data;

  Brief({this.data});
  @override
  _BriefState createState() => _BriefState();
}

class _BriefState extends State<Brief> {
  @override
  void initState() {
    super.initState();

    print("xoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxo");

    print(widget.data);
    print("xoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxoxo");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(ss.height * 0.03),
      child: Column(
        children: [
          _mainImageContainer(),

          SizedBox(
            height: ss.height * 0.04,
          ),

          lifelrarnerContainer(),
          SizedBox(
            height: ss.height * 0.025,
          ),
          WorkshopFeatures(),
          SizedBox(
            height: ss.height * 0.025,
          ),
          WorkshopReq(),
          SizedBox(
            height: ss.height * 0.025,
          ),
          ContactUs(),
          SizedBox(
            height: ss.height * 0.025,
          ),
          // Button()
        ],
      ),
    );
  }

  FirstContainer() {
    final ss = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: (Colors.grey[200]),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(1, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 25),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Modern Embroidery Design - A journey from basics to pro",
                  style: TextStyle(
                      color: Color(0xffFC4834),
                      fontSize: 14,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "എംബ്രോയിഡറി പഠിക്കാം, വരുമാനമാർഗമാക്കാം",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: ss.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "A one step guide to beginning Modern Hand Embroidery : Hoop Magic",
                style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Color(0xff707070),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  lifelrarnerContainer() {
    final ss = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Color(0xffFBF8EF)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/life.png",
              width: ss.width * 0.2,
            ),
            SizedBox(
              height: ss.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: ss.height * 0.09,
                  width: ss.width * 0.14,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage(
                              widget.data[0]['authorImageUrl'].toString()))),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/Icons/quote1.png",
                        height: ss.height * 0.016,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          widget.data[0]['authorQuote'].toString(),
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Image.asset(
                              "assets/Icons/quote2.png",
                              height: ss.height * 0.016,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ss.height * 0.02,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.data[0]['authorName'].toString(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.data[0]['authorDetails'].toString(),
              maxLines: 2,
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff2F455C)),
            ),
            SizedBox(
              height: ss.height * 0.008,
            ),
            Text(
              widget.data[0]['authorBio'].toString(),
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff2F455C)),
            ),
          ],
        ),
      ),
    );
  }

  WorkshopFeatures() {
    final ss = MediaQuery.of(context).size;

    return Container(
      width: ss.width * 0.89,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Color(0xff2F455C)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Text(
              "Workshop Features",
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
              child: Html(
                data: widget.data[0]['workshopFeatures'].toString(),
              ),
            )
          ],
        ),
      ),
    );
  }

  _mainImageContainer() {
    final ss = MediaQuery.of(context).size;

    return Container(
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
          // Container(
          //   height: ss.height * 0.2,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(24),
          //       topRight: Radius.circular(24),
          //     ),
          //     image: DecorationImage(
          //       image: NetworkImage(
          //         widget.data[0]['workshopThumbnail'].toString(),
          //       ),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data[0]['workshopNameEng'].toString(),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.data[0]['workshopNameMalayalam'].toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Mallu',
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.data[0]['workshopDetails'].toString(),
                    style: TextStyle(color: Color(0xff707070), fontSize: 14),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.data[0]['displaydate'].toString(),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.data[0]['workshopDuration'].toString(),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Row(
                  //   children: [
                  //     Image.network(
                  //       widget.data[0]['channelIcon'].toString(),
                  //       height: 30,
                  //       width: 30,
                  //     ),
                  //     SizedBox(
                  //       width: ss.width * 0.02,
                  //     ),
                  //     Text(
                  //       widget.data[0]['workshopOnlineChannel'].toString(),
                  //       style:
                  //           TextStyle(color: Color(0xff707070), fontSize: 14),
                  //     ),
                  //
                  //     // Container(
                  //     //   decoration: BoxDecoration(
                  //     //       borderRadius: BorderRadius.circular(10),
                  //     //       color: Colors.orange),
                  //     //   child: Padding(
                  //     //     padding: const EdgeInsets.symmetric(
                  //     //         horizontal: 12, vertical: 7),
                  //     //     child: Row(
                  //     //       children: [
                  //     //         Column(
                  //     //           crossAxisAlignment: CrossAxisAlignment.center,
                  //     //           children: [
                  //     //             Text(
                  //     //               widget.data[0]['workshopDate'].toString(),
                  //     //               style: TextStyle(
                  //     //                   fontSize: 14,
                  //     //                   fontWeight: FontWeight.w700,
                  //     //                   color: Colors.white),
                  //     //             ),
                  //     //             Text(
                  //     //               widget.data[0]['workshopTime'].toString(),
                  //     //               style: TextStyle(
                  //     //                   fontSize: 14,
                  //     //                   fontWeight: FontWeight.w500,
                  //     //                   color: Colors.white),
                  //     //             )
                  //     //           ],
                  //     //         ),
                  //     //         Padding(
                  //     //           padding:
                  //     //               const EdgeInsets.symmetric(horizontal: 7),
                  //     //           child: Container(
                  //     //             height: ss.height * 0.05,
                  //     //             width: 1,
                  //     //             color: Colors.white54,
                  //     //           ),
                  //     //         ),
                  //     //         Text(
                  //     //           widget.data[0]['workshopDuration'].toString(),
                  //     //           style: TextStyle(
                  //     //               fontSize: 14,
                  //     //               fontWeight: FontWeight.w700,
                  //     //               color: Colors.white),
                  //     //         ),
                  //     //       ],
                  //     //     ),
                  //     //   ),
                  //     // )
                  //   ],
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  WorkshopReq() {
    final ss = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              Color(0xff0D917B),
              Color(0xff1FC578),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Text(
              "Workshop Requirements",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
              child: Html(
                data: widget.data[0]['workshopRequirements'].toString(),
              ),
            )
          ],
        ),
      ),
    );
  }

  ContactUs() {
    final ss = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: (Colors.grey[300]),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(1, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: Column(
          children: [
            Text(
              "Contact Us",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2F455C)),
            ),
            SizedBox(
              height: ss.height * 0.02,
            ),
            Text(
              "If you have any doubts, please reach out to us",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w500,
                  color: Color(0xff2F455C)),
            ),
            SizedBox(
              height: ss.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    var url = 'tel:' +
                        widget.data[0]["customerSupportNumber"].toString();
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      showToastSuccess("Unable to make call");
                      throw 'Could not launch $url';
                    }
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: ss.width * 0.08,
                        child: Image.asset(
                          "assets/Icons/phone.png",
                          width: ss.width * 0.05,
                        ),
                      ),
                      SizedBox(
                        height: ss.height * 0.01,
                      ),
                      Text(
                        "Talk to us",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2F455C)),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    var url = 'mailto:' +
                        widget.data[0]["customerSupportEmail"].toString();
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      showToastSuccess("Unable to create email");
                      throw 'Could not launch $url';
                    }
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: ss.width * 0.08,
                        child: Image.asset(
                          "assets/Icons/mail.png",
                          width: ss.width * 0.05,
                        ),
                      ),
                      SizedBox(
                        height: ss.height * 0.01,
                      ),
                      Text(
                        "Write to us",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2F455C)),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget Button() {
    final ss = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xffE9E9E9), borderRadius: BorderRadius.circular(11)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ss.height * 0.022),
        child: Text(
          "Explore Course Contents",
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              color: Color(0xffFC4834)),
        ),
      ),
    );
  }
}
