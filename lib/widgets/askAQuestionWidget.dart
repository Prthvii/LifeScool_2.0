import 'package:flutter/material.dart';
import 'package:lifescool/Api/PostComment.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';

class askQuestion extends StatefulWidget {
  final id;

  askQuestion({this.id});

  @override
  _askQuestionState createState() => _askQuestionState();
}

class _askQuestionState extends State<askQuestion> {
  TextEditingController headController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "Ask Question",
                  style: bold16,
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      size: 18,
                    ))
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xffE9E9E9),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: headController,
                  cursorColor: Colors.black,
                  enableInteractiveSelection: true,
                  autofocus: false,
                  maxLength: 50,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintStyle: TextStyle(fontSize: 14),
                    hintText: "Type your question here.",
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xffE9E9E9),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: bodyController,
                  cursorColor: Colors.black,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  autofocus: false,
                  maxLength: 200,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 14),
                    hintText: "Description here",
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: GestureDetector(
                onTap: () async {
                  var rsp = await postCommentApi(
                      widget.id, headController.text, bodyController.text);
                  print("Commentpostsss");
                  print(rsp);
                  print("Commentpostsss");
                  Navigator.pop(context);
                  showToastSuccess("Comment Posted!");
                },
                child: Text(
                  "Post",
                  style: TextStyle(
                      color: Color(0xff4236F1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
