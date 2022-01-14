import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';

class LiveClassScreen extends StatefulWidget {
  const LiveClassScreen({Key key}) : super(key: key);

  @override
  _LiveClassScreenState createState() => _LiveClassScreenState();
}

class _LiveClassScreenState extends State<LiveClassScreen> {
  bool menutap = false;
  var moduleTap = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.1),
          child: AppBar(elevation: 0, backgroundColor: Colors.white)),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(gradient: gradientHOME),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                "ഗാർഡനിങ് : ഹോബിയ്ക്കപ്പുറം  പ്രൊഫഷണൽ ആയി തുടങ്ങുന്നതെങ്ങനെ? ",
                style: size16_700Mallu),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {

                    if(menutap==true){
                      setState(() {
                        menutap = false;
                      });
                    }else{
                      setState(() {
                        menutap = true;
                      });
                    }


                    print("menttaap");
                    print(menutap);
                  },
                  child: menutap == true
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: themeOrange,
                              border: Border.all(color: Colors.black12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(
                              Icons.close,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                          height: 58,
                          width: 62,
                        )
                      : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: greyClr,
                              border: Border.all(color: Colors.black12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(
                              Icons.list,
                              size: 25,
                              color: Color(0xff6D6D6D),
                            ),
                          ),
                          height: 58,
                          width: 62,
                        ),
                ),
                w(16),
                Expanded(child: menutap == true ? MenuItems() : moduleList())
                // Expanded(child: MenuItems())
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Scrollbar(
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            QuestionListNew(index),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return ChaptersList(index);
                        },
                      ),
                    ),
                    h(10),
                    liveClassMessgaes()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ChaptersList(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ExpansionTile(
        backgroundColor: liteRed,
        collapsedBackgroundColor: liteRed,
        collapsedIconColor: Colors.black,
        iconColor: Colors.black,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "1",
              style: size16_400,
            ),
            w(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("What is gardening for you?", style: size16_400),
                h(4),
                Wrap(
                  spacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Video",
                      style: size14_600grey,
                    ),
                    CircleAvatar(
                      radius: 2,
                      backgroundColor: Color(0xff6D6D6D),
                    ),
                    Text(
                      "2 mins",
                      style: size14_600grey,
                    )
                  ],
                )
              ],
            )
          ],
        ),
        childrenPadding: EdgeInsets.only(left: 42, bottom: 12),
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selectedRed),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("Synopsis", style: size14_700W),
                ),
              ),
              w(16),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selectedRed),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("Downloads", style: size14_700W),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  QuestionListNew(index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: liteRed),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.question_circle_fill,
                color: Color(0xffEA9985),
                size: 18,
              ),
              w(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("What did we learn today?", style: size16_400),
                  h(4),
                  Text(
                    "Quiz",
                    style: size14_600grey,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // QuestionsList(int index) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(10),
  //       child: ExpansionTile(
  //         backgroundColor: liteRed,
  //         collapsedBackgroundColor: liteRed,
  //         collapsedIconColor: Colors.black,
  //         iconColor: Colors.black,
  //         title: Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Icon(
  //               CupertinoIcons.question_circle_fill,
  //               color: Color(0xffEA9985),
  //               size: 18,
  //             ),
  //             w(16),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text("What did we learn today?", style: size16_400),
  //                 h(4),
  //                 Text(
  //                   "Quiz",
  //                   style: size14_600grey,
  //                 )
  //               ],
  //             )
  //           ],
  //         ),
  //         childrenPadding: EdgeInsets.only(left: 42, bottom: 12),
  //         children: [
  //           Row(
  //             children: [
  //               Container(
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                     color: selectedRed),
  //                 child: Padding(
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //                   child: Text("Synopsis", style: size14_700W),
  //                 ),
  //               ),
  //               w(16),
  //               Container(
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                     color: selectedRed),
  //                 child: Padding(
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //                   child: Text("Downloads", style: size14_700W),
  //                 ),
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  liveClassMessgaes() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 10,
              child: Icon(
                Icons.sensors_rounded,
                color: Colors.white,
                size: 15,
              ),
              backgroundColor: Colors.green,
            ),
            w(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lets start together",
                  style: size16_400,
                ),
                h(4),
                Wrap(
                  spacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "LIVE",
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    CircleAvatar(
                      radius: 2,
                      backgroundColor: Color(0xff6D6D6D),
                    ),
                    Text(
                      "Starts at 5:00 PM, Jan 10 ",
                      style: size14_600grey,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  moduleList() {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: 8,
        ),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return ModuleList(index);
        },
      ),
    );
  }

  MenuItems() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Cont(Icons.notes, "Course Brief"),
          Cont(Icons.receipt_outlined, "News"),
          Cont(Icons.share, "Share"),
        ],
      ),
    );
  }

  ModuleList(int index) {
    return GestureDetector(
      onTap: (){
        setState(() {
          moduleTap = index;

        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: moduleTap==index? themeOrange: greyClr,
        ),
        height: 58,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Text(
                "Module",
                style: moduleTap==index? size14_700White:size14_700Red,
              ),
              h(5),
              Text(
                "1",
                style:  moduleTap==index? size14_700White:size14_700Red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Cont(IconData icn, String txt) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: greyClr,
            border: Border.all(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(
                icn,
                size: 20,
                color: Color(0xff6D6D6D),
              ),
              w(10),
              Text(txt, style: size14_700Grey)
            ],
          ),
        ),
        height: 58,
      ),
    );
  }
}
