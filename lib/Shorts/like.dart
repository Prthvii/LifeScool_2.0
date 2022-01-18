import 'package:flutter/material.dart';

class LikeIcon extends StatefulWidget {

  var like;


  LikeIcon({this.like,});
  //const LikeIcon({Key key}) : super(key: key);

  @override
  _LikeIconState createState() => _LikeIconState();
}

class _LikeIconState extends State<LikeIcon> {
  var likeTap = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (widget.like == true) {
          setState(() {
            widget.like = false;
          });
        } else {
          setState(() {
            widget.like = true;
          });
        }
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.favorite,
          color: widget.like == true ? Colors.red : Colors.grey,
        ),
        radius: 20,
      ),
    );
  }
}
