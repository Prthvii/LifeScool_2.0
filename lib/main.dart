import 'dart:io';

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
  @override
  void initState() {
    HttpOverrides.global = new MyHttpOverrides();
    super.initState();
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
    );
  }
}
