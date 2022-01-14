import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lifescool/Api/courseIntroApi.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/colorConverter.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/PlayerScreen.dart';
import 'package:lifescool/Screens/TutorInfo.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseIntroduction extends StatefulWidget {
  final id;
  final cuid;
  final bool frmButton;

  CourseIntroduction({this.id, this.cuid, this.frmButton});
  @override
  _CourseIntroState createState() => _CourseIntroState();
}

class _CourseIntroState extends State<CourseIntroduction> {
  var contentTrue = false;

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
    print(widget.cuid.toString());
    print((widget.id.toString()));
    this.getHome();
    setState(() {});
  }

  Future<String> getHome() async {
    var rsp = await courseIntroApi(widget.cuid.toString());
    print("courseeeeeeeeeeeeeeintroo");
    print(widget.cuid.toString());

    // arrProdList = data;
    //
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrList = rsp['attributes']['courselist'];

        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();
      });
      print("``````````````````````````````````````````````````````````````");
      print(arrList);
      print("``````````````````````````````````````````````````````````````");
    }

    setState(() {
      isLoading = false;
    });
    return "0";
  }

  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
          ),
        ),
        body: isLoading == true
            ? Container(
                child: Center(
                  child: Image.asset(
                    "assets/images/loading.gif",
                    height: 40,
                  ),
                ),
              )
            : TabBarView(
                children: [
                  BriefPage(),
                  ContentPage(),
                ],
              ),
        // contentTrue == true
        //         ? SingleChildScrollView(child: ContentPage())
        //         : SingleChildScrollView(child: BriefPage()),
        bottomNavigationBar: Container(
          height: ss.height * 0.1,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: (Colors.grey[300]),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, -1),
              ),
            ],
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ss.width * 0.05, vertical: ss.height * 0.02),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: greyBG, borderRadius: BorderRadius.circular(10)),
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: darkBlue,
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                unselectedLabelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    color: Color(0xffFE5C36)),
                indicator: BoxDecoration(
                  color: darkBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                tabs: [
                  Tab(text: "Course Brief"),
                  Tab(
                    text: "Course Contents",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget BriefButton() {
    final ss = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(() {
          contentTrue = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: contentTrue == true ? Color(0xffE9E9E9) : Color(0xffFC4834),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ss.width * 0.1, vertical: ss.height * 0.019),
          child: Text(
            "Course Brief",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: contentTrue != true
                    ? Color(0xffE9E9E9)
                    : Color(0xffFC4834)),
          ),
        ),
      ),
    );
  }

  Widget ContentButton() {
    final ss = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(() {
          contentTrue = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: contentTrue != true ? Color(0xffE9E9E9) : Color(0xffFC4834),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ss.width * 0.1, vertical: ss.height * 0.019),
          child: Text(
            "Course Content",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: contentTrue == true
                    ? Color(0xffE9E9E9)
                    : Color(0xffFC4834)),
          ),
        ),
      ),
    );
  }

