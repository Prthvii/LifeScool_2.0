import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';

class ForumReplies extends StatelessWidget {
  // const ForumReplies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "I can't find the selection box now. It was using it before saving, but cant seem to find it now. Please help",
          style: txt14,
          // maxLines: 3,
        ),
        Row(
          // spacing: 10,
          children: [
            Text(
              "Arjun S",
              style: txt12,
            ),
            SizedBox(
              width: 10,
            ),
            Text("2 days ago",
                style: TextStyle(fontSize: 13, color: Colors.grey[500])),
          ],
        )
      ],
    );
  }
}
