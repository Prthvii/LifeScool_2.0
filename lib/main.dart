import 'dart:io';
import 'package:lifescool/Screens/JitsiMeet.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Screens/SplashScreen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


// void initPlatformStateNotification() async {
//   print(
//       "---------------------------------------------------------------------------");
//   OneSignal.shared.setAppId(
//     'd9bcccbd-9ecf-4df5-b1e6-4cefee79bff9',
//   );
//
//   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
//   bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();
//   final status = await OneSignal.shared.getDeviceState();
//   final String osUserID = status?.userId;
//   print("`````````````````````````osUserID`````````````````````````");
//   print(osUserID);
//   print("``````````````````````````osUserID``````````````````````````");
//
//
//
//
//
// }
void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Permission.camera.request();
  await Permission.microphone.request();
  runApp(MyApp());
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _enableConsentButton = false;
  String externalUserId = "";
  String _homeScreenText = "Waiting for token...";
  String _debugLabelString;
  @override
  void initState() {
    HttpOverrides.global = new MyHttpOverrides();
    initPlatformState();

    super.initState();
  }

  void initPlatformState() async {
    print(
        "---------------------------------------------------------------------------");
    OneSignal.shared.setAppId(
      'd9bcccbd-9ecf-4df5-b1e6-4cefee79bff9',
    );
    // OneSignal.shared.setAppId(
    //   'b8d00834-62e9-47c2-9d85-f35491c4cda6',
    // );

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();
    final status = await OneSignal.shared.getDeviceState();
    final String osUserID = status?.userId;
    print("`````````````````````````osUserID`````````````````````````");
    print(osUserID);
    print("``````````````````````````osUserID``````````````````````````");



    setState(() {
      _homeScreenText = "Push Messaging token: $osUserID";
    });
    print(_homeScreenText);

    this.setState(() {
      _enableConsentButton = requiresConsent;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lifescool',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        dividerColor: Colors.transparent,
        canvasColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        fontFamily: 'Nunito',
      ),
      debugShowCheckedModeBanner: false,
      // home: CourseIntro(),
    home: SplashScreen(),

    //  home: Meeting(),

    );
  }
}


