import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/LiveClasses/Data/joinBatch.dart';
import 'package:lifescool/Screens/LiveClasses/Data/liveBatchBreif.dart';
import 'package:lifescool/Screens/LiveClasses/LiveClassScreen.dart';
import 'package:lifescool/widgets/play_video.dart';

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

  var banners = [];
  var basic;
  var features = [];
  var traniners = [];
  var modules = [];
  var faqs = [];
  var cert;

  List<Widget> columnContent = [];
  int _carouselIndex = 0;
  final CarouselController controller = CarouselController();

  @override
  void initState() {
    super.initState();

    print("xoxoxo");
    print(widget.item);
    this.getData();
    setState(() {});
  }

  Future<String> getData() async {
    var rsp = await liveBatchBreifApi(widget.item['id'].toString());
    print("courseeeeeeeeeeeeee");
    print(rsp);

    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        banners = rsp['attributes']['banners'];
        basic = rsp['attributes']['basic'];
        features = rsp['attributes']['features'];
        traniners = rsp['attributes']['traniners'];
        modules = rsp['attributes']['modules'];
        faqs = rsp['attributes']['faqs'];
        cert = rsp['attributes']['cert'];

        print("trainer");
        print("trainer");
      });
      _buildExpandableContent();
    } else {
      showToastSuccess(rsp['attributes']['message'].toString());
    }

    setState(() {
      isLoading = false;
    });
    return "0";
  }

  _buildExpandableContent() {
    for (var value in banners) {
      columnContent.add(Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child:    Container(

            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(value['type'].toString() == "IMAGE"
                            ? value['content'].toString()
                            : value['thumbnail'].toString()),
                        fit: BoxFit.cover,
                      )),
                  alignment: Alignment.bottomCenter,
                ),
                value['type'].toString() == "VIDEO"?Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/pauseReels.png",
                      height: 40,
                    )):Container()
              ],
            ),
          ),






      ));
    }
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
              "Live Batch Brief",
              style: size16_700Mallu,
            )
          ],
        ),
        elevation: 0,
      ),
      bottomNavigationBar: Container(
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
              (widget.item['isApplied'].toString() == "true" &&
                      widget.item['startFlag'] == "0")
                  ? Text(
                      "Class not started",
                      style: size14_400Blue,
                    )
                  : Text(
                      (widget.item['isApplied'].toString() == "true" &&
                              widget.item['startFlag'] == "1")
                          ? "Class started, Join now"
                          : "Application open for batch",
                      style: size14_400Blue,
                    ),
              Spacer(),
              (widget.item['isApplied'].toString() == "true" &&
                      widget.item['startFlag'] == "0")
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        if (widget.item['isApplied'] == true &&
                            widget.item['startFlag'] == "1") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LiveClassScreen(
                                      id: widget.item['courseUid'].toString(),
                                      item: widget.item,
                                    )),
                          );
                        } else {
                          applyBottomSheet();
                        }
                      },
                      child: isApplied == true
                          ? Container(
                              height: 43,
                              width: 103,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  //  gradient: gradientHOME,
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Text(
                                  "Join",
                                  style: size14_700W,
                                ),
                              ),
                            )
                          : Container(
                              height: 43,
                              width: 103,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  gradient: gradientHOME,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Text(
                                  (widget.item['isApplied'].toString() ==
                                              "true" &&
                                          widget.item['startFlag'] == "1")
                                      ? "Join"
                                      : "Apply now",
                                  style: size14_700W,
                                ),
                              ),
                            ),
                    )
            ],
          ),
        ),
      ),
      body: isLoading == true
          ? Container(
              child: Center(
                  child: Image.asset(
              "assets/images/loading.gif",
              height: 40,
            )))
          : SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                     print("casoulindexx");
                     print(_carouselIndex);

                   if(banners[_carouselIndex]['type']=="VIDEO"){
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => PlayVideo(url:banners[_carouselIndex]['content'].toString())),
                     );
                   }
                    },
                    child: Container(
                      height: 210,
                      child: CarouselSlider(
                          items: columnContent,
                          carouselController: controller,

                          options: CarouselOptions(
                            onPageChanged : (index, reason) {

                              setState((){

                                _carouselIndex = index;

                              });

                           },
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          )),
                    ),
                  ),
                  h(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(basic['name'].toString(), style: size16_700Mallu),
                        h(8),
                        Text(basic['description'].toString(),
                            style: size14_400),
                        h(16),
                        Row(children: [
                          Icon(Icons.calendar_today, size: 18),
                          w(12),
                          Text(basic['schedule'].toString(), style: size14_600),
                        ]),
                        h(32),
                        Text("Features", style: size16_700Red),
                        h(22),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,

                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 2.5),
                          itemCount: features != null ? features.length : 0,
                          itemBuilder: (context, index) {
                            final item = features != null ? features[index] : null;
                            return FeaturesGrid(item,index);
                          },
                        ),
                        h(32),
                        Text("Trainer", style: size16_700Red),
                        h(16),
                        Container(
                          height: 230,
                          width: double.infinity,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 16),
                            shrinkWrap: true,
                            itemCount: traniners != null ? traniners.length : 0,
                            itemBuilder: (context, index) {
                              final item = traniners != null ? traniners[index] : null;
                              return profileContainer(item, index);
                            },
                          ),
                        ),
                        h(32),
                        Text("Modules", style: size16_700Red),
                        h(24),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              Divider(color: grey2),
                          shrinkWrap: true,
                          itemCount: modules != null ? modules.length : 0,
                          itemBuilder: (context, index) {
                            final item =
                                modules != null ? modules[index] : null;
                            return list(item, index);
                          },
                        ),
                        Divider(color: grey2),
                        Row(
                          children: [
                            Text("FAQ", style: size16_700Red),
                            Spacer(),
                            w(3),
                            Icon(Icons.arrow_forward_ios, size: 12)
                          ],
                        ),
                        h(16),
                        SizedBox(
                          height: 185,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 16),
                            shrinkWrap: true,
                            itemCount: faqs != null ? faqs.length : 0,
                            itemBuilder: (context, index) {
                              final item = faqs != null ? faqs[index] : null;
                              return faqList(item, index);
                            },
                          ),
                        ),
                        h(32),
                        Text("Certificate", style: size16_700Red),
                        h(15),
                        Row(
                          children: [
                            Image.network(
                              cert['image'].toString(),
                              height: 112,
                              width: 90,
                            ),
                            w(16),
                            Expanded(
                              child: Text(cert['description'].toString(),
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

  faqList(var item, int index) {
    return Container(
      width: 305,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: lifescool_highlight),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item['question'].toString(), style: size14_400),
            h(12),
            Text(item['answer'].toString(), style: size14_400)
          ],
        ),
      ),
    );
  }

  list(var item, int index) {
    return ExpansionTile(
      title: Text(item['title'].toString(), style: size16_400),
      subtitle: Text(item['schedule'].toString(), style: size14_400),
      children: <Widget>[
        ListTile(
          title: Text(
            item['description'].toString(),
          ),
        )
      ],
    );
  }

  profileContainer(var item, int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: lifescool_highlight),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item['name'].toString(), style: size16_700Mallu),
            Text(item['designation'].toString(),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic)),
            h(16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  item['image'].toString(),
                  height: 130,
                  width: 130,
                ),
                w(16),
                Expanded(
                  child: Text(
                    item['bio'].toString(),
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

  FeaturesGrid(var item,int index) {
    return Row(
      children: [
        Image.network(
          item['icon'].toString(),
          height: 32,
        ),
        w(16),
        Expanded(
          child: Text( item['schedule'].toString(), style: size14_400),
        )
      ],
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
