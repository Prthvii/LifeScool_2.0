import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifescool/Api/sendOtp.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Const/TextConstants.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Screens/OTPScreen.dart';
import 'package:lottie/lottie.dart';

import 'HomePage.dart';

class EntNum extends StatefulWidget {
  // const EntNum({Key? key}) : super(key: key);

  @override
  _EntNumState createState() => _EntNumState();
}

class _EntNumState extends State<EntNum> {
  TextEditingController numController = new TextEditingController();
  // TextEditingController otpController = new TextEditingController();
  // TextEditingController nameController = new TextEditingController();
  // TextEditingController dateController = new TextEditingController();
  bool isTap = false;

  @override
  void initState() {
    super.initState();
    this.navigationHome();
  }

  void navigationHome() async {
    var id = await getSharedPrefrence(ID);
    if (id != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  void enableTap() {
    setState(() {
      isTap = true;
    });
  }

  void disableTap() {
    setState(() {
      isTap = false;
    });
  }

  Future<bool> _onBackPressed() {
    Navigator.of(context).pop();

    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: gradientTopBottom,
              ),
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
                  height: MediaQuery.of(context).size.height * 0.34,
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
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                EntrNum,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            number(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "We'll send an OTP for verification to this number",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        Positioned(
                          bottom: 20,
                          child: InkWell(
                            onTap: () async {
                              var phone = numController.text.toString();
                              if (phone.isNotEmpty && phone.length == 10) {
                                enableTap();
                                var rsp = await sendOtpApi(
                                    numController.text.toString());
                                print("rsp['attributes']");
                                if (rsp['attributes']['message'].toString() ==
                                    "Success") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OtpScreen(
                                            mob:
                                                numController.text.toString())),
                                  );
                                }
                                disableTap();
                              } else {
                                null;
                              }
                            },
                            child: isTap == true
                                ? Image.asset(
                                    "assets/images/loading.gif",
                                    height: 40,
                                  )
                                : Container(
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
                                        "Continue",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xffFCFCFC),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                          ),
                        )
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

  Widget number() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "+91",
                style: TextStyle(
                    fontSize: 18, letterSpacing: 1, color: Color(0xff2F455C)),
              ),
            ),
            decoration: BoxDecoration(
                color: Color(0xffE9E9E9),
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffE9E9E9),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  cursorColor: Colors.black,
                  autofocus: true,
                  controller: numController,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1,
                      color: Color(0xff2F455C),
                      fontWeight: FontWeight.w500),
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
