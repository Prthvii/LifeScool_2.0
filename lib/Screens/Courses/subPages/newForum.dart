import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';

class newForum extends StatefulWidget {
  const newForum({Key key}) : super(key: key);

  @override
  _newForumState createState() => _newForumState();
}

class _newForumState extends State<newForum> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 46,
              width: 46,
              child: Icon(Icons.filter_list, size: 20),
              decoration: BoxDecoration(
                  color: greyClr,
                  shape: BoxShape.circle,
                  border: Border.all(color: grey2)),
            ),
            w(8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: greyClr,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: grey2)),
                child: TextFormField(
                  cursorColor: Colors.black,
                  autofocus: false,
                  // controller: typedQueryController,
                  onChanged: (changed) {},
                  onTap: () {},
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    prefixIcon:
                        Icon(Icons.search, color: Colors.black, size: 20),
                    hintStyle: size16_400grey,
                    hintText: "What are you looking for?",
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            )
          ],
        ),
        h(16),
        ListView.separated(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(
            height: 16,
          ),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return forumQuestionsList(index);
          },
        )
      ],
    );
  }

  forumQuestionsList(int index) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => singleQuestionPage()),
        // );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: grey2)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("What is the most important thing to focus on in gardening?",
                  style: size16_700Mallu),
              h(8),
              Row(
                children: [
                  Text("Preetha", style: size14_400),
                  Spacer(),
                  Icon(CupertinoIcons.conversation_bubble,
                      size: 20, color: grey5),
                  Text("5", style: size14_400G)
                ],
              ),
              h(16),
              Text(
                  "To simplify it, there are five main things you should focus on when gardening: sun, soil gardening: sun, soil  gardening: sun, soil gardening: sun, soil ",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: size14_400G)
            ],
          ),
        ),
      ),
    );
  }
}
