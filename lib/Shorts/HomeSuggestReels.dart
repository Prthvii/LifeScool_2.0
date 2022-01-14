import 'package:flutter/material.dart';

class HomeReels extends StatefulWidget {
  // const HomeReels({Key? key}) : super(key: key);

  @override
  _HomeReelsState createState() => _HomeReelsState();
}

class _HomeReelsState extends State<HomeReels> {
  final reelsArr = [
    "https://iso.500px.com/wp-content/uploads/2014/07/Elliott-and-His-Hen-Cover-Image.jpg",
    "https://i0.wp.com/digital-photography-school.com/wp-content/uploads/2021/03/portrait-photography-tips-4-1.jpg?resize=1500%2C1000&ssl=1",
    "https://i0.wp.com/digital-photography-school.com/wp-content/uploads/2021/03/portrait-photography-tips-3.jpg?resize=1500%2C1000&ssl=1",
    "https://stylecaster.com/wp-content/uploads/2020/08/insta-reels.gif",
    "https://foundr.com/wp-content/uploads/2021/08/instagram-reels.png"
  ];
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
        itemCount: reelsArr.length != 0 ? reelsArr.length : 0,
        itemBuilder: (context, index) {
          final item = reelsArr != null ? reelsArr[index] : null;
          return reels(item, index);
        },
      ),
    );
  }

  reels(var item, int index) {
    return Container(
      height: 188,
      width: 106,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: NetworkImage(
                item.toString(),
              ),
              fit: BoxFit.cover)),
    );
  }
}
