import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lifescool/Const/network.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';

Future modulesDataListApi(moduleId) async {


  var id = await getSharedPrefrence(ID);
  var token = await getSharedPrefrence(TOKEN);
  print("idddddddd");
  print(moduleId);

  final json = {
    'request_header':moduleDataList,
    'secKey':secKey,
    'studentId':id.toString(),
    'apiToken':token.toString(),
   'moduleId':moduleId,

    // 'studentId':"LF44".toString(),
    // 'apiToken':"b1824b5a80ab91cf40766a8ab4d01e53".toString(),
    // 'moduleId':"3",




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
