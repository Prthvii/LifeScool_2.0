import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';


class SongBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 15,
            color: Color(0xFF757575).withOpacity(.8),
          )
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(
                image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmfIJ5ZPIJv1jwNXm3zDmpleT2mkGE8_S7IunKxuaFPjB7Ng9jUv6aBOjWjN3Zdm7ofzY&usqp=CAU"),
                fit: BoxFit.fill,
                height: height * 0.075,
                width: width * 0.15,
              ),
            ),
          ),
          Expanded(
              child: GestureDetector(
                  onTap: () {

                  },
                  child: Text(
                    "Now Playing",
                    style: size14_600,
                    maxLines: 1,
                  ))),
          // GestureDetector(
          //     child: Icon(
          //       Icons.skip_previous,
          //       color: Colors.black,
          //       size: width * 0.08,
          //     ),
          //     onTap: () {
          //
          //     }),
//        Icon(playIcon, color: Colors.black, size: width * 0.16),
          GestureDetector(
              child: Icon(Icons.play_arrow, color: Colors.black, size: width * 0.10),
              onTap: () {}),
          // GestureDetector(
          //     child: Icon(Icons.skip_next,
          //         color: Colors.black, size: width * 0.08),
          //     onTap:   () {}),
        ],
      ),
    );
  }
}