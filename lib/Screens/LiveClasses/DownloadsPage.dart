import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({Key key}) : super(key: key);

  @override
  _DownloadsPageState createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  radius: 24,
                  backgroundColor: grey2,
                ),
              ),
            ),
            w(16),
            Text(
              "Downloads",
              style: size16_700Mallu,
            )
          ],
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => SizedBox(height: 8),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return list(index);
          },
        ),
      ),
    );
  }

  list(int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: greyClr,
          border: Border.all(color: grey2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
        child: Row(
          children: [
            Text("1. Source files", style: size14_400),
            Spacer(),
            Image.asset("assets/Icons/downloadIcons.png", height: 20, width: 20)
          ],
        ),
      ),
      // child: ,
    );
  }
}
