import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifescool/Api/clearNotification.dart';
import 'package:lifescool/Api/getNotification.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Screens/PlayerScreen.dart';

class Notifications extends StatefulWidget {
  // const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var arrList = [];

  var isLoading = true;

  @override
  void initState() {
    super.initState();

    print("xoxoxo");
    this.getHome();
    setState(() {});
  }

  Future<String> getHome() async {
    var rsp = await getNoti();
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrList = rsp['attributes']['notifications'];

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          color: Color(0xff2F455C),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Notifications",
          style: appBarTxtStyl,
        ),
      ),
      body: isLoading == true
          ? Container(
              child: Center(
              child: Image.asset(
                "assets/images/loading.gif",
                height: 40,
              ),
            ))
          : arrList.isEmpty
              ? Center(child: Text("No Data"))
              : SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          shrinkWrap: true,
                          itemCount: arrList != null ? arrList.length : 0,
                          itemBuilder: (context, index) {
                            final item =
                                arrList != null ? arrList[index] : null;
                            return NotiList(item, index);
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        arrList.isNotEmpty
                            ? GestureDetector(
                                onTap: () async {
                                  print("clear");
                                  setState(() {
                                    arrList.clear();
                                  });
                                  var rsp = await clearNoti();
                                },
                                child: Text(
                                  "Clear All",
                                  style: bold16,
                                ),
                              )
                            : SizedBox(
                                height: 5,
                              )
                      ],
                    ),
                  ),
                ),
    );
  }

  NotiList(var item, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayerScreen(
                    id: item['id'].toString(),
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['notificationTitle'].toString(),
                style: txt14Semi,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    item['postDate'].toString(),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  // Text(
                  //   item['postDate'].toString(),
                  //   style: TextStyle(color: Colors.grey, fontSize: 12),
                  // )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  img(),
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
                              fontFamily: 'Mallu',
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                              // color:
                              //     hexToColor(item['primaryColor'].toString())
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          item['courseNameMal'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget img() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1589998059171-988d887df646?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80"),
              fit: BoxFit.cover)),
      height: 35,
      width: 35,
    );
  }
}
