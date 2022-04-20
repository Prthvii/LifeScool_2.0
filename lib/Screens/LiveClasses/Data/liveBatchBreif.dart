import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lifescool/Const/network.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';

Future liveBatchBreifApi(batchId) async {


  var id = await getSharedPrefrence(ID);
  var token = await getSharedPrefrence(TOKEN);

  final json = {
    'request_header':getBatchBrief,
    'secKey':secKey,
    'studentId':id.toString(),
    'apiToken':token.toString(),
    'batchId':batchId.toString(),




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
    convertDataToJson = 0;
    showToastSuccess(response.body.toString());
    print("courseeeeeessssssssssss");

    print(response.body);
  }
  return convertDataToJson;
}
