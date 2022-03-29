import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Screens/Courses/subPages/OtherSection.dart';

class newPlayerScreen extends StatefulWidget {
  const newPlayerScreen({Key key}) : super(key: key);

  @override
  _newPlayerScreenState createState() => _newPlayerScreenState();
}

class _newPlayerScreenState extends State<newPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.1),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 233, width: double.infinity, color: themeOrange),
          h(16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "ഗാർഡനിങ് : ഹോബിയ്ക്കപ്പുറം  പ്രൊഫഷണൽ ആയി തുടങ്ങുന്നതെങ്ങനെ? ",
                        style: size16_700Mallu),
                    h(8),
                    Text("Geetha K", style: size14_400),
                    h(24),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: themeOrange),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text("Modules", style: size16_700White),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: themeOrange),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text("Forum", style: size16_700White),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text("Other", style: size16_700Red),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Container(
                          height: 1, width: double.infinity, color: grey2),
                    ),
                    OtherSection()
                    // newForum(),
                  ],
                ),
              ),
            ),
          )
          // singleQuestionPage()
        ],
      ),
      // bottomNavigationBar: askQuestion(),
    );
  }

  Widget askQuestion() {
    return Container(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Can’t find what you want? ", style: size16_400Blue),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: themeOrange),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text("Ask a question", style: size14_700W),
              ),
            )
          ],
        ),
      ),
    );
  }
}
