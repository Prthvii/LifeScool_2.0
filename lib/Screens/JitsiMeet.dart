// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';
// import 'package:lifescool/Helper/sharedPref.dart';
// import 'package:lifescool/Screens/testt.dart';
// import 'package:lifescool/Screens/webviewDetails.dart';
//
//
//
// class Meeting extends StatefulWidget {
//
//   final id;
//
//   Meeting({this.id});
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<Meeting> {
//   final serverText = TextEditingController();
//   final roomText = TextEditingController(text: "plugintestroom");
//   final subjectText = TextEditingController(text: " ");
//   final nameText = TextEditingController(text: "Plugin Test User");
//   final emailText = TextEditingController(text: "fake@email.com");
//   var isAudioOnly = true;
//   var isAudioMuted = true;
//   var isVideoMuted = true;
//
//   @override
//   void initState() {
//     super.initState();
//     JitsiMeet.addListener(JitsiMeetingListener(
//         onConferenceWillJoin: _onConferenceWillJoin,
//         onConferenceJoined: _onConferenceJoined,
//         onConferenceTerminated: _onConferenceTerminated,
//         onPictureInPictureWillEnter: _onPictureInPictureWillEnter,
//         onPictureInPictureTerminated: _onPictureInPictureTerminated,
//         onError: _onError));
//
//     this. _joinMeeting();
//
//     // Navigator.push(
//     //     context, MaterialPageRoute(builder: (context) => SomePage()));
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   //  JitsiMeet.removeAllListeners();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//     //  debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         // appBar: AppBar(
//         //   title: const Text('Plugin example app'),
//         // ),
//         body: Container(
//           child: Center(
//             child: Image.asset(
//               "assets/images/loading.gif",
//               height: 40,
//             ),
//           ),
//         )
//
//
//         // Container(
//         //   padding: const EdgeInsets.symmetric(
//         //     horizontal: 16.0,
//         //   ),
//         //   child: SingleChildScrollView(
//         //     child: Column(
//         //       children: <Widget>[
//         //         SizedBox(
//         //           height: 24.0,
//         //         ),
//         //         TextField(
//         //           controller: serverText,
//         //           decoration: InputDecoration(
//         //               border: OutlineInputBorder(),
//         //               labelText: "Server URL",
//         //               hintText: "Hint: Leave empty for meet.jitsi.si"),
//         //         ),
//         //         SizedBox(
//         //           height: 16.0,
//         //         ),
//         //         TextField(
//         //           controller: roomText,
//         //           decoration: InputDecoration(
//         //             border: OutlineInputBorder(),
//         //             labelText: "Room",
//         //           ),
//         //         ),
//         //         SizedBox(
//         //           height: 16.0,
//         //         ),
//         //         TextField(
//         //           controller: subjectText,
//         //           decoration: InputDecoration(
//         //             border: OutlineInputBorder(),
//         //             labelText: "Subject",
//         //           ),
//         //         ),
//         //         SizedBox(
//         //           height: 16.0,
//         //         ),
//         //         TextField(
//         //           controller: nameText,
//         //           decoration: InputDecoration(
//         //             border: OutlineInputBorder(),
//         //             labelText: "Display Name",
//         //           ),
//         //         ),
//         //         SizedBox(
//         //           height: 16.0,
//         //         ),
//         //         TextField(
//         //           controller: emailText,
//         //           decoration: InputDecoration(
//         //             border: OutlineInputBorder(),
//         //             labelText: "Email",
//         //           ),
//         //         ),
//         //         SizedBox(
//         //           height: 16.0,
//         //         ),
//         //         SizedBox(
//         //           height: 16.0,
//         //         ),
//         //         CheckboxListTile(
//         //           title: Text("Audio Only"),
//         //           value: isAudioOnly,
//         //           onChanged: _onAudioOnlyChanged,
//         //         ),
//         //         SizedBox(
//         //           height: 16.0,
//         //         ),
//         //         CheckboxListTile(
//         //           title: Text("Audio Muted"),
//         //           value: isAudioMuted,
//         //           onChanged: _onAudioMutedChanged,
//         //         ),
//         //         SizedBox(
//         //           height: 16.0,
//         //         ),
//         //         CheckboxListTile(
//         //           title: Text("Video Muted"),
//         //           value: isVideoMuted,
//         //           onChanged: _onVideoMutedChanged,
//         //         ),
//         //         Divider(
//         //           height: 48.0,
//         //           thickness: 2.0,
//         //         ),
//         //         SizedBox(
//         //           height: 64.0,
//         //           width: double.maxFinite,
//         //           child: RaisedButton(
//         //             onPressed: () {
//         //               _joinMeeting();
//         //             },
//         //             child: Text(
//         //               "Join Meeting",
//         //               style: TextStyle(color: Colors.white),
//         //             ),
//         //             color: Colors.blue,
//         //           ),
//         //         ),
//         //         SizedBox(
//         //           height: 48.0,
//         //         ),
//         //       ],
//         //     ),
//         //   ),
//         // ),
//       ),
//     );
//   }
//
//
//   _delayDispose() {
//     Future.delayed(const Duration(milliseconds: 500), () {
//
//       Navigator.of(context).pop(context);
//     }
//     );
//   }
//
//
//   _onAudioOnlyChanged(bool value) {
//     setState(() {
//       isAudioOnly = value;
//     });
//   }
//
//   _onAudioMutedChanged(bool value) {
//     setState(() {
//       isAudioMuted = value;
//     });
//   }
//
//   _onVideoMutedChanged(bool value) {
//     setState(() {
//       isVideoMuted = value;
//     });
//   }
//
//   _joinMeeting() async {
//     String serverUrl =
//     serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;
//     var name = await getSharedPrefrence(NAME);
//     var mail = await getSharedPrefrence(MAIL);
//     try {
//       // Enable or disable any feature flag here
//       // If feature flag are not provided, default values will be used
//       // Full list of feature flags (and defaults) available in the README
//       FeatureFlag featureFlag = FeatureFlag();
//       featureFlag.welcomePageEnabled = false;
//       // Here is an example, disabling features for each platform
//       if (Platform.isAndroid) {
//         // Disable ConnectionService usage on Android to avoid issues (see README)
//         featureFlag.callIntegrationEnabled = false;
//       } else if (Platform.isIOS) {
//         // Disable PIP on iOS as it looks weird
//         featureFlag.pipEnabled = false;
//       }
//
//       //uncomment to modify video resolution
//       //featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;
//
//       // Define meetings options here
//
//      // FeatureFlag featureFlag = FeatureFlag();
//      //  featureFlag.welcomePageEnabled = false;
//      //  featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;
//       var options = JitsiMeetingOptions()
//         ..room = widget.id.toString()
//         ..serverURL = serverUrl
//         ..subject = subjectText.text
//         ..userDisplayName = name
//         ..userEmail = mail
//         ..audioOnly = isAudioOnly
//         ..audioMuted = isAudioMuted
//         ..videoMuted = isVideoMuted
//         ..featureFlag = featureFlag;
//
//       debugPrint("JitsiMeetingOptions: $options");
//       await JitsiMeet.joinMeeting(
//         options,
//         listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
//           debugPrint("${options.room} will join with message: $message");
//         }, onConferenceJoined: ({message}) {
//           debugPrint("${options.room} joined with message: $message");
//         }, onConferenceTerminated: ({message}) {
//           print("disconnecteddddd");
//           _delayDispose();
//           debugPrint("${options.room} terminated with message: $message");
//         }, onPictureInPictureWillEnter: ({message}) {
//           debugPrint("${options.room} entered PIP mode with message: $message");
//         }, onPictureInPictureTerminated: ({message}) {
//           debugPrint("${options.room} exited PIP mode with message: $message");
//         }),
//         // by default, plugin default constraints are used
//         //roomNameConstraints: new Map(), // to disable all constraints
//         //roomNameConstraints: customContraints, // to use your own constraint(s)
//       );
//     } catch (error) {
//       debugPrint("error: $error");
//     }
//
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => SomePage()));
//   }
//
//   static final Map<RoomNameConstraintType, RoomNameConstraint>
//   customContraints = {
//     RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
//       return value.trim().length <= 50;
//     }, "Maximum room name length should be 30."),
//     RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
//       return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
//           .hasMatch(value) ==
//           false;
//     }, "Currencies characters aren't allowed in room names."),
//   };
//
//   void _onConferenceWillJoin({message}) {
//     debugPrint("_onConferenceWillJoin broadcasted with message: $message");
//   }
//
//   void _onConferenceJoined({message}) {
//     debugPrint("_onConferenceJoined broadcasted with message: $message");
//   }
//
//   void _onConferenceTerminated({message}) {
//     debugPrint("_onConferenceTerminated broadcasted with message: $message");
//   }
//
//   void _onPictureInPictureWillEnter({message}) {
//     debugPrint("_onPictureInPictureWillEnter broadcasted with message: $message");
//   }
//
//   void _onPictureInPictureTerminated({message}) {
//     debugPrint("_onPictureInPictureTerminated broadcasted with message: $message");
//   }
//
//   _onError(error) {
//     debugPrint("_onError broadcasted: $error");
//   }
// }





