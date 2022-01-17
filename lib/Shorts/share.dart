import 'package:flutter/material.dart';

class shareIcon extends StatefulWidget {
  const shareIcon({Key key}) : super(key: key);

  @override
  _shareIconState createState() => _shareIconState();
}

class _shareIconState extends State<shareIcon> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.share,
      color: Colors.white,
      size: 25,
    );
  }
}
