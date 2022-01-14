import 'package:flutter/material.dart';
import 'package:lifescool/Api/certificateVerify.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'CertificateRating.dart';

class CertificatePasscode extends StatefulWidget {
  final cuid;
  final cid;

  CertificatePasscode({this.cuid, this.cid});
  @override
  _CertificatePasscodeState createState() => _CertificatePasscodeState();
}

class _CertificatePasscodeState extends State<CertificatePasscode> {
  TextEditingController otplController = new TextEditingController();
  var passCorrect = true;
  var submit = false;
  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  "Enter your passcode",
                  style: txt16Gry,
                ),
              ),
              otp(),
              // h(16),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 74),
                child: Text(
                    passCorrect == true
                        ? "Your passcode has been sent to your registered mail ID entered in the assessment form"
                        : "Wrong Passcord. \nPlease enter the correct one.",
                    textAlign: TextAlign.center,
                    style: size14_400G),
              ),
              h(20),
              // wrongOTP(),
              h(16),
              GestureDetector(
                onTap: () async {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => CertificateRating(cid: widget.cid.toString(),)),
                  // );

                  if (otplController.text.isEmpty) {
                    showToastSuccess("OTP Empty");

                    return;
                  }
                  setState(() {
                    submit = true;
                  });

                  var rsp = await certificateVerify(
                      widget.cuid.toString(), otplController.text.toString());

                  if (rsp != 0) {
                    setState(() {
                      passCorrect = true;
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CertificateRating(
                                cid: widget.cid.toString(),
                              )),
                    );
                  } else {
                    setState(() {
                      passCorrect = false;
                    });
                  }

                  setState(() {
                    submit = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: darkBlue,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      submit == true ? "Submitting..." : "Submit",
                      style: txt14SemiWhite,
                    ),
                  ),
                ),
              ),
              h(37)
            ],
          ),
        ),
      ),
    );
  }

  Widget wrongOTP() {
    return Text(
      "Wrong Passcord. \nPlease enter the correct one.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xffFF0505),
        fontFamily: 'Nunito',
      ),
    );
  }

  w(double w) {
    return SizedBox(width: w);
  }

  h(double h) {
    return SizedBox(height: h);
  }

  otp() {
    final ss = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ss.width * 0.12),
      child: PinCodeTextField(
        appContext: context,
        autovalidateMode: AutovalidateMode.always,
        backgroundColor: Colors.transparent,
        controller: otplController,
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
          fieldHeight: 42,
          fieldWidth: ss.width * 0.12,
        ),
        cursorColor: Colors.black54,
        cursorHeight: 20,
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
        autoFocus: false,
        autoDisposeControllers: false,
        keyboardType: TextInputType.number,
        onCompleted: (v) async {},
        onChanged: (value) {},
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          return true;
        },
      ),
    );
  }
}
