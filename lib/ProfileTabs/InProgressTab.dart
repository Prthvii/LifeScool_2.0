import 'package:flutter/material.dart';
import 'package:lifescool/Api/myCourse.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/colorConverter.dart';
import 'package:lifescool/Screens/TutorInfo.dart';

class InProgresstab extends StatefulWidget {
  // const InProgresstab({Key? key}) : super(key: key);

  @override
  _InProgresstabState createState() => _InProgresstabState();
}

class _InProgresstabState extends State<InProgresstab> {
  var arrList = [];

  var isLoading = true;
  var arrInitialList = [];

  //List<dynamic> data = [];
  @override
  void initState() {
    super.initState();

    print("xoxoxo");

    this.getHome();

    setState(() {});
  }

  Future<String> getHome() async {
    var rsp = await myCourseApi();
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp != 0 && rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrInitialList = rsp['attributes']['subscribedCourses'];
        for (var i = 0; i < arrInitialList.length; i++) {
          if (arrInitialList[i]['learningProgress'].toString() == "started") {
            arrList.add(arrInitialList[i]);
          }
        }
        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();
      });
      print("arrProdList");
      print(arrList);
    }

    setState(() {
      isLoading = false;
    });
    return "0";
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Container(
            child: Center(
            child: Image.asset(
              "assets/images/loading.gif",
              height: 40,
            ),
          ))
        : arrList.isEmpty
            ? Center(
                child: Text("No Data"),
              )
            : Container(
                child: Scrollbar(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 0,
                    ),
                    shrinkWrap: true,
                    itemCount: arrList != null ? arrList.length : 0,
                    itemBuilder: (context, index) {
                      final item = arrList != null ? arrList[index] : null;
                      return list2(item, index);
                    },
                  ),
                ),
              );
  }

  list2(var item, int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
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
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image:
                                NetworkImage(item['thumbnailUrl'].toString()),
                            fit: BoxFit.cover)),
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          item['courseNameEng'].toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: item['primaryColor'] != null
                                ? hexToColor(item['primaryColor'].toString())
                                : Color(0xff2F455C),
                            fontFamily: 'Mallu',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          item['courseNameMal'].toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Reg10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
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
                    child: Text(
                      item['tutorName'].toString(),
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(item['progressImg'] != null
                                    ? item['progressImg'].toString()
                                    : "https://www.freeiconspng.com/uploads/green-video-play-icon-13.jpeg"),
                                fit: BoxFit.cover)),
                        height: 15,
                        width: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      // Image(image: AssetImage())
                      Text(
                        item['learningStatus'].toString(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
