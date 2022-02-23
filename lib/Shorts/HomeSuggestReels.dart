import 'package:flutter/material.dart';
import 'package:lifescool/Shorts/NewTstShortVideoPage.dart';

class HomeReels extends StatefulWidget {
  // const HomeReels({Key? key}) : super(key: key);
  var reelsArr;


  HomeReels({this.reelsArr});
  @override
  _HomeReelsState createState() => _HomeReelsState();
}

class _HomeReelsState extends State<HomeReels> {



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 188,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: 8,
        ),
        shrinkWrap: true,
        itemCount: widget.reelsArr.length != 0 ?  widget.reelsArr.length : 0,
        itemBuilder: (context, index) {
          final item =  widget.reelsArr != null ?  widget.reelsArr[index] : null;
          return reels(item, index);
        },
      ),
    );
  }

  reels(var item, int index) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) => MyLearningNew()),
              builder: (context) => NewTstShortsPlayerPage(highligts: item,)),
        );
      },
      child: Container(
        height: 188,
        width: 106,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                image: NetworkImage(
                  item['thumbnail_url'].toString(),
                ),
                fit: BoxFit.cover)),
      ),
    );
  }
}
