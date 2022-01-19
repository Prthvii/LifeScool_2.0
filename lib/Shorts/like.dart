import 'package:flutter/material.dart';

class LikeIcon extends StatefulWidget {
  const LikeIcon({Key key}) : super(key: key);

  @override
  _LikeIconState createState() => _LikeIconState();
}

class _LikeIconState extends State<LikeIcon> {
  var likeTap = false;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite,
      size: 30,
      color: likeTap == true ? Colors.red : Colors.grey,
    );
  }
}