///
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';



class Meeting extends StatefulWidget {
  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "plugintestroom");
  final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  final nameText = TextEditingController(text: "Plugin Test User");
  final emailText = TextEditingController(text: "fake@email.com");
  final iosAppBarRGBAColor =
  TextEditingController(text: "#0080FF80"); //transparent blue
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(
        JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    //JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: kIsWeb
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.30,
                child: meetConfig(),
              ),
              Container(
                  width: width * 0.60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        color: Colors.white54,
                        child: SizedBox(
                          width: width * 0.60 * 0.70,
                          height: width * 0.60 * 0.70,
                          // child: JitsiMeetConferencing(
                          //   extraJS: [
                          //     // extraJs setup example
                          //     '<script>function echo(){console.log("echo!!!")};</script>',
                          //     '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
                          //   ],
                          // ),
                        )),
                  ))
            ],
          )
              : meetConfig(),
        ),
      ),
    );
  }

  Widget meetConfig() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 16.0,
          ),
          TextField(
            controller: serverText,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Server URL",
                hintText: "Hint: Leave empty for meet.jitsi.si"),
          ),
          SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: roomText,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Room",
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: subjectText,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Subject",
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: nameText,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Display Name",
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: emailText,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Email",
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: iosAppBarRGBAColor,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "AppBar Color(IOS only)",
                hintText: "Hint: This HAS to be in HEX RGBA format"),
          ),
          SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: Text("Audio Only"),
            value: isAudioOnly,
            onChanged: _onAudioOnlyChanged,
          ),
          SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: Text("Audio Muted"),
            value: isAudioMuted,
            onChanged: _onAudioMutedChanged,
          ),
          SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: Text("Video Muted"),
            value: isVideoMuted,
            onChanged: _onVideoMutedChanged,
          ),
          Divider(
            height: 48.0,
            thickness: 2.0,
          ),
          SizedBox(
            height: 64.0,
            width: double.maxFinite,
            child: RaisedButton(
              onPressed: () {
                _joinMeeting();
              },
              child: Text(
                "Join Meeting",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            ),
          ),
          SizedBox(
            height: 48.0,
          ),
        ],
      ),
    );
  }

  _onAudioOnlyChanged(bool value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String serverUrl =
    serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    // Map<FeatureFlagEnum, bool> featureFlags = {
    //   FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    // };
    // if (!kIsWeb) {
    //   // Here is an example, disabling features for each platform
    //   if (Platform.isAndroid) {
    //     // Disable ConnectionService usage on Android to avoid issues (see README)
    //     featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
    //   } else if (Platform.isIOS) {
    //     // Disable PIP on iOS as it looks weird
    //     featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
    //   }
    // }
    // Define meetings options here
    var options = JitsiMeetingOptions()
      ..room = roomText.text
      ..serverURL = serverUrl
      ..subject = subjectText.text
      ..userDisplayName = nameText.text
      ..userEmail = emailText.text
     // ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted;
     // ..featureFlags.addAll(featureFlags)
     //  ..webOptions = {
     //    "roomName": roomText.text,
     //    "width": "100%",
     //    "height": "100%",
     //    "enableWelcomePage": false,
     //    "chromeExtensionBanner": null,
     //    "userInfo": {"displayName": nameText.text}
     //  };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: ({message}) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: ({message}) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: ({message}) {
            debugPrint("${options.room} terminated with message: $message");
          },
          // genericListeners: [
          //   JitsiGenericListener(
          //       eventName: 'readyToClose',
          //       callback: (dynamic message) {
          //         debugPrint("readyToClose callback");
          //       }),
          // ]

      ),
    );
  }

  static final Map<RoomNameConstraintType, RoomNameConstraint>
  customContraints = {
    RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
      return value.trim().length <= 50;
    }, "Maximum room name length should be 30."),
    RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
          .hasMatch(value) ==
          false;
    }, "Currencies characters aren't allowed in room names."),
  };

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}