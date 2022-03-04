import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';

class TutorPageRestItems extends StatefulWidget {
  const TutorPageRestItems({Key key}) : super(key: key);

  @override
  _TutorPageRestItemsState createState() => _TutorPageRestItemsState();
}

class _TutorPageRestItemsState extends State<TutorPageRestItems> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            h(16),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Shorts",
                style: size14_700,
              ),
            ),
            h(8),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Playlist",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
            h(8),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                height: 230,
                child: Scrollbar(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10,
                    ),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return shortsList(index);
                    },
                  ),
                ),
              ),
            ),
            h(16),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Videos",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
            h(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                // height: 324,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 90 / 158),
                  itemBuilder: (BuildContext context, int index) {
                    return videosGrid(index);
                  },
                ),
              ),
            ),
            h(16),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Courses (5)", style: size14_700),
            ),
            h(8),
            ListView.separated(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => h(8),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return CoursesList(index);
              },
            ),
            h(16),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Workshops (2)", style: size14_700),
            ),
            h(8),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Upcoming",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
            h(8),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return workshopListUpcoming(index);
              },
            ),
            h(16),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Completed",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
            h(8),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => h(16),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return WorkshopsCompleted(index);
              },
            ),
            h(30)
          ],
        ),
      ),
    );
  }

  shortsList(int index) {
    return Column(
      children: [
        Container(
          height: 188,
          width: 106,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(testImg), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
            color: themeOrange,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 42,
                  width: 106,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 20,
                        ),
                        w(8),
                        Text("12", style: size14_600W)
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      color: Colors.black26),
                ),
              )
            ],
          ),
        ),
        h(8),
        SizedBox(
          child: Text("Easy Dancing videos list", style: size14_400),
          width: 106,
        )
      ],
    );
  }

  videosGrid(int index) {
    return Container(
      width: 90,
      height: 158,
      color: themeOrange,
      child: Image.network(testImg, fit: BoxFit.cover),
    );
  }

  CoursesList(int index) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => PlayerScreen(
        //         id: item['id'].toString(),
        //         cuid: item['courseUid'].toString(),
        //       )),
        // );
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
                                    image: NetworkImage(testImg),
                                    fit: BoxFit.cover)),
                            height: 62,
                            width: 62,
                          ),
                        ),
                        w(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ഗാർഡനിങ് : ഹോബിയ്ക്കപ്പുറം  പ്രൊഫഷണൽ ആയി തുടങ്ങുന്നതെങ്ങനെ? ",
                                style: size16_700Mallu,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
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
                            "12" + " chapters",
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
                            "1 hour",
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           TutorInfo(id: item['authorId'].toString())),
                          // );
                        },
                        child: Text(
                          "Geetha K",
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           TutorInfo(id: item['authorId'].toString())),
                          // );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Color(0xfffaf6f5)),
                              image: DecorationImage(
                                  image: NetworkImage(testImg),
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
            // item['announceText'] != null
            //     ? Container(
            //         alignment: Alignment.centerLeft,
            //         width: double.infinity,
            //         decoration: BoxDecoration(
            //           gradient: gradientGreen,
            //           borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.circular(24),
            //               bottomRight: Radius.circular(24)),
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 16, vertical: 8),
            //           child: Text(
            //             item['announceText'].toString(),
            //             style: TextStyle(
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w700,
            //                 color: Color(0xff2FB134)),
            //           ),
            //         ),
            //       )
            //     : Container()
          ],
        ),
      ),
    );
  }

  workshopListUpcoming(int index) {
    final ss = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => CourseIntro(
        //         id: item['id'].toString(),
        //       )),
        // );
      },
      child: Container(
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
                  image: NetworkImage(testImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ഗാർഡനിങ് : ഹോബിയ്ക്കപ്പുറം  പ്രൊഫഷണൽ ആയി തുടങ്ങുന്നതെങ്ങനെ? ",
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
                              "Nov 20",
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
                              "2.30pm - 5.30pm",
                              style: size14_400Blue,
                            )
                          ],
                        ),
                        Spacer(),
                        Text(
                          "Geetha K",
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => TutorInfo(
                            //           id: item['authorId'].toString())),
                            // );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Color(0xfffaf6f5)),
                                image: DecorationImage(
                                    image: NetworkImage(testImg),
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
            ),
            // h(12),
            Container(
              alignment: Alignment.centerLeft,
              height: 32,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text("Enroll now for free", style: size12_700Blue),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24)),
                gradient: gradientBlue,
              ),
            )
          ],
        ),
      ),
    );
  }

  WorkshopsCompleted(int index) {
    final ss = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => CourseIntro(
        //         id: item['id'].toString(),
        //       )),
        // );
      },
      child: Container(
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ഗാർഡനിങ് : ഹോബിയ്ക്കപ്പുറം  പ്രൊഫഷണൽ ആയി തുടങ്ങുന്നതെങ്ങനെ? ",
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
                        Text(
                          "Nov 20",
                          style: size14_700Blue,
                        ),
                        Spacer(),
                        Text(
                          "Geetha K",
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => TutorInfo(
                            //           id: item['authorId'].toString())),
                            // );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Color(0xfffaf6f5)),
                                image: DecorationImage(
                                    image: NetworkImage(testImg),
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
            ),
          ],
        ),
      ),
    );
  }
}
