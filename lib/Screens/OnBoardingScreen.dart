import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'HomePage.dart';

class OnBoardPage extends StatefulWidget {
  final name;
  OnBoardPage({this.name});
  @override
  _OnBoardPageState createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          final sh = MediaQuery.of(context).size.height;
          // _controller.jumpTo(sh);

          _controller.animateTo(_controller.position.maxScrollExtent,
              duration: Duration(seconds: 1), curve: Curves.decelerate);
        },
        child: Image.asset(
          "assets/images/arrow.png",
          height: 90,
          width: 90,
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.1),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FirstContainer(),
            // HandContainer(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            LearnInMal(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            LifeLongLearner(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Skills(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Forum(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Teachers(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Knowledge(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Button(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  FirstContainer() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Lottie.asset(
            "assets/images/onBoard.json",
            height: MediaQuery.of(context).size.height * 0.45,
            fit: BoxFit.fitWidth,
            repeat: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.25,
              left: 15,
              right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "നമസ്കാരം",
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Mallu',
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2F455C)),
              ),
              Text(
                widget.name.toString() + ",",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFC4834)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffFFF2F0),
                    borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/images/shakeHand.png"),
                      Text(
                        "ലൈഫ്സ്‌കൂളിലേക്ക് സ്വാഗതം. ഏതു പ്രായക്കാർക്കും വിവിധ വിഷയങ്ങളിൽ പഠനം സാധ്യമാക്കുക എന്ന കാഴ്ചപ്പാടോടു കൂടി അവതരിപ്പിക്കുന്ന ഈ മൊബൈൽ ആപ്പിന്റെ ആദ്യത്തെ ഉപയോക്താക്കളിൽ ഒരാളാണ് താങ്കൾ. ",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Mallu',
                            color: Color(0xff2F455C)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "പരീക്ഷണാടിസ്ഥാനത്തിൽ പുറത്തിറക്കുന്ന ഈ ആപ്പിൽ നിങ്ങൾക്ക് ഏതെങ്കിലും രീതിയിലുള്ള അസൗകര്യങ്ങൾ നേരിട്ടാൽ ഞങ്ങളെ അറിയിക്കണമെന്ന് അഭ്യർത്ഥിക്കുന്നു. നിങ്ങളുടെ വിലയേറിയ അഭിപ്രായങ്ങളുടെ അടിസ്ഥാനത്തിൽ ഈ ആപ്പിലൂടെ ഏറ്റവും മികച്ച പഠനാനുഭവം ഒരുക്കാൻ ഞങ്ങൾ പ്രതിജ്ഞാബദ്ധമാണ്. ",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Mallu',
                            color: Color(0xff2F455C)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  LearnInMal() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: (Colors.grey[200]),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(1, 0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                children: [
                  Expanded(
                    // flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Learn in Malayalam",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "ഇഷ്ടമുള്ളതെന്തും മാതൃഭാഷയിൽ പഠിക്കാം. എവിടെയും, എപ്പോഴും, ഏതു പ്രായത്തിലും.",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Mallu',
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    "assets/images/a.png",
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  LifeLongLearner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color(0xff2F455C),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                children: [
                  Expanded(
                    // flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Be a lifelong learner",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "സാമ്പ്രദായിക വിദ്യാഭ്യാസ രീതികളിൽ ഒതുങ്ങാതെ പുതിയ കാര്യങ്ങൾ പഠിച്ചുകൊണ്ടേയിരിക്കാം.",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Mallu',
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    "assets/images/learner.png",
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Skills() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xffFFF9E8),
          borderRadius: BorderRadius.circular(24),
          image: DecorationImage(
              image: AssetImage("assets/images/Lifeskills_rectangle.png"))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            Text(
              "Discover a wide range of skills",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset("assets/images/lang.png"),
            SizedBox(
              height: 20,
            ),
            Text(
              "കല, കരകൗശലം, ഭാഷ, ടെക്‌നോളജി, ഫിറ്റ്നസ്`തുടങ്ങി അനവധി മേഖലകളിലായി താല്പര്യമുള്ള കോഴ്‌സുകൾ കണ്ടെത്താം.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Mallu',
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Forum() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xffFFF9E8), borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            Text(
              "Learn together though Discussion Forum",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset("assets/images/forum.png"),
            SizedBox(
              height: 20,
            ),
            Text(
              "ഡിസ്കഷൻ ഫോറങ്ങളിലൂടെ സഹപാഠികളുമായോ സംവദിച്ച് ഒരുമിച്ചു പഠിക്കാനുള്ള സൗകര്യം.",
              // textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Mallu',
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Teachers() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Color(0xffDC900A)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            Text(
              "Not just teachers, but lifluencers",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "അതതു മേഖലകളിൽ പ്രാവീണ്യം തെളിയിച്ച ആർട്ടിസ്റ്റുകളും പ്രൊഫഷണലുകളും ഇൻഫ്ലുൻസർമാരും അടങ്ങുന്ന ട്രെയിനർ പാനൽ.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Mallu',
                  color: Colors.white),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 21,
                  width: 21,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white70),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage("assets/images/h1.png"))),
                ),
                Container(
                  height: 21,
                  width: 21,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white70),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage("assets/images/h2.png"))),
                ),
                Container(
                  height: 21,
                  width: 21,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white70),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage("assets/images/h3.png"))),
                ),
                Container(
                  height: 21,
                  width: 21,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white70),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Knowledge() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(colors: [
                Color(0xff5F9933),
                Color(0xff1FC578),
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                children: [
                  Expanded(
                    // flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Certify your knowledge",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "കോഴ്‌സുകൾ വിജയകരമായി പൂർത്തീകരിച്ച് സെർട്ടിഫിക്കറ്റ് കരസ്ഥമാക്കാം.",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Mallu',
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    "assets/images/stars.png",
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Button() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 65),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: (Colors.white),
              spreadRadius: 50,
              blurRadius: 10,
              offset: Offset(
                0,
                60,
              ),
            ),
          ],
          color: Color(0xff2F455C),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            "Continue to Lifescool",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
