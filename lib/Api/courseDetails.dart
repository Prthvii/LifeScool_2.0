import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lifescool/Const/network.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';

Future courseDetails(cid) async {


  var id = await getSharedPrefrence(ID);
  var token = await getSharedPrefrence(TOKEN);
     print("cid");
     print(cid);
     print(id);
     print(token);
  final json = {
    'request_header':getChapDetails,
    'secKey':secKey,
    'studentId':id.toString(),
    'apiToken':token.toString(),
    'courseId':cid.toString(),



  };
  final response = await http.post(Uri.parse(baseUrl,),

      body: json,

  );
  var convertDataToJson;

  if (response.statusCode == 200) {
    print("courseeeeee");

    print(response.body);
    convertDataToJson = jsonDecode(response.body.toString());

    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    convertDataToJson = jsonDecode(response.body.toString());
    var msg =jsonDecode(response.body.toString());
    showToastSuccess(msg['attributes']['response']);
    print("response.body");
    print(response.body);
  }
  return convertDataToJson;
}
