import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lifescool/Api/genrateCertificate.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class CertificateRating extends StatefulWidget {
  final cid;

  CertificateRating({this.cid});

  @override
  _CertificateRatingState createState() => _CertificateRatingState();
}

class _CertificateRatingState extends State<CertificateRating> {
  TextEditingController nameController = new TextEditingController();
  ReceivePort _port = ReceivePort();
  var isLoading = false;

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  ///downloadfile--
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void _download(String url) async {
    final status = await Permission.storage.request();
    print("url");
    print(url);
    if (status.isGranted) {
      showToastSuccess("Downloading...");
      final id = await FlutterDownloader.enqueue(
        url: url,
        savedDir: '/storage/emulated/0/Download/',
        showNotification: true,
        openFileFromNotification: true,
      );
      print("downdload");
      print(id);
      showToastSuccess("Downloaded!");
      Navigator.pop(context);
    } else {
      print('Permission Denied');
    }
  }

  ///downloadfile--
  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: ss.height * 0.05),
                // SvgPicture.asset(
                //   "assets/svg/RatingFace.svg",
                //   width: 118,
                //   // height: ,
                // ),
                // SizedBox(height: ss.height * 0.08),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 94),
                //   child: Text(
                //     "How would you rate your learning experience?",
                //     textAlign: TextAlign.center,
                //     style: txt16Gry,
                //   ),
                // ),
                // SizedBox(height: ss.height * 0.02),
                // ratingBar(),
                // SizedBox(height: ss.height * 0.05),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 92),
                //   child: Text(
                //     "Please share your feedbacks and recommendations here",
                //     textAlign: TextAlign.center,
                //     style: txt16Gry,
                //   ),
                // ),
                // SizedBox(height: ss.height * 0.012),
                // suggestionField(),
                SizedBox(height: ss.height * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 96),
                  child: Text(
                    "Please enter your name as you want in your certificate",
                    textAlign: TextAlign.center,
                    style: txt16Gry,
                  ),
                ),
                SizedBox(height: ss.height * 0.015),
                nameField(),
                SizedBox(height: ss.height * 0.04),
                isLoading == true
                    ? Container(
                        child: Center(
                        child: Image.asset(
                          "assets/images/loading.gif",
                          height: 40,
                        ),
                      ))
                    : button(),
                SizedBox(height: ss.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  nameField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: greyClr,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          controller: nameController,
          cursorColor: Colors.black,
          maxLines: 1,
          keyboardType: TextInputType.name,
          autofocus: false,
          textInputAction: TextInputAction.done,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          decoration: new InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 14),
            hintText: "Write here",
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  suggestionField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: greyClr,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextFormField(
          // controller: bodyController,
          cursorColor: Colors.black,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          autofocus: false,
          maxLength: 200,
          textInputAction: TextInputAction.done,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          decoration: new InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 14),
            hintText: "Write here",
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  ratingBar() {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      glow: true,
      unratedColor: greyClr,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        CupertinoIcons.star_fill,
        color: Color(0xff2FB134),
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }

  button() {
    return GestureDetector(
      onTap: () async {
        if (nameController.text.isEmpty) {
          showToastSuccess("Please enter the name !");
          return;
        }

        setState(() {
          isLoading = true;
        });
        var rsp = await genrateCertificate(
            widget.cid.toString(), nameController.text.toString());
        if (rsp != 0) {
          _download(rsp);
        }
        setState(() {
          isLoading = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), gradient: gradientslope),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "Download Certificate",
            style: txt14SemiWhite,
          ),
        ),
      ),
    );
  }
}
