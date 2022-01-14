import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';

class TermsNCon extends StatefulWidget {
  // const TermsNCon({Key? key}) : super(key: key);

  @override
  _TermsNConState createState() => _TermsNConState();
}

class _TermsNConState extends State<TermsNCon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 18,
            )),
        title: Text(
          "Terms & Policies",
          style: appBarTxtStyl,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
      ),
    );
  }
}
