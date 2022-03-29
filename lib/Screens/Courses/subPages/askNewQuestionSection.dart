import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifescool/Const/Constants.dart';

class askANewQuestion extends StatefulWidget {
  const askANewQuestion({Key key}) : super(key: key);

  @override
  _askANewQuestionState createState() => _askANewQuestionState();
}

class _askANewQuestionState extends State<askANewQuestion> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Icon(Icons.arrow_back, size: 20),
            ),
            Center(child: SvgPicture.asset("assets/svg/ask.svg", height: 190)),
            h(8),
            Center(
              child: Text(
                  "Ask us what you want to know. \n We will notify you once you receive a reply",
                  textAlign: TextAlign.center,
                  style: size16_400grey),
            ),
            h(32),
            Center(child: Text("Type your question", style: size16_700Mallu)),
            h(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: grey2),
                    color: greyClr,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    maxLines: 5,
                    autofocus: false,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintStyle: size14_400G,
                      hintText: "Write here",
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            h(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Spacer(),
                  Text(
                    "50 words",
                    style: size14_400,
                  ),
                ],
              ),
            ),
            h(40),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: themeOrange),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text("Submit", style: size14_700W),
                ),
              ),
            ),
            h(24)
          ],
        ),
      ),
    );
  }
}
