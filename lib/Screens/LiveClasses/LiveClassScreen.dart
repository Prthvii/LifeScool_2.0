import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/LiveClasses/Data/moduleDataList.dart';
import 'package:lifescool/Screens/LiveClasses/Data/moduleList.dart';
import 'package:lifescool/Screens/LiveClasses/Utils/catName.dart';
import 'package:lifescool/Screens/webviewPlain.dart';

class LiveClassScreen extends StatefulWidget {
 final id;



 LiveClassScreen({this.id});
  @override
  _LiveClassScreenState createState() => _LiveClassScreenState();
}

class _LiveClassScreenState extends State<LiveClassScreen> {
  bool menutap = false;
  var moduleTap = 0;
  var title = "";
  var url = "";
  var dec1 = "";
  var dec2 = "";
  var type;


  var arrList = [];

  var arrCat = [];
  var arrLive = [];

  var isLoading = true;


  var currentIndex = 3000;
  //List<dynamic> data = [];
  @override
  void initState() {
    super.initState();

    print("xoxoxo");
    print(widget.id);

     this.getCat();
    setState(() {

    });
  }


  Future<String> getCat() async {

    var rsp = await modulesListBatchApi(widget.id);
    print("courseeeeeeeeeeeeee");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp!=0) {
      setState(() {
        arrCat = rsp['attributes']['response'];

        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();
      });
      print("arrCatList");
      print(arrCat);
      if(arrCat.isNotEmpty){
        getData(arrCat[0]['id'],0);
      }

    } else {

    }

    // setState(() {
    //   isLoading = false;
    // });
    return "0";
  }

  Future<String> getData(moduleID,index) async {
    setState(() {
      isLoading = true;
    });
    print("searchhhhhhhh");

    var rsp = await modulesDataListApi(moduleID);
    print("searchhhhhhhh");
    print(rsp);

    // arrProdList = data;
    //
    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrList = rsp['attributes']['response'];
        arrLive = rsp['attributes']['livedata'];

        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();



      });
      print("searchhhhhhhh");
      print(arrList);



    } else {
      //showToastSuccess(rsp['attributes']['message'].toString());
    }

    setState(() {
      isLoading = false;
    });
    return "0";
  }


  Future<void> initializePlayer() async {}
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

                        shrinkWrap: true,
                        itemCount: arrList != null ? arrList.length : 0,
                        itemBuilder: (context, index) {
                          final item = arrList != null ? arrList[index] : null;
                          return ChaptersList(item,index);
                        },

                        separatorBuilder: (context, index) =>
                            QuestionListNew(index),
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

  ChaptersList(var item,int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ExpansionTile(
        backgroundColor: liteRed,
        collapsedBackgroundColor: liteRed,
        collapsedIconColor: Colors.black,
        iconColor: Colors.black,
        title: GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WebPagePlain(url: item['itemData']['url'].toString(),)),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (index+1).toString(),
                style: size16_400,
              ),
              w(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['itemData']['title'].toString(), style: size16_400),
                  h(4),
                  Wrap(
                    spacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        catsName(item['itemType'].toString()),
                        style: size14_600grey,
                      ),
                      // CircleAvatar(
                      //   radius: 2,
                      //   backgroundColor: Color(0xff6D6D6D),
                      // ) ,
                      // Text(
                      //   "2 mins",
                      //   style: size14_600grey,
                      // )
                    ],
                  )
                ],
              )
            ],
          ),
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


  liveClassMessgaes() {
    return  ListView.separated(
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) => SizedBox(height: 8),
      shrinkWrap: true,
      itemCount: arrLive != null ? arrLive.length : 0,
      itemBuilder: (context, index) {
        final item =arrLive != null ? arrLive[index] : null;
        return GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WebPagePlain(url: item['itemData']['url'].toString(),)),
            );
          },
          child: Container(
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
                        item['itemData']['title'].toString(),
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
                            item['itemData']['dateTime'].toString(),
                            style: size14_600grey,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
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
        itemCount: arrCat != null ? arrCat.length : 0,
        itemBuilder: (context, index) {
          final item = arrCat != null ? arrCat[index] : null;
          return ModuleList(item,index);
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

  ModuleList(var item,int index) {
    return GestureDetector(
      onTap: (){

        getData(item['id'],index);
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
                item['moduleName'].toString(),
                style: moduleTap==index? size14_700White:size14_700Red,
              ),
              h(5),
              Text(
                item['moduleNo'].toString(),
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
