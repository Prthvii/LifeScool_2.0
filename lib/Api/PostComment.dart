import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lifescool/Const/network.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';

Future postCommentApi(cid,title,bdy) async {


  var id = await getSharedPrefrence(ID);
  var token = await getSharedPrefrence(TOKEN);
     print('dataaaaaaaaaaa');
     print('request_header'+postComments);
     print('secKey ' +secKey);
     print('studentId'+id);
     print('apiToken'+token);
     print('courseId'+cid);
     print('postTitle'+title);
     print('postBody'+bdy);

  final json = {
    'request_header':postComments,
    'secKey':secKey,
    'studentId':id.toString(),
    'apiToken':token.toString(),
    'courseId':cid.toString(),
    'postTitle':title.toString(),
    'postBody':bdy.toString(),
    // 'courseId':"1",



  };
  final response = await http.post(Uri.parse(baseUrl,),

      body: json,

  );
  var convertDataToJson;

  if (response.statusCode == 200) {

    print("response.body");
    print(response.body);
    convertDataToJson = jsonDecode(response.body.toString());

    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    convertDataToJson = 0;
    var msg =jsonDecode(response.body.toString());
    showToastSuccess(msg['attributes']['response']);
    print("response.body");
    print(response.body);
  }
  return convertDataToJson;
}
