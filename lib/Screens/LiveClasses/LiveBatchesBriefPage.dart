import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/LiveClasses/Data/joinBatch.dart';
import 'package:lifescool/Screens/LiveClasses/LiveClassScreen.dart';


class liveBatchesBriefPage extends StatefulWidget {
 final item;

   liveBatchesBriefPage({this.item});
  @override
  _liveBatchesBriefPageState createState() => _liveBatchesBriefPageState();
}

class _liveBatchesBriefPageState extends State<liveBatchesBriefPage> {
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

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    print("iteeeeeeeem");
    print(widget.item);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: GestureDetector(
                onTap: () {
                  // Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LiveClassScreen(id:widget.item['courseUid'].toString())),
                  );
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
              "Live Batch Brief",
              style: size16_700Mallu,
            )
          ],
        ),
        elevation: 0,
      ),
      bottomNavigationBar:Container(
        height: 76,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: (Colors.grey[300]),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(-1, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              (widget.item['isApplied'].toString()=="true"&&widget.item['startFlag']=="0")?Text(
                "Class not started",
                style: size14_400Blue,
              ):Text(
                (widget.item['isApplied'].toString()=="true"&&widget.item['startFlag']=="1")?"Class started, Join now":"Application open for batch",
                style: size14_400Blue,
              ),
              Spacer(),
              (widget.item['isApplied'].toString()=="true"&&widget.item['startFlag']=="0")?Container():GestureDetector(
                onTap: () {
                 if (widget.item['isApplied']==true&&widget.item['startFlag']=="1"){

                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => LiveClassScreen(id:widget.item['courseUid'].toString())),
                   );
                  }else{
                   applyBottomSheet();
                 }

                },
                child:  isApplied==true?Container(
                  height: 43,
                  width: 103,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    //  gradient: gradientHOME,
                    color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Join",
                      style: size14_700W,
                    ),
                  ),
                )
                    :Container(
                  height: 43,
                  width: 103,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: gradientHOME,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      (widget.item['isApplied'].toString()=="true"&&widget.item['startFlag']=="1")?"Join": "Apply now",
                      style: size14_700W,
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

  applyBottomSheet() {

    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
        ),
        backgroundColor: Colors.white,

        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context,state){
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
                    itemCount: widget.item['availableTimeSlots'] != null ? widget.item['availableTimeSlots'].length : 0,
                    itemBuilder: (context, index) {
                      final item = widget.item['availableTimeSlots'] != null ? widget.item['availableTimeSlots'][index] : null;
                      return timeSlotsList(item,index,state);
                    },
                  ),
                  h(16),
                  Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: ()async{

                          if(selectedUid!=null){

                            var rsp =await joinBatchApi(widget.item['id'].toString(),selectedTime);
                            if(rsp!=0){
                              Navigator.pop(context);
                               showToastSuccess(rsp['attributes']['message'].toString());
                               print("selectedUid");
                               print(selectedUid);
                               updated2(state);
                               // Navigator.push(
                               //   context,
                               //   MaterialPageRoute(builder: (context) => LiveClassScreen(id: widget.item['courseUid'].toString(),)),
                               // );
                            }else{
                              showToastSuccess("Failed to join");
                            }
                          }

                        },
                        child: Container(
                          height: 43,
                          width: 103,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: selectedUid==null?disableGrey:themeOrange,
                              // gradient: gradientHOME,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              "Proceed",
                              style: selectedUid==null?size14_700Grey:size14_700White,
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

  timeSlotsList(var item,int index,state) {

    return GestureDetector(
      onTap: (){
        print("Uidddd");
        print(item['uid'].toString());
        updated(state,index,item['uid'].toString(),item['combo']);
        // setState(() {
        //   currentIndex=index;
        //   selectedUid =item['uid'].toString();
        // });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: currentIndex==index?selectedRed:liteRed),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: RichText(
            softWrap: true,
            text: TextSpan(children: [
              TextSpan(
                text: item['timeslot'],
                style:  currentIndex==index?size16_700White:size16_700Red,
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

  Future<Null> updated(StateSetter updateState,index,uid,slot) async {
    updateState(() {
      currentIndex=index;
      selectedUid =uid;
      selectedTime =slot;
    });
  }

  Future<Null> updated2(StateSetter updateState) async {
    updateState(() {
     isApplied=true;
    });
  }
}
