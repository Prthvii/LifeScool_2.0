import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifescool/Api/sendOtp.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Const/TextConstants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Api/checkUser.dart';
import '../Api/verifyOtp.dart';
import '../Helper/sharedPref.dart';
import 'EnterDetails.dart';
import 'HomePage.dart';

class OtpScreen extends StatefulWidget {
  final mob;
  final code;
  OtpScreen({this.mob,this.code});

  // const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = new TextEditingController();
  bool isTap = false;
  bool otpFail = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
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
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: (Colors.black12),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                    // border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xffE94822)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 18,
                                  )),
                              GestureDetector(
                                onTap: () async {
                                  var rsp =
                                      await sendOtpApi(widget.mob.toString(),widget.code.toString());
                                  print("rsp['attributes']");
                                  if (rsp['attributes']['message'].toString() ==
                                      "Success") {
                                    showToastSuccess("OTP Resent!");
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Text(
                                    resend,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                ),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Enter OTP sent to ${widget.code} ${widget.mob.toString()}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          otp()
                        ],
                      ),
                      Positioned(
                        bottom: 40,
                        child: isTap == true
                            ? Image.asset(
                                "assets/images/loading.gif",
                                height: 20,
                              )
                            : Text(
                                otpFail == false ? "" : "Invalid OTP",
                                style: TextStyle(
                                    color: Color(0xffFFF7AF),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
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
    );
  }

  otp() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: PinCodeTextField(
        appContext: context,
        autovalidateMode: AutovalidateMode.always,
        backgroundColor: Colors.transparent,
        controller: otpController,
        length: 6,
        enablePinAutofill: true,
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        textStyle: TextStyle(color: Color(0xff2F455C), fontSize: 18),
        pinTheme: PinTheme(
          inactiveFillColor: Color(0xffE9E9E9),
          activeFillColor: Color(0xffE9E9E9),
          selectedFillColor: Color(0xffE9E9E9),
          borderWidth: 0.01,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          fieldHeight: 45,
          fieldWidth: 40,
        ),
        cursorColor: Colors.black54,
        cursorHeight: 20,
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
        autoFocus: true,
        autoDisposeControllers: false,
        keyboardType: TextInputType.number,
        onCompleted: (v) async {
          setState(() {
            isTap = true;
            otpFail = false;
          });
          var rsp =
              await verifyOtpApi(widget.mob.toString(), otpController.text);

          print("rsp['attributes']");

          // Map valueMap = jsonDecode(rsp.toString());
          print(rsp);

          if (rsp['attributes']['message'].toString() == "Success") {
            var rsp = await checkUserApi(widget.mob.toString());

            if (rsp['attributes']['response'].toString() ==
                "Registered Customer") {
              var id = await setSharedPrefrence(
                  ID, rsp['attributes']['studentInfo']['studentId']);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            } else {
              // var id = await setSharedPrefrence(
              //     ID,
              //     rsp['attributes']['studentInfo']
              //     ['studentId']);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EnterDetails(
                          mob: widget.mob.toString(),
                        )),
              );
            }
          } else if (rsp['attributes']['response'].toString() ==
              "Invalid OTP") {
            setState(() {
              otpFail = true;
            });
          }

          setState(() {
            isTap = false;
          });
        },
        onChanged: (value) {},
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          return true;
        },
      ),
    );
  }
}