//--------------------------------------------------------------------------
  ContentPage() {
    final ss = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      // margin: EdgeInsets.only(
      //     left: 17, right: ss.width * 0.03, top: ss.height * 0.01),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            children: [
              SizedBox(
                height: ss.height * 0.025,
              ),
              ContinueToCourseButton(),
              SizedBox(
                height: ss.height * 0.025,
              ),
              CourseContent(),
              SizedBox(
                height: ss.height * 0.025,
              ),
              LiveProjects(),
              SizedBox(
                height: ss.height * 0.025,
              ),
              // Assesment(),
              // SizedBox(
              //   height: ss.height * 0.025,
              // ),
              // Button2(),
              // SizedBox(height: 15),
              ContinueToCourseButton(),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  BriefPage() {
    final ss = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      // margin: EdgeInsets.only(
      //     left: ss.width * 0.03, right: ss.width * 0.03, top: ss.height * 0.01),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            children: [
              SizedBox(
                height: ss.height * 0.025,
              ),
              ContinueToCourseButton(),
              SizedBox(
                height: ss.height * 0.025,
              ),
              FirstContainer(),
              SizedBox(
                height: ss.height * 0.025,
              ),
              lifelrarnerContainer(),
              SizedBox(
                height: ss.height * 0.025,
              ),
              CourseFeatures(),
              SizedBox(
                height: ss.height * 0.025,
              ),
              CourseReq(),
              SizedBox(
                height: ss.height * 0.025,
              ),
              ContactUs(),
              SizedBox(
                height: ss.height * 0.025,
              ),
              // Button(),
              // SizedBox(height: 15),
              ContinueToCourseButton(),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

//---------------------------------------------------------------------------
  FirstContainer() {
    final ss = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  arrList[0]['courseNameEng'].toString(),
                  style: TextStyle(
                      color: hexToColor(arrList[0]['primaryColor'].toString()),
                      fontSize: 16,
                      fontFamily: 'Mallu',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  arrList[0]['courseNameMal'].toString(),
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
            Text(
              arrList[0]['courseSummary'].toString(),
              style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Color(0xff707070),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
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
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 25),
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TutorInfo(id: arrList[0]['authorId'].toString())),
                    );
                  },
                  child: Container(
                    height: ss.height * 0.09,
                    width: ss.width * 0.14,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        image: DecorationImage(
                            image: NetworkImage(
                          arrList[0]['tutorProfileImage'].toString(),
                        ))),
                  ),
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
                          arrList[0]['authorQuote'].toString(),
                          // arrList[0]['authorQuote'].toString(),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  arrList[0]['tutorName'].toString() + ",",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                  ),
                ),
                Text(
                  arrList[0]['authorDetails'].toString(),
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff2F455C)),
                ),
              ],
            ),
            SizedBox(
              height: ss.height * 0.008,
            ),
            Text(
              arrList[0]['authorBio'].toString(),
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

  CourseFeatures() {
    final ss = MediaQuery.of(context).size;

    return Container(
      width: ss.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Color(0xff2F455C)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 25),
        child: Column(
          children: [
            Text(
              "Course Features",
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Html(
                data: arrList[0]['courseFeatures'].toString(),
              ),
            )
            // Container()
          ],
        ),
      ),
    );
  }

  CourseReq() {
    final ss = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              Color(0xff0D914B),
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
              "Course Requirements",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Html(
                data: arrList[0]['courseRequirements'].toString(),
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
            color: (Colors.grey[200]),
            spreadRadius: 2,
            blurRadius: 3,
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
                    var url =
                        'tel:' + arrList[0]["customerSupportNumber"].toString();
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
                        arrList[0]["customerSupportEmail"].toString();
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

    return GestureDetector(
      onTap: () {
        setState(() {
          contentTrue = true;
        });
      },
      child: Container(
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
      ),
    );
  }

  Widget ContinueToCourseButton() {
    final ss = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PlayerScreen(
                    id: widget.id,
                    introTrue: true,
                    cuid: widget.cuid,
                  )),
        );
        // setState(() {
        //   contentTrue = true;
        // });
      },
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xffFC4834), borderRadius: BorderRadius.circular(11)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: ss.height * 0.022, horizontal: ss.width * 0.05),
          child: _ContinueToCourse(),
        ),
      ),
    );
  }

  Widget _ContinueToCourse() {
    return Row(
      children: [
        Text(
          widget.frmButton != true ? "Continue to Course" : "Back to Course",
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward,
          size: 20,
          color: Colors.white,
        )
      ],
    );
  }

  Widget _BackToCourse() {
    return Row(
      children: [
        Icon(
          Icons.arrow_back,
          size: 20,
          color: Colors.white,
        ),
        Spacer(),
        Text(
          "Back to Course",
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ],
    );
  }

  CourseContent() {
    final ss = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Color(0xffFBF8EF)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Html(
          data: arrList[0]['courseContents'].toString(),
        ),
      ),
    );
  }

  ContentsList(var item, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        head(item["title"].toString()),
        point(item["details"].toString()),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          // separatorBuilder: (context, index) => SizedBox(
          //   height: 10,
          // ),
          shrinkWrap: true,
          itemCount: arrList[0]['courseContents']['contents'][0]["contents"] !=
                  null
              ? arrList[0]['courseContents']['contents'][0]["contents"].length
              : 0,
          itemBuilder: (context, index) {
            final item =
                arrList[0]['courseContents']['contents'][0]["contents"] != null
                    ? arrList[0]['courseContents']['contents'][0]["contents"]
                        [index]
                    : null;
            return coursePoints(item, index);
          },
        )
      ],
    );
  }

  coursePoints(var item, int index) {
    return point(item["chapterTitle"].toString());
  }

  head(String txt) {
    final ss = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        top: ss.height * 0.04,
        bottom: ss.height * 0.01,
      ),
      child: Text(
        txt,
        style: TextStyle(
            color: Color(0xffFC4834),
            fontSize: 14,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold),
      ),
    );
  }

  point(String txt) {
    final ss = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(left: ss.width * 0.05),
      child: Text(
        txt,
        style: TextStyle(
            fontSize: 14,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
            color: Color(0xff2F455C)),
      ),
    );
  }

  LiveProjects() {
    final ss = MediaQuery.of(context).size;

    return Container(
      width: ss.width * 0.89,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Color(0xff2F455C)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            Text(
              "Live projects",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Html(
                data: arrList[0]['liveProjects'].toString(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Assesment() {
    final ss = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              Color(0xff0D914B),
              Color(0xff1FC578),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Wrap(
          runSpacing: ss.height * 0.03,
          alignment: WrapAlignment.center,
          children: [
            Text(
              "Course Requirements",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            CourseReqGreenBoxText(),
          ],
        ),
      ),
    );
  }

  CourseReqGreenBoxText() {
    final ss = MediaQuery.of(context).size;

    return Container(
      child: Html(
        data: arrList[0]['courseRequirements'].toString(),
      ),
    );
  }

  Widget Button2() {
    final ss = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(() {
          contentTrue = false;
        });
      },
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xffE9E9E9), borderRadius: BorderRadius.circular(11)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: ss.height * 0.022),
          child: Text(
            "Explore Course Brief",
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                color: Color(0xffFC4834)),
          ),
        ),
      ),
    );
  }
}
