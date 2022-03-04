import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';

class TutorShortsTab extends StatefulWidget {
  const TutorShortsTab({Key key}) : super(key: key);

  @override
  _TutorShortsTabState createState() => _TutorShortsTabState();
}

class _TutorShortsTabState extends State<TutorShortsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          h(16),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Shorts",
              style: size14_700,
            ),
          ),
          h(8),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Playlist",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
          h(8),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Container(
              height: 230,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(
                  width: 10,
                ),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return shortsList(index);
                },
              ),
            ),
          ),
          h(16),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Videos",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
          h(8),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Container(
              height: 324,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75),
                itemBuilder: (BuildContext context, int index) {
                  return videosGrid(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  shortsList(int index) {
    return Column(
      children: [
        Container(
          height: 188,
          width: 106,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(testImg), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
            color: themeOrange,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 42,
                  width: 106,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 20,
                        ),
                        w(8),
                        Text("12", style: size14_600W)
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      color: Colors.black26),
                ),
              )
            ],
          ),
        ),
        h(8),
        SizedBox(
          child: Text("Easy Dancing videos list", style: size14_400),
          width: 106,
        )
      ],
    );
  }

  videosGrid(int index) {
    return Container(
      width: 90,
      height: 158,
      color: Colors.red,
    );
  }
}
