import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';

class singleQuestionPage extends StatefulWidget {
  const singleQuestionPage({Key key}) : super(key: key);

  @override
  _singleQuestionPageState createState() => _singleQuestionPageState();
}

class _singleQuestionPageState extends State<singleQuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, left: 20, bottom: 20),
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "What is the most important thing to focus on in gardening?",
                            style: size16_700Mallu),
                        h(8),
                        Text("Preetha", style: size14_400),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Container(
                              height: 1, width: double.infinity, color: grey2),
                        ),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Container(
                                height: 1,
                                width: double.infinity,
                                color: grey2),
                          ),
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return qstList(index);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: grey5)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        autofocus: false,
                        // controller: typedQueryController,
                        onChanged: (changed) {},
                        onTap: () {},
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 13),
                          hintStyle: size16_400grey,
                          hintText: "Reply",
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  qstList(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "To simplify it, there are five main things focus on when gardening: sun, soil, spacing, water and nutrients. ",
                  style: size16_400grey),
              h(8),
              Text("Sangeeth", style: size14_400G)
            ],
          ),
        ),
        w(16),
        Column(
          children: [
            Icon(
              Icons.favorite_outlined,
              color: grey5,
              size: 20,
            ),
            h(6),
            Text("50", style: size14_400G)
          ],
        )
      ],
    );
  }
}
