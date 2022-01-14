import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifescool/Api/subCourse.dart';
import 'package:lifescool/Api/subWorkshop.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Screens/CourseIntro.dart';
import 'package:lifescool/Screens/PlayerScreen.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class paymentPage extends StatefulWidget {
  final amount;
  final id;
  final type;
  final paid;

  paymentPage({this.amount, this.id, this.type,this.paid});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<paymentPage> {
  Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
            child: Center(
          child: Image.asset(
            "assets/images/loading.gif",
            height: 40,
          ),
        )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    if(widget.paid=="FREE"){
      _handlePaymentSuccess(null);
    }else{
      _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
      openCheckout();
    }

  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {

    var num = await getSharedPrefrence(NUM);
    var mail = await getSharedPrefrence(MAIL);
    print("nummm");
    print(num);
    var options = {
      'key': 'rzp_live_RvZaDCaAp6j9fq',
      'amount': int.parse(widget.amount.toString()) * 100,
      'name': 'Lifescool',
      'image': 'https://www.lifescool.app/lf-logo.jpeg',
      'description': 'A School for kids to grandparents',
      'prefill': {'contact': num.toString(), 'email': mail.toString()},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    if (widget.type == "WRKSHOP") {
      var rsp =
          await subWorkshop(widget.id.toString(), widget.amount.toString());
      if (rsp != 0) {

       // SuccessPop();
        // Fluttertoast.showToast(
        //     msg: "SUCCESS: " + response.paymentId,
        //     toastLength: Toast.LENGTH_SHORT);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CourseIntro(
                    id: widget.id,
                  )),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Failure occurred!", toastLength: Toast.LENGTH_SHORT);
        Navigator.pop(context);
      }
    } else {
      var rsp = await subCourse(widget.id);
      if (rsp != 0) {
        // Fluttertoast.showToast(
        //     msg: "SUCCESS: " + response.paymentId,
        //     toastLength: Toast.LENGTH_SHORT);
        SuccessPop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PlayerScreen(
                    id: widget.id,
                  )),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Failure occurred!", toastLength: Toast.LENGTH_SHORT);
    Navigator.pop(context);

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => PlayerScreen(
        //         id: widget.id,
        //       )),
        // );
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Something went wrong , try again!",
        toastLength: Toast.LENGTH_SHORT);
   Navigator.pop(context);

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => PlayerScreen(
    //         id: widget.id,
    //       )),
    // );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  Navigator.pop(context);

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => PlayerScreen(
    //         id: widget.id,
    //       )),
    // );
  }

  void SuccessPop() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(12)),
        elevation: 10,
        // title: Text(
        //   'Payment Successful',
        //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        // ),
        content: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Stack(
                children: [
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    top: 5,
                    right: 0,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset('assets/images/success.json',
                            height: 80, width: 80, repeat: false),
                        Text(
                          'Your payment has been successful!',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'You are enrolled for ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          " Course name",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Happy Learning!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
