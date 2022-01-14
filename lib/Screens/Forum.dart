import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifescool/Api/EditComment.dart';
import 'package:lifescool/Api/ForumApi.dart';
import 'package:lifescool/Api/PostComment.dart';
import 'package:lifescool/Api/PostRplt.dart';
import 'package:lifescool/Api/deleteComment.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';

class Forum extends StatefulWidget {
  final id;
  bool isLocked;
  Forum({this.id, this.isLocked});
  @override
  _CardWiseRprtState createState() => _CardWiseRprtState();
}

class _CardWiseRprtState extends State<Forum> {
  var arrList = [];
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final ScrollController _scrollController3 = ScrollController();
  final ScrollController _scrollController4 = ScrollController();
  final ScrollController _scrollController5 = ScrollController();
  String _value = "";
  var replayList = [];
  var editQuestionList;
  var replyLength = 0;
  var yourQuryList = [];
  var replayHead;
  var replaySub;
  var replayIndex = 0;
  var forumId;
  var fid;
  var selected = "Top queries";
  TextEditingController replyController = new TextEditingController();
  TextEditingController yourQueryController = new TextEditingController();
  TextEditingController typedQueryController = new TextEditingController();

  TextEditingController headController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController EditHeadController = TextEditingController();
  TextEditingController EditBodyController = TextEditingController();

  var isLoading = true;
  var replayTapped = false;
  var commentTapped = false;
  var yourQuires = false;
  var editQuires = false;

  @override
  void initState() {
    // TODO: implement initState
    print("xoxoxo");

    this.getHome("", "2");
  }

