import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';

import 'LiveClassScreen.dart';

class LiveClass extends StatefulWidget {
  final data;
  const LiveClass({Key key, this.data}) : super(key: key);

  @override
  _LiveClassState createState() => _LiveClassState();
}

class _LiveClassState extends State<LiveClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        title: Text("Live Classes", style: appBarTxtStyl),
      ),
      body: Scrollbar(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(
            height: 15,
          ),
          shrinkWrap: true,
          itemCount: 2,
          // itemCount: arrList != null ? arrList.length : 0,
          itemBuilder: (context, index) {
            final item = widget.data != null ? widget.data[index] : null;
            return LiveClassCards(item, index);
          },
        ),
      ),
    );
  }

  LiveClassCards(var item, int index) {
    return GestureDetector(
      onTap: (){
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => PlayerScreen(
        //         id: item['id'].toString(),
        //         cuid: item['courseUid'].toString(),
        //       )),
        // );
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LiveClassScreen()),
      );},
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['courseNameEng'].toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Mallu',
                                    fontWeight: FontWeight.w700,
                                    color: darkBlue),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0xfffaf6f5)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        item['thumbnailUrl'].toString()),
                                    fit: BoxFit.cover)),
                            height: 62,
                            width: 93,
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
                            "4 weeks",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito',
                                color: darkBlue),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child:
                                Container(height: 12, width: 2, color: darkBlue),
                          ),
                          Text(
                            "20 live sessions",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Nunito',
                                color: darkBlue),
                          )
                        ],
                      ),
                      Spacer(),
                      Text(
                        item['tutorName'].toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Color(0xfffaf6f5)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    item['tutorProfileImage'].toString()),
                                fit: BoxFit.cover)),
                        height: 24,
                        width: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: gradientGreen,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Batch starts on Jan 26",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff2FB134)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
