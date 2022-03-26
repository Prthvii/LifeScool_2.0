import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/LiveClasses/Data/joinBatch.dart';

class courseBriefPage extends StatefulWidget {
  final item;

  courseBriefPage({this.item});
  @override
  _courseBriefPageState createState() => _courseBriefPageState();
}

class _courseBriefPageState extends State<courseBriefPage> {
  var arrList = [];
  var resList = [];
  var arrCat = [];

  var isLoading = true;
  var isApplied = false;
  var selectedUid;
  var selectedTime;

  var currentIndex = 3000;
  //List<dynamic> data = [];
  @override
  void initState() {
    super.initState();

    print("xoxoxo");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);

                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => LiveClassScreen(id:widget.item['courseUid'].toString(),item: widget.item,)),
                  // );
                },
                child: CircleAvatar(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  radius: 24,
                  backgroundColor: lifescool_highlight,
                ),
              ),
            ),
            w(16),
            Text(
              "Course Brief",
              style: size16_700Mallu,
            )
          ],
        ),
        elevation: 0,
      ),
      // bottomNavigationBar: Container(
      //   height: 76,
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         color: (Colors.grey[300]),
      //         spreadRadius: 1,
      //         blurRadius: 3,
      //         offset: Offset(-1, 0),
      //       ),
      //     ],
      //   ),
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16),
      //     child: Row(
      //       children: [
      //         (widget.item['isApplied'].toString() == "true" &&
      //                 widget.item['startFlag'] == "0")
      //             ? Text(
      //                 "Class not started",
      //                 style: size14_400Blue,
      //               )
      //             : Text(
      //                 (widget.item['isApplied'].toString() == "true" &&
      //                         widget.item['startFlag'] == "1")
      //                     ? "Class started, Join now"
      //                     : "Application open for batch",
      //                 style: size14_400Blue,
      //               ),
      //         Spacer(),
      //         (widget.item['isApplied'].toString() == "true" &&
      //                 widget.item['startFlag'] == "0")
      //             ? Container()
      //             : GestureDetector(
      //                 onTap: () {
      //                   if (widget.item['isApplied'] == true &&
      //                       widget.item['startFlag'] == "1") {
      //                     Navigator.pushReplacement(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (context) => LiveClassScreen(
      //                                 id: widget.item['courseUid'].toString(),
      //                                 item: widget.item,
      //                               )),
      //                     );
      //                   } else {
      //                     applyBottomSheet();
      //                   }
      //                 },
      //                 child: isApplied == true
      //                     ? Container(
      //                         height: 43,
      //                         width: 103,
      //                         alignment: Alignment.center,
      //                         decoration: BoxDecoration(
      //                             //  gradient: gradientHOME,
      //                             color: Colors.grey,
      //                             borderRadius: BorderRadius.circular(10)),
      //                         child: Padding(
      //                           padding: const EdgeInsets.symmetric(
      //                               horizontal: 16, vertical: 8),
      //                           child: Text(
      //                             "Join",
      //                             style: size14_700W,
      //                           ),
      //                         ),
      //                       )
      //                     : Container(
      //                         height: 43,
      //                         width: 103,
      //                         alignment: Alignment.center,
      //                         decoration: BoxDecoration(
      //                             gradient: gradientHOME,
      //                             borderRadius: BorderRadius.circular(10)),
      //                         child: Padding(
      //                           padding: const EdgeInsets.symmetric(
      //                               horizontal: 16, vertical: 8),
      //                           child: Text(
      //                             (widget.item['isApplied'].toString() ==
      //                                         "true" &&
      //                                     widget.item['startFlag'] == "1")
      //                                 ? "Join"
      //                                 : "Apply now",
      //                             style: size14_700W,
      //                           ),
      //                         ),
      //                       ),
      //               )
      //       ],
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 233,
              color: themeOrange,
            ),
            h(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "ഗാർഡനിങ് : പ്രൊഫഷണൽ ആയി ഹോബി യ്ക്കപ്പുറം തുടങ്ങുന്നതെങ്ങനെ? ",
                      style: size16_700Mallu),
                  h(8),
                  Text(
                      "This course is a refreshing take on gardening and take a learner though all the basics of ambroidery skills to techniques and hacks needed to embark on your journey.",
                      style: size14_400),
                  h(16),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 18),
                      w(12),
                      Text("Aug 14", style: size14_600),
                      Text(" to ", style: size14_400),
                      Text("September 12", style: size14_600),
                    ],
                  ),
                  h(32),
                  Text("Features", style: size16_700Red),
                  h(32),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/video.svg",
                              height: 32,
                            ),
                            w(16),
                            Expanded(
                              child: Text("Five hours of video on-demand",
                                  style: size14_400),
                            )
                          ],
                        ),
                      ),
                      w(16),
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/mobile.svg",
                              height: 32,
                            ),
                            w(16),
                            Expanded(
                              child: Text("Lifetime Access on Mobiled",
                                  style: size14_400),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  h(24),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/downlaod.svg",
                              height: 32,
                            ),
                            w(16),
                            Expanded(
                              child: Text("3 downloadable resources",
                                  style: size14_400),
                            )
                          ],
                        ),
                      ),
                      w(16),
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/live.svg",
                              height: 32,
                            ),
                            w(16),
                            Expanded(
                              child: Text("2 live projects", style: size14_400),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  h(32),
                  Text("Trainer", style: size16_700Red),
                  h(16),
                  profileContainer(),
                  h(32),
                  Text("Course showcase", style: size16_700Red),
                  h(16),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: liteRed),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Rose M", style: size14_400),
                              w(16),
                              Icon(Icons.star, size: 15)
                            ],
                          ),
                          h(24),
                          Text(
                              "“This course helped me a lot to develop my skills in this topic. It was really of great help.”",
                              style: size14_400),
                          h(16),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: selectedRed),
                                height: 122,
                                width: 130,
                              ),
                              w(16),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: selectedRed),
                                height: 122,
                                width: 130,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 261,
                  //   child: ListView.separated(
                  //     scrollDirection: Axis.horizontal,
                  //     separatorBuilder: (context, index) => SizedBox(
                  //       height: 10,
                  //     ),
                  //     shrinkWrap: true,
                  //     itemCount: 5,
                  //     itemBuilder: (context, index) {
                  //       return courseShowcaseList(index);
                  //     },
                  //   ),
                  // ),
                  h(32),
                  Text("Modules", style: size16_700Red),
                  h(24),
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => Divider(color: grey2),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return list(index);
                    },
                  ),
                  Divider(color: grey2),
                  Row(
                    children: [
                      Text("FAQ", style: size16_700Red),
                      Spacer(),
                      Text("View All", style: size14_700),
                      w(3),
                      Icon(Icons.arrow_forward_ios, size: 12)
                    ],
                  ),
                  h(16),
                  SizedBox(
                    height: 177,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(width: 16),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return faqList(index);
                      },
                    ),
                  ),
                  h(32),

                  Text("Requirements", style: size16_700Red),
                  h(16),
                  Text(
                      "This course is a refreshing take on gardening and take a learner though all the basics of ambroidery skills to techniques and hacks needed to embark on your journey. This course is a refreshing take on gardening and take a learner though all the basics of ambroidery skills to techniques and hacks needed to embark on your journey.",
                      style: size14_400),
                  h(32),
                  Text("Certificate", style: size16_700Red),
                  h(15),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/certificate.png",
                        height: 112,
                        width: 179,
                      ),
                      w(16),
                      Expanded(
                        child: Text(
                            "After course completion you get certificate issued by Lifescool and Farooq College",
                            style: size14_400),
                      )
                    ],
                  ),
                  h(33)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  faqList(int index) {
    return Container(
      width: 305,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: lifescool_highlight),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("What are the requirements for the course?",
                style: size14_400),
            h(12),
            Text(
                "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium dolore mque architecto beatae sunt explicabo  volup tatem accus. Sit voluptatem accusantium doloremque architecto beatae vitae dicta sunt explicabo.",
                style: size14_400)
          ],
        ),
      ),
    );
  }

  list(int index) {
    return ExpansionTile(
      title: Text("1: Introduction", style: size16_400),
      subtitle: Text("5 hours watchtime | 4 live classes | 4 quizes",
          style: size14_400),
      children: <Widget>[
        ListTile(
          title: Text(
            "items.description",
          ),
        )
      ],
    );
  }

  profileContainer() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: lifescool_highlight),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Jane Doe", style: size16_700Mallu),
            Text("Gardening expert and entrepreneur",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic)),
            h(16),
            Row(
              children: [
                Image.network(
                  "https://purepng.com/public/uploads/large/purepng.com-female-studentstudentcollege-studentschool-studentfemale-student-14215269231647tn6r.png",
                  height: 130,
                  width: 130,
                ),
                w(16),
                Expanded(
                  child: Text(
                    "Jane Doe is well established gardening entrepreneur who have turned her self-taught hobby into a living by creating a world of gardening. She is also a pioneer in miniature gardening.",
                    style: size14_400,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  applyBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
        ),
        backgroundColor: Colors.white,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  h(20),
                  Icon(Icons.arrow_back, color: Colors.black, size: 20),
                  h(20),
                  Text(
                    "Slot selection",
                    style: size16_700Red,
                  ),
                  h(8),
                  Text(
                    "Choose an available slot for the classes",
                    style: size16_400Blue,
                  ),
                  h(16),
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    shrinkWrap: true,
                    itemCount: widget.item['availableTimeSlots'] != null
                        ? widget.item['availableTimeSlots'].length
                        : 0,
                    itemBuilder: (context, index) {
                      final item = widget.item['availableTimeSlots'] != null
                          ? widget.item['availableTimeSlots'][index]
                          : null;
                      return timeSlotsList(item, index, state);
                    },
                  ),
                  h(16),
                  Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          if (selectedUid != null) {
                            var rsp = await joinBatchApi(
                                widget.item['id'].toString(), selectedTime);
                            if (rsp != 0) {
                              Navigator.pop(context);
                              showToastSuccess(
                                  rsp['attributes']['message'].toString());
                              print("selectedUid");
                              print(selectedUid);
                              updated2(state);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => LiveClassScreen(id: widget.item['courseUid'].toString(),)),
                              // );
                            } else {
                              showToastSuccess("Failed to join");
                            }
                          }
                        },
                        child: Container(
                          height: 43,
                          width: 103,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: selectedUid == null
                                  ? disableGrey
                                  : themeOrange,
                              // gradient: gradientHOME,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              "Proceed",
                              style: selectedUid == null
                                  ? size14_700Grey
                                  : size14_700White,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        top: 16),
                  ),
                ],
              ),
            );
          });
        });
  }

  timeSlotsList(var item, int index, state) {
    return GestureDetector(
      onTap: () {
        print("Uidddd");
        print(item['uid'].toString());
        updated(state, index, item['uid'].toString(), item['combo']);
        // setState(() {
        //   currentIndex=index;
        //   selectedUid =item['uid'].toString();
        // });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: currentIndex == index ? selectedRed : liteRed),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: RichText(
            softWrap: true,
            text: TextSpan(children: [
              TextSpan(
                text: item['timeslot'],
                style: currentIndex == index ? size16_700White : size16_700Red,
              ),
              // TextSpan(
              //   text: ' to ',
              //   style: size16_400Red,
              // ),
              // TextSpan(
              //   text: '10AM',
              //   style: size16_700Red,
              // ),
              // TextSpan(
              //   text: ' four days a week',
              //   style: size16_400Red,
              // ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<Null> updated(StateSetter updateState, index, uid, slot) async {
    updateState(() {
      currentIndex = index;
      selectedUid = uid;
      selectedTime = slot;
    });
  }

  Future<Null> updated2(StateSetter updateState) async {
    updateState(() {
      isApplied = true;
    });
  }
}
