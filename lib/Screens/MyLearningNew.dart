// import 'package:flutter/material.dart';
// import 'package:lifescool/Const/Constants.dart';
// import 'package:lifescool/Screens/Settings.dart';
//
// class MyLearningNew extends StatefulWidget {
//   const MyLearningNew({Key key}) : super(key: key);
//
//   @override
//   _MyLearningNewState createState() => _MyLearningNewState();
// }
//
// class _MyLearningNewState extends State<MyLearningNew> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: Column(
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   backgroundColor: greyBG,
//                   radius: 24,
//                   child: Icon(
//                     Icons.person,
//                     color: Color(0xff848484),
//                     size: 20,
//                   ),
//                 ),
//                 w(16),
//                 Text("Rose MJ", style: size14_700)
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           Icon(Icons.share, color: lifescoolBlue, size: 20),
//           Padding(
//             padding:
//                 const EdgeInsets.only(right: 16, top: 10, bottom: 10, left: 16),
//             child: InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Settings()),
//                 );
//               },
//               child: Container(
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                     color: themeOrange,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: Text("Settings", style: size14_700W),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