  Future<String> getHome(var typed, sort) async {
    arrList.clear();

    var rsp = await forumListApi(widget.id, typed, sort);

    if (rsp != 0 && rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrList = rsp['attributes']['forum'];
        replayList = arrList[replayIndex]['replies'];
        yourQuryList = rsp['attributes']['myPosts'];
      });
    }

    print("catogerrrrry");
    print(yourQuryList);
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
                height: 30,
              ),
            ),
          )
        : Container(
            // margin: EdgeInsets.all(15),
            child: editQuires == true
                ? editQuestion()
                : replayTapped == true
                    ? replayComment()
                    : commentTapped == true
                        ? askQuestion()
                        : yourQuires == true
                            ? YourQueries()
                            : forum(),
          );
  }

  Widget forum() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          // height: 50,
          decoration: BoxDecoration(
              color: Color(0xffE9E9E9),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              cursorColor: Colors.black,
              autofocus: false,
              controller: typedQueryController,
              onChanged: (changed) {
                arrList.clear();

                getHome(changed, "1");
                setState(() {
                  headController.text = changed;
                });
              },
              onTap: () {
                // askQuestionBottomSheet();
              },
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              decoration: new InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 14),
                hintText: "Type your query here.",
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Flexible(
          child: Scrollbar(
            child: Container(
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  // yourQuryList.isNotEmpty
                  //     ? Text(
                  //         "Your Queries",
                  //         style: TextStyle(
                  //             fontSize: 15, fontWeight: FontWeight.bold),
                  //       )
                  //     : SizedBox(
                  //         height: 1,
                  //       ),
                  // yourQuryList.isNotEmpty
                  //     ? SizedBox(
                  //         height: 15,
                  //       )
                  //     : SizedBox(
                  //         height: 1,
                  //       ),

                  // Container(
                  //   decoration: BoxDecoration(
                  //       border: Border(
                  //     left: BorderSide(width: 3, color: Color(0xff4236F1)),
                  //   )),
                  //   // height: MediaQuery.of(context).size.height * 0.27,
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 10),
                  //     child: ListView.separated(
                  //       scrollDirection: Axis.vertical,
                  //       physics: ScrollPhysics(),
                  //       separatorBuilder: (context, index) => SizedBox(
                  //         height: 10,
                  //       ),
                  //       shrinkWrap: true,
                  //       itemCount:
                  //           yourQuryList != null ? yourQuryList.length : 0,
                  //       itemBuilder: (context, index) {
                  //         final item =
                  //             yourQuryList != null ? yourQuryList[index] : null;
                  //         return Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 Expanded(
                  //                   child: Text(
                  //                     item['discussionBody'].toString(),
                  //                     style: TextStyle(
                  //                         fontSize: 14,
                  //                         fontWeight: FontWeight.w500),
                  //                   ),
                  //                   flex: 15,
                  //                 ),
                  //                 Expanded(
                  //                   child: PopupMenuButton(
                  //                       elevation: 20,
                  //                       icon: Icon(
                  //                         Icons.more_vert,
                  //                         size: 17,
                  //                       ),
                  //                       enabled: true,
                  //                       onSelected: (value) async {
                  //                         setState(() {
                  //                           _value = value;
                  //                           print(value);
                  //                         });
                  //
                  //                         if (_value == "first") {
                  //                           setState(() {
                  //                             editQuires = true;
                  //                             editQuestionList = item;
                  //                             print("itemmmdetailss");
                  //                             print(editQuestionList);
                  //                             EditHeadController.text =
                  //                                 item['discussionTitle']
                  //                                     .toString();
                  //                             EditBodyController.text =
                  //                                 item['discussionBody']
                  //                                     .toString();
                  //                           });
                  //                         } else {
                  //                           setState(() {
                  //                             isLoading = true;
                  //                             yourQuryList.removeAt(index);
                  //                           });
                  //                           var rsp = await deleteCommentApi(
                  //                               widget.id,
                  //                               item['id'].toString());
                  //
                  //                           showToastSuccess(
                  //                               "Comment deleted!");
                  //                           getHome("", "1");
                  //                         }
                  //                       },
                  //                       itemBuilder: (context) => [
                  //                             PopupMenuItem(
                  //                               child: Text(
                  //                                 "Edit",
                  //                                 style:
                  //                                     TextStyle(fontSize: 14),
                  //                               ),
                  //                               value: "first",
                  //                             ),
                  //                             PopupMenuItem(
                  //                               child: Text(
                  //                                 "Delete",
                  //                                 style: TextStyle(
                  //                                     color: Colors.red,
                  //                                     fontSize: 14,
                  //                                     fontWeight:
                  //                                         FontWeight.w600),
                  //                               ),
                  //                               value: "Second",
                  //                             ),
                  //                           ]),
                  //                 )
                  //               ],
                  //             ),
                  //             SizedBox(
                  //               height: 15,
                  //             ),
                  //             Row(
                  //               children: [
                  //                 Text(
                  //                   item['date'].toString(),
                  //                   style: TextStyle(
                  //                       fontSize: 12,
                  //                       color: Colors.grey[500],
                  //                       fontWeight: FontWeight.w400),
                  //                 ),
                  //                 Spacer(),
                  //                 item['replies'] != null
                  //                     ? GestureDetector(
                  //                         onTap: () {
                  //                           setState(() {
                  //                             replayHead =
                  //                                 item['discussionTitle']
                  //                                     .toString();
                  //                             replaySub = item['discussionBody']
                  //                                 .toString();
                  //                             replayList = item['replies'];
                  //                             fid = item['id'].toString();
                  //                             replyLength =
                  //                                 item['replies'].length;
                  //                             replayTapped = true;
                  //                             print("replyLength");
                  //                             print(replyLength);
                  //                           });
                  //                         },
                  //                         child: Text(
                  //                           item['replies'].length.toString() +
                  //                               " replies",
                  //                           style: bold12,
                  //                         ),
                  //                       )
                  //                     : GestureDetector(
                  //                         onTap: () {
                  //                           setState(() {
                  //                             replayHead =
                  //                                 item['discussionTitle']
                  //                                     .toString();
                  //                             replaySub = item['discussionBody']
                  //                                 .toString();
                  //                             replayList = item['replies'];
                  //                             fid = item['id'].toString();
                  //
                  //                             replayTapped = true;
                  //                           });
                  //                         },
                  //                         child: Text(
                  //                           "0 replies",
                  //                           style: bold12,
                  //                         ),
                  //                       )
                  //               ],
                  //             ),
                  //             Divider(
                  //               color: Colors.black12,
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  //-------------------------------------------------------------------
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Container(
                                child: DropdownButton<String>(
                                  elevation: 2,
                                  icon: Icon(
                                    Icons.filter_list_sharp,
                                    size: 18,
                                  ),
                                  hint: Text(
                                    selected,
                                    style: txt12,
                                  ),
                                  items: <String>[
                                    'Your queries',
                                    'Top queries',
                                    'New queries',
                                    'Old queries'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      onTap: () {
                                        setState(() {
                                          selected = value.toString();
                                          isLoading = true;
                                        });

                                        if (selected == "Top queries") {
                                          getHome("", "2");
                                        }
                                        if (selected == "New queries") {
                                          getHome("", "1");
                                        }
                                        if (selected == "Old queries") {
                                          getHome("", "3");
                                        }
                                        if (selected == "Your queries") {
                                          getHome("", "0");
                                        }
                                      },
                                      child: Text(
                                        value,
                                        style: txt12,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                ),
                              ),

                              // IconButton(
                              //   onPressed: () {},
                              //   icon: Icon(Icons.sort),
                              //   iconSize: 20,
                              // ),
                            ],
                          ),
                        ),
                        arrList.length == 0
                            ? noData()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                    child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    physics: ScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 20,
                                    ),
                                    shrinkWrap: true,
                                    //itemCount: 5,
                                    itemCount:
                                        arrList != null ? arrList.length : 0,
                                    itemBuilder: (context, index) {
                                      final item = arrList != null
                                          ? arrList[index]
                                          : null;
                                      return forumQst(item, index);
                                    },
                                  ),
                                )),
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  YourQueries() {
    if (arrList.length != 0) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   // height: 50,
              //   decoration: BoxDecoration(
              //       color: Color(0xffE9E9E9),
              //       borderRadius: BorderRadius.circular(10)),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 20),
              //     child: TextFormField(
              //       cursorColor: Colors.black,
              //       autofocus: false,
              //       controller: typedQueryController,
              //       onChanged: (changed) {
              //         arrList.clear();
              //         getHome(changed);
              //         setState(() {
              //           headController.text= changed;
              //         });
              //       },
              //       onTap: () {
              //         // askQuestionBottomSheet();
              //       },
              //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              //       decoration: new InputDecoration(
              //         border: InputBorder.none,
              //         hintStyle: TextStyle(fontSize: 14),
              //         hintText: "Type your query here.",
              //         focusedBorder: InputBorder.none,
              //         enabledBorder: InputBorder.none,
              //         errorBorder: InputBorder.none,
              //         disabledBorder: InputBorder.none,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      arrList[0]['discussionTitle'].toString(),
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        yourQuires = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 8),
                      child: Icon(
                        Icons.close,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                arrList[0]['discussionBody'].toString(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
              ),
              SizedBox(
                height: 10,
              ),
              ////TODO -------------------------------------------------------------------------
              Row(
                children: [
                  Text(
                    "name",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Date",
                      style: TextStyle(fontSize: 13, color: Colors.grey[500])),
                  Spacer(), ////TODO -------------------------------------------------------------------------

                  Text(
                    arrList[0]['replies'] != null
                        ? arrList[0]['replies'].length.toString() + " Replies"
                        : "0 Replies",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  )
                ],
              ),

              SizedBox(
                height: 15,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                    shrinkWrap: true,
                    itemCount: arrList[0]['replies'] != null
                        ? arrList[0]['replies'].length
                        : 0,
                    itemBuilder: (context, index) {
                      final item = arrList[0]['replies'] != null
                          ? arrList[0]['replies'][index]
                          : null;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['replyBody'].toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                item['repliedBy'].toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Datee",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return noData;
    }
  }

  replayComment() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 9,
                child: Text(
                  replayHead,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    replayTapped = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.close,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            replaySub,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 10,
          ),

          Row(
            children: [
              Text(
                arrList[0]['askedBy'].toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              Text(arrList[0]['date'].toString(),
                  style: TextStyle(fontSize: 13, color: Colors.grey[500])),
              Spacer(),
              Text(
                replyLength.toString() + " Replies",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                  child: Scrollbar(
                // isAlwaysShown: true,
                // controller: _scrollController2,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 20,
                  ),
                  shrinkWrap: true,
                  //itemCount: 5,
                  itemCount: replayList != null ? replayList.length : 0,
                  itemBuilder: (context, index) {
                    final item = replayList != null ? replayList[index] : null;
                    return rplyQst(item, index);
                  },
                ),
              )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Color(0xffE9E9E9),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: Colors.black,
                      autofocus: false,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      controller: replyController,
                      onChanged: (changed) async {},
                      onTap: () async {},
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: "Type your reply",
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                    flex: 9,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        var rply = await postRplyApi(
                            fid, replyController.text, widget.id);

                        // askQuestionBottomSheet();
                        print("replyControllerrrrr");
                        print(replyController.text);
                        //getHome("", "1");
                        getHome("", "1");
                        setState(() {
                          replayTapped = true;
                          isLoading = true;

                          replyController.clear();
                        });
                        showToastSuccess("Reply Posted");
                      },
                      child: FittedBox(
                        child: Text(
                          "Send",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // SizedBox(
          //     height: 10,
          //     )
        ],
      ),
    );
  }

  noData() {
    return widget.isLocked != true
        ? Container()
        : Center(
            child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
            child: Column(
              children: [
                Text(
                  "Can't find what you are looking for?",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      commentTapped = true;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 85),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: darkBlue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Ask Now",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ));
  }

  askQuestion() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Scrollbar(
                child: ListView(
                  children: [

                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffE9E9E9),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, ),
                        child: Stack(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: TextFormField(
                                      controller: bodyController,
                                      cursorColor: Colors.black,
                                      maxLines: 5,
                                      keyboardType: TextInputType.multiline,
                                      autofocus: false,
                                      maxLength: 200,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(fontSize: 14),
                                        hintText: "Ask your question here",
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          commentTapped = false;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: 18,
                                      )),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          top: 10),
                      child: GestureDetector(
                        onTap: () async {
                          var rsp = await postCommentApi(widget.id,
                              headController.text, bodyController.text);
                          print("Commentpostsss");
                          print(rsp);
                          print("Commentpostsss");
                          //   Navigator.pop(context);
                          setState(() {
                            commentTapped = false;
                            typedQueryController.clear();
                            getHome("", "1");
                            isLoading = true;
                          });
                          showToastSuccess("Comment Posted!");
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 85),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: darkBlue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Post",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito'),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  editQuestion() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text(
                  "Edit Question",
                  style: bold16,
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        editQuires = false;
                      });
                    },
                    icon: Icon(
                      Icons.close,
                      size: 18,
                    ))
              ],
            ),
            Flexible(
              child: Scrollbar(
                // isAlwaysShown: true,
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffE9E9E9),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: EditHeadController,
                          cursorColor: Colors.black,
                          enableInteractiveSelection: true,
                          autofocus: false,
                          maxLength: 50,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintStyle: TextStyle(fontSize: 14),
                            hintText: "Type your question here.",
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffE9E9E9),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: EditBodyController,
                          cursorColor: Colors.black,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          autofocus: false,
                          maxLength: 200,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 14),
                            hintText: "Description here",
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          top: 15),
                      child: GestureDetector(
                        onTap: () async {
                          var rsp = await editCommentApi(
                              widget.id,
                              EditHeadController.text,
                              EditBodyController.text,
                              editQuestionList['id'].toString());
                          print("Commentpostsss");
                          print(rsp);
                          print("Commentpostsss");
                          //   Navigator.pop(context);
                          setState(() {
                            commentTapped = false;
                            editQuires = false;
                            typedQueryController.clear();
                            getHome("", "1");
                            isLoading = true;
                          });
                          showToastSuccess("Updated Posted!");
                        },
                        child: Center(
                          child: Text(
                            "Post",
                            style: TextStyle(
                                color: darkBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  ///for list view widgets<---

  forumQst(var item, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          replayHead = item['discussionTitle'].toString();
          replaySub = item['discussionBody'].toString();
          replayList = item['replies'];
          fid = item['id'].toString();

          replyLength = item['replies'] != null ? item['replies'].length : 0;
          replayTapped = true;
          print("replyLength");
          print(replyLength);
        });
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['discussionBody'].toString(),
                style: txt14,
                maxLines: 3,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                // spacing: 10,
                children: [
                  Text(
                    item['postBy'].toString(),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(item['date'].toString(),
                      style: TextStyle(fontSize: 13, color: Colors.grey[500])),
                  Spacer(),
                  item['replies'] != null
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              replayHead = item['discussionTitle'].toString();
                              replaySub = item['discussionBody'].toString();
                              replayList = item['replies'];
                              replayIndex = index;
                              fid = item['id'].toString();

                              replyLength = item['replies'].length;
                              replayTapped = true;
                              print("replyLength");
                              print(replyLength);
                            });
                          },
                          child: Text(
                            item['replies'].length.toString() + " replies",
                            style: bold12,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              replayHead = item['discussionTitle'].toString();
                              replaySub = item['discussionBody'].toString();
                              replayList = item['replies'];
                              replayIndex = index;
                              fid = item['id'].toString();

                              replyLength = item['replies'] == null
                                  ? 0
                                  : item['replies'].length;
                              replayTapped = true;
                              print("replyLength");
                              print(replyLength);
                            });
                          },
                          child: Text(
                            "0 replies",
                            style: bold12,
                          ),
                        )
                ],
              ),
              Divider(
                color: Colors.black12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  rplyQst(var item, int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                // height: 60,
                child: Text(
                  item['replyBody'].toString(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  // maxLines: 3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    item['repliedBy'].toString(),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(item['repltDate'].toString(),
                    style: TextStyle(fontSize: 13, color: Colors.grey[500])),
                // Spacer(),
                // Text(
                //   "No. of replies",
                //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
