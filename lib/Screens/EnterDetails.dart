import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Const/TextConstants.dart';
import 'package:lifescool/Screens/Terms&Conditions.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Api/signupUser.dart';
import '../Helper/sharedPref.dart';
import '../Helper/snackbar_toast_helper.dart';
import 'OnBoardingScreen.dart';

class EnterDetails extends StatefulWidget {
  final mob;
  EnterDetails({this.mob});

  @override
  _EnterDetailsState createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  bool isTap = false;
  int textLength = 0;

  static String birthDateValidator(String value) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(now);
    String str1 = value;
    List<String> str2 = str1.split('/');
    String month = str2.isNotEmpty ? str2[0] : '';
    String day = str2.length > 1 ? str2[1] : '';
    String year = str2.length > 2 ? str2[2] : '';
    if (value.isEmpty) {
      return 'BirthDate is Empty';
    } else if (int.parse(month) > 13) {
      return 'Month is invalid';
    } else if (int.parse(day) > 32) {
      return 'Day is invalid';
    } else if ((int.parse(year) > int.parse(formatted))) {
      return 'Year is invalid';
    } else if ((int.parse(year) < 1920)) {
      return 'Year is invalid';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(gradient: gradientTopBottom),
              height: double.infinity,
              width: double.infinity,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Lottie.asset(
                "assets/images/onBoard.json",
                height: MediaQuery.of(context).size.height * 0.45,
                fit: BoxFit.fitWidth,
                repeat: true,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 23, vertical: 15),
                child: Container(

                  // height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xffE94822)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height*0.01,),

                            Text(
                              signup,
                              textAlign: TextAlign.center,
                              style:  TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'Nunito',),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.02,),

                            nameTxtField(),
                            dateTxtField(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 5),
                              child: FittedBox(
                                child: RichText(
                                  text: TextSpan(
                                      text:
                                          'By creating an account you agree to our',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontFamily: 'Nunito',
                                          fontSize: 12),
                                      children: [
                                        TextSpan(
                                          text: ' terms & policies',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              _launchURLApp();
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           TermsNCon()),
                                              // );
                                            },
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationThickness: 2,
                                              color: Colors.white,
                                              fontSize: 12),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  isTap = true;
                                });
                                var rsp = await signUpApi(widget.mob.toString(),
                                    nameController.text, dateController.text);
                                print("rsp['attributes']");
                                print(rsp);

                                // Map valueMap = jsonDecode(rsp.toString());
                                // print(rsp['attributes']['message']);

                                if (rsp['attributes']['message'].toString() ==
                                    "Success") {
                                  print("home");
                                  showToastSuccess("Account Created!");
                                  print(rsp['attributes']['studentInfo'][0]
                                  ['studentId']);
                                  var id = await setSharedPrefrence(
                                      ID,
                                      rsp['attributes']['studentInfo'][0]
                                      ['studentId']
                                          .toString());
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OnBoardPage(
                                            name:
                                            nameController.text.toString())),
                                  );
                                } else {
                                  showToastSuccess("Error occured!");
                                }

                                setState(() {
                                  isTap = false;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  color: Color(0xff2F455C),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: isTap == true
                                      ? Image.asset(
                                    "assets/images/loading.gif",
                                    height: 20,
                                  )
                                      : Text(
                                    "Done",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xffFCFCFC),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.04,),

                          ],
                        ),
                        // Positioned(
                        //   bottom: 20,
                        //   child: InkWell(
                        //     onTap: () async {
                        //       setState(() {
                        //         isTap = true;
                        //       });
                        //       var rsp = await signUpApi(widget.mob.toString(),
                        //           nameController.text, dateController.text);
                        //       print("rsp['attributes']");
                        //       print(rsp);
                        //
                        //       // Map valueMap = jsonDecode(rsp.toString());
                        //       // print(rsp['attributes']['message']);
                        //
                        //       if (rsp['attributes']['message'].toString() ==
                        //           "Success") {
                        //         print("home");
                        //         showToastSuccess("Account Created!");
                        //         print(rsp['attributes']['studentInfo'][0]
                        //             ['studentId']);
                        //         var id = await setSharedPrefrence(
                        //             ID,
                        //             rsp['attributes']['studentInfo'][0]
                        //                     ['studentId']
                        //                 .toString());
                        //         Navigator.pushReplacement(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => OnBoardPage(
                        //                   name:
                        //                       nameController.text.toString())),
                        //         );
                        //       } else {
                        //         showToastSuccess("Error occured!");
                        //       }
                        //
                        //       setState(() {
                        //         isTap = false;
                        //       });
                        //     },
                        //     child: Container(
                        //       width: MediaQuery.of(context).size.width * 0.5,
                        //       decoration: BoxDecoration(
                        //         color: Color(0xff2F455C),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       child: Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //           vertical: 15,
                        //         ),
                        //         child: isTap == true
                        //             ? Image.asset(
                        //                 "assets/images/loading.gif",
                        //                 height: 20,
                        //               )
                        //             : Text(
                        //                 "Done",
                        //                 textAlign: TextAlign.center,
                        //                 style: TextStyle(
                        //                     color: Color(0xffFCFCFC),
                        //                     fontSize: 16,
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  nameTxtField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Color(0xffE9E9E9), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          cursorColor: Colors.black,
          autofocus: false,
          controller: nameController,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          decoration: new InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 14),
            hintText: "Name",
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  dateTxtField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Color(0xffE9E9E9), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          cursorColor: Colors.black54,
          autofocus: false,
          controller: dateController,
          onChanged: (changed) {
            print("lengthh");
            print(dateController.text.length);
            print(textLength);
            if (dateController.text.length < textLength) {
              textLength = dateController.text.length;
              return;
            }
            setState(() {
              if (dateController.text.length == 2) {
                dateController.text = dateController.text.toString() + "/";
                dateController.selection = TextSelection.fromPosition(
                    TextPosition(offset: dateController.text.length));
              }
              if (dateController.text.length == 5) {
                dateController.text = dateController.text.toString() + "/";
                dateController.selection = TextSelection.fromPosition(
                    TextPosition(offset: dateController.text.length));
              }
              textLength = dateController.text.length;
            });
          },
          keyboardType: TextInputType.datetime,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          decoration: new InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 14),
            hintText: "Date of Birth                  DD/MM/YYYY",
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
  _launchURLApp() async {
    const url = 'https://www.lifescool.app/terms-and-conditions/';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
