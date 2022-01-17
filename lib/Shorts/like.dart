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
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: Icon(
        Icons.favorite,
        color: likeTap == true ? Colors.red : Colors.grey,
      ),
      radius: 20,
    );
  }
}
