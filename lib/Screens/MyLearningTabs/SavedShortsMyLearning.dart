import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';

class SavedShorts extends StatefulWidget {
  const SavedShorts({Key key}) : super(key: key);

  @override
  _SavedShortsState createState() => _SavedShortsState();
}

class _SavedShortsState extends State<SavedShorts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: lifescool_highlight,
                radius: 22,
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
            w(12),
            Text("Saved Shorts", style: size14_700),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scrollbar(
          interactive: true,
          child: GridView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 15,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 90 / 158),
            itemBuilder: (BuildContext context, int index) {
              return Item(index);
            },
          ),
        ),
      ),
    );
  }

  Item(int index) {
    return Container(
      width: 90,
      height: 158,
      color: themeOrange,
      child: Image.network(
        testImg,
        fit: BoxFit.cover,
      ),
    );
  }
}
