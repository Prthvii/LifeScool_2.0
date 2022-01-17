import 'package:flutter/material.dart';

class bookmarkIcon extends StatefulWidget {
  const bookmarkIcon({Key key}) : super(key: key);

  @override
  _bookmarkIconState createState() => _bookmarkIconState();
}

class _bookmarkIconState extends State<bookmarkIcon> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.bookmark_outline,
      color: Colors.white,
      size: 25,
    );
  }
}
