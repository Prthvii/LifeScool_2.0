import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lifescool/Const/network.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';

Future modulesListBatchApi(batchId) async {


  var id = await getSharedPrefrence(ID);
  var token = await getSharedPrefrence(TOKEN);
  print("pattyyyyy");
   print(id);
   print(token);
  print(batchId);
  print("pattyyyyy");

  final json = {
    'request_header':modulesListBatch,
    'secKey':secKey,
    'studentId':id.toString(),
    'apiToken':token.toString(),
    'batchUid':batchId,
    // 'studentId':"LF44".toString(),
    // 'apiToken':"b1824b5a80ab91cf40766a8ab4d01e53".toString(),
    // 'batchUid':"11dc9f88-067d-4f7d-9557-a7fda8beb160",




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
