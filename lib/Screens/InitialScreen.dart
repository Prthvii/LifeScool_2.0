import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Const/TextConstants.dart';
import 'package:lifescool/Screens/EnterNum.dart';

class InitialScreen extends StatefulWidget {
  // const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: gradientTopBottom),
            height: double.infinity,
            width: double.infinity,
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       top: MediaQuery.of(context).size.height * 0.2,
          //       left: 10,
          //       right: 10),
          //   child: Align(
          //     alignment: Alignment.topCenter,
          //     child: Image.asset("assets/images/initial.png"),
          //   ),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    "assets/images/initial.png",
                    width: MediaQuery.of(context).size.width * 0.75,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color(0xffE94822)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  InitialPage1,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0xffFFF7AF),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: ss.height * 0.02,
                                ),
                                Text(
                                  InitialPageMal,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Mallu',
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: ss.height * 0.02,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                EntNum()));
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                      color: Color(0xff2F455C),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      child: Text(
                                        strtLern,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xffFCFCFC),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          // Positioned(
                          //   bottom: 20,
                          //   child: InkWell(
                          //     onTap: () {
                          //       Navigator.pushReplacement(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (BuildContext context) =>
                          //                   EntNum()));
                          //     },
                          //     child: Container(
                          //       width: MediaQuery.of(context).size.width * 0.7,
                          //       decoration: BoxDecoration(
                          //         color: Color(0xff2F455C),
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //       child: Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //           vertical: 15,
                          //         ),
                          //         child: Text(
                          //           strtLern,
                          //           textAlign: TextAlign.center,
                          //           style: TextStyle(
                          //               color: Color(0xffFCFCFC),
                          //               fontSize: 16,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
