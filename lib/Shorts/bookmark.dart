import 'package:flutter/material.dart';

class bookmarkIcon extends StatefulWidget {



  const bookmarkIcon({Key key}) : super(key: key);

  @override
  _bookmarkIconState createState() => _bookmarkIconState();
}

class _bookmarkIconState extends State<bookmarkIcon> {
  var likeTap = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (likeTap == true) {
          setState(() {
            likeTap = false;
          });
        } else {
          setState(() {
            likeTap = true;
          });
        }
      },
      child: likeTap == false ?Icon(
        Icons.bookmark_outline,
        color: Colors.white,
        size: 25,
      ): Icon(
    Icons.bookmark,
    color: Colors.white,
    size: 25,
    ),
    );
  }
}
