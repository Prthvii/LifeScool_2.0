import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifescool/Api/workshopDetails.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/paymentGateway.dart';
import 'package:lifescool/Screens/webviewDetails.dart';

import 'BriefPage.dart';

class CourseIntro extends StatefulWidget {
  final id;

  CourseIntro({this.id});
  @override
  _CourseIntroState createState() => _CourseIntroState();
}

class _CourseIntroState extends State<CourseIntro> {
  var arrList;
  var resList = [];

  var isLoading = true;
  var btColor = false;
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
    var rsp = await workshopDetailApi(widget.id.toString());
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
      print(
          "`````````````````````````resttttttttt`````````````````````````````````````````````````");
      print(arrList[0]['enableJoinButton']);
      print(
          "``````````````````````````````restttttttttttttttttt````````````````````````````````````````````");
    }
   if(arrList[0]['enableJoinButton'] == false||arrList[0]['isSubscribed'] == false){
     setState(() {
       btColor =false;

     });
   }else{

     setState(() {
       btColor =true;

     });
   }
    setState(() {
      isLoading = false;
    });
    return "0";
  }

  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SafeArea(
          child: AppBar(
         //   backgroundColor: liteBlue,
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

                        ],
                      ),

                    ],
                  ),

                ],
              ),
            ),
            automaticallyImplyLeading: false,
          ),
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
          : SingleChildScrollView(
              child: Brief(
              data: arrList,
            )),
      bottomNavigationBar: isLoading == true
          ? Container(
              child: Center(
                child: Image.asset(
                  "assets/images/loading.gif",
                  height: 40,
                ),
              ),
            )
          : Container(
              height: ss.height * 0.1,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1.5,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  )
                ],
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          arrList[0]['isSubscribed'] == false
                              ? RichText(
                                  text:  arrList[0]['wctype'].toString()=="FREE"?TextSpan(
                                      text: 'Enroll for ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text: "free",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              fontFamily: 'Nunito',
                                              // decoration:
                                              // TextDecoration.lineThrough
                                          ),
                                        ),

                                      ]):TextSpan(
                                      text: 'Enroll for  ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text: "₹" +
                                              arrList[0]['workshopMrp']
                                                  .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              fontFamily: 'Nunito',
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        TextSpan(
                                          text: "  ₹" +
                                              arrList[0]['workshopPrice']
                                                  .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            fontFamily: 'Nunito',
                                          ),
                                        ),
                                      ]),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "You're already registered.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "Click on the join button when the session is about to start.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff707070),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                          arrList[0]['isSubscribed'] == false
                              ? Text(
                                  "Inclusive of all taxes",
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xff707070)),
                                )
                              : Opacity(opacity: 0)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: arrList[0]['enableRegButton'] == true?GestureDetector(
                        onTap: () {
                          if (arrList[0]['isSubscribed'] == false) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => paymentPage(
                                        id: widget.id.toString(),
                                        amount: arrList[0]['workshopPrice']
                                            .toString(),
                                        type: "WRKSHOP",
                                        paid: arrList[0]['wctype'].toString(),
                                      )),
                            );
                          } else {
                            if(arrList[0]['enableJoinButton'] == true){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebPage(
                                      url: arrList[0]['workshopLink']
                                          .toString(),
                                      type: arrList[0]['workshopOnlineChannel'].toString(),
                                    )),
                              );
                            }else{
                              showToastSuccess("Session not yet started!");
                            }

                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: arrList[0]['isSubscribed'] == true
                                  ? Color(0xffE9E9E9)
                                  : darkBlue),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: arrList[0]['wctype'] =="PAID"? Text(
                              arrList[0]['isSubscribed'] == true
                                  ? "Join"
                                  : "Pay & Register",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  color: btColor ==false ? Colors.white
                                      : Colors.grey),
                            ):Text(
                              arrList[0]['isSubscribed'] == true
                                  ? "Join"
                                  : "Register",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  color: arrList[0]['isSubscribed'] != true
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                          ),
                        ),
                      ):Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:  Color(0xffE9E9E9)
                                ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child:  Text(
                          "Registration Closed!"
                               ,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                                color:
                                     Colors.grey),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget briefButton() {
    final ss = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: darkBlue,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ss.width * 0.1, vertical: ss.height * 0.022),
        child: Text(
          "Brief",
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget contentButton() {
    final ss = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffE9E9E9),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ss.width * 0.1, vertical: ss.height * 0.022),
        child: Text(
          "Content",
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: darkBlue),
        ),
      ),
    );
  }
}
