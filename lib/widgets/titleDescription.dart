import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/colorConverter.dart';
import 'package:lifescool/Screens/SingleCourseScreen.dart';
import 'package:lifescool/Screens/TutorInfo.dart';
import 'package:lifescool/Screens/courseIntroduction.dart';

class titleDescription extends StatefulWidget {
  final data;
  final id;
  final cuid;
  titleDescription({this.data, this.id, this.cuid});

  @override
  _titleDescriptionState createState() => _titleDescriptionState();
}

class _titleDescriptionState extends State<titleDescription> {
  String _title = 'More';
  @override
  Widget build(BuildContext context) {
    print("mukalilllkitnnindo");
    print(widget.id);
    print(widget.cuid);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: (Colors.grey[300]),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5, top: 10, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.data[0]['courseNameEng'].toString(),
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Mallu',
                color: hexToColor(widget.data[0]["primaryColor"].toString()),
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // SizedBox(
            //   height: 5,
            // ),
            Text(
              widget.data[0]['courseNameMal'].toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TutorInfo(
                              id: widget.data[0]['authorId'].toString())),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xfffaf6f5)),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                widget.data[0]['profileImageUrl'].toString()),
                            fit: BoxFit.contain)),
                    height: 30,
                    width: 30,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  widget.data[0]['authorName'].toString(),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  widget.data[0]['courseDuration'].toString(),
                  style: bold12,
                ),
                blackDot(),
                Text(
                  widget.data[0]['totalVideolength'].toString(),
                  style: bold12,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SingleCourse(
                              title: widget.data[0]['courseCategoryDisplay']
                                  .toString(),
                              id: widget.data[0]['courseCategoryId']
                                  .toString())),
                    );
                  },
                  child: Text(
                    widget.data[0]['courseCategoryDisplay'].toString(),
                    style: bold12,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    print("ivdeeeeeee");
                    print(widget.id);
                    print(widget.cuid);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CourseIntroduction(
                              id: widget.id.toString(),
                              cuid: widget.cuid.toString(),
                              frmButton: true)),
                    );
                  },
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Course Overview",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: hexToColor(
                                  widget.data[0]["primaryColor"].toString()),
                              fontFamily: 'Nunito'),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.info_outline,
                          size: 15,
                          color: hexToColor(
                              widget.data[0]["primaryColor"].toString()),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
            // moreExpansion(widget.data[0]['courseSummary']),
          ],
        ),
      ),
    );
  }

  Widget blackDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        height: 5,
        width: 5,
      ),
    );
  }

  Widget moreExpansion(var txt) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      initiallyExpanded: false,
      childrenPadding: EdgeInsets.all(10),
      onExpansionChanged: (expanded) =>
          setState(() => _title = expanded ? 'Hide' : 'More'),
      trailing: Icon(
        Icons.keyboard,
        color: Colors.white,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _title,
            style: bold14,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 15,
          )
        ],
      ),
      children: <Widget>[
        Container(
          child: ListView(children: [Text(txt.toString())]),
          height: MediaQuery.of(context).size.height * 0.25,
        )
      ],
    );
  }
}
