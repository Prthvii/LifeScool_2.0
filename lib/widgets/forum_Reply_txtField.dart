import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';

class ReplytxtField extends StatelessWidget {
  // const ReplytxtField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffE9E9E9), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                cursorColor: Colors.black,
                autofocus: false,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 14),
                  hintText: "Type your reply.",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Send",
                style: bold14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
