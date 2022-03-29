import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';

class Modules extends StatefulWidget {
  const Modules({Key key}) : super(key: key);

  @override
  _ModulesState createState() => _ModulesState();
}

class _ModulesState extends State<Modules> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(height: 1, width: double.infinity, color: grey2),
            ),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return modulesListView(index);
            },
          )
        ],
      ),
    );
  }

  modulesListView(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Module 1 : Introduction", style: size16_700Mallu),
        h(4),
        Text(
            "This is the descripton for this module that acts as an introduction to the course",
            style: size14_600grey),
        h(22),
        ListView.separated(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => quiz(index),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return ModeulesList(index);
          },
        ),
      ],
    );
  }

  Widget quiz(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.question_circle_fill, color: selectedRed),
              w(12),
              Text("What should I remember?", style: size16_400)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              children: [
                Text("quiz", style: size14_600grey),
                w(10),
                Icon(Icons.check, size: 12, color: tertiaryGreen)
              ],
            ),
          ),
        ],
      ),
    );
  }

  ModeulesList(int index) {
    return ExpansionTile(
      title: Text("1: Introduction", style: size16_400),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            Text("video" + " • " "2 mins", style: size14_600grey),
            w(10),
            Icon(Icons.check, size: 12, color: tertiaryGreen)
          ],
        ),
      ),
      childrenPadding: EdgeInsets.symmetric(horizontal: 25),
      children: <Widget>[
        Row(
          children: [
            lessonContainers(
                "Synopsis", lifescool_highlight, themeOrange, () {}),
            w(16),
            lessonContainers(
                "Downloads", lifescool_highlight, themeOrange, () {}),
            w(16),
            Container(
              height: 35,
              width: 44,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: lifescool_highlight),
              child: Icon(
                Icons.link,
                color: themeOrange,
                size: 20,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget lessonContainers(
      String Txt, Color clr, Color txtClr, GestureTapCallback onTapp) {
    return GestureDetector(
      onTap: onTapp,
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), color: clr),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            Txt,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: txtClr,
                fontSize: 14,
                fontFamily: 'Nunito'),
          ),
        ),
      ),
    );
  }
}
