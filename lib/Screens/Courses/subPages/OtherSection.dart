import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifescool/Const/Constants.dart';

class OtherSection extends StatefulWidget {
  const OtherSection({Key key}) : super(key: key);

  @override
  _OtherSectionState createState() => _OtherSectionState();
}

class _OtherSectionState extends State<OtherSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: grey2)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
            child: Row(
              children: [
                Icon(CupertinoIcons.text_justifyleft, size: 20),
                w(8),
                Text("Course Brief", style: size14_600)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: grey2)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
              child: Row(
                children: [
                  SvgPicture.asset("assets/svg/news.svg"),
                  w(8),
                  Text("News", style: size14_600)
                ],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: grey2)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
            child: Row(
              children: [
                Icon(Icons.share, size: 20),
                w(8),
                Text("Share", style: size14_600)
              ],
            ),
          ),
        ),
        h(MediaQuery.of(context).size.height * 0.1)
      ],
    );
  }
}
