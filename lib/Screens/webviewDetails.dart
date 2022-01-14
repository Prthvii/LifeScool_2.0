import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
import 'package:lifescool/Screens/JitsiMeet.dart';
import 'package:url_launcher/url_launcher.dart';


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';
import 'package:lifescool/Helper/sharedPref.dart';
class WebPage extends StatefulWidget {
  final String url;
  final String type;

  WebPage({Key key, this.url,this.type}) : super(key: key);

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebPage> {
  String title, url;
  bool isLoading = true;
  final _key = UniqueKey();
  InAppWebViewController _webViewController;

  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "plugintestroom");
  final subjectText = TextEditingController(text: " ");
  final nameText = TextEditingController(text: "Plugin Test User");
  final emailText = TextEditingController(text: "fake@email.com");
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;
  WebViewState(String title, String url) {
    this.title = title;
    this.url = url;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
      Navigator.pop(context);
    } else {
      showToastSuccess("App not found!");
      throw 'Could not launch $url';
    }}
  _joinMeeting() async {
   Navigator.pop(context);
    String serverUrl =
    serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;
    var name = await getSharedPrefrence(NAME);
    var mail = await getSharedPrefrence(MAIL);
    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.inviteEnabled = false;
      featureFlag.iOSRecordingEnabled = false;
      featureFlag.recordingEnabled = false;
      featureFlag.videoShareButtonEnabled = false;
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlag.callIntegrationEnabled = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlag.pipEnabled = false;
      }

      //uncomment to modify video resolution

      //featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;

      // Define meetings options here
      var options = JitsiMeetingOptions()
        ..room = widget.url.toString()
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = name
        ..userEmail = mail
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted

        ..featureFlag = featureFlag;

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          print("disconnecteddddd");

          debugPrint("${options.room} terminated with message: $message");
        }, onPictureInPictureWillEnter: ({message}) {
          debugPrint("${options.room} entered PIP mode with message: $message");
        }, onPictureInPictureTerminated: ({message}) {
          debugPrint("${options.room} exited PIP mode with message: $message");
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }
  @override
  void initState() {
    super.initState();



    if(widget.type=="Zoom"){
      _launchURL(widget.url.toString());

    }
    if(widget.type=="JITSI"){
      _joinMeeting();

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      ),
      body: Stack(
        children: <Widget>[
          InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(
                     widget.url.toString())),
              //  initialUrlRequest: "https://appr.tc/r/158489234",
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  mediaPlaybackRequiresUserGesture: false,
                  // debuggingEnabled: true,
                ),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                _webViewController = controller;
              },
              onLoadStop: (controller, url) {
                setState(() {
                  isLoading = false;
                });
              },
              androidOnPermissionRequest: (InAppWebViewController controller,
                  String origin, List<String> resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              }),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}
