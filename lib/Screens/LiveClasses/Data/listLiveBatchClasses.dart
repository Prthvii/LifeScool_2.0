import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lifescool/Const/network.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';

Future listLiveBatchClassesApi(categoryId,searchString) async {


  var id = await getSharedPrefrence(ID);
  var token = await getSharedPrefrence(TOKEN);
  print("idddddddd");
  print(id);
  print(token);
  final json = {
    'request_header':getInAllBatches,
    'secKey':secKey,
    'studentId':id.toString(),
    'apiToken':token.toString(),
    'categoryId':categoryId,
    'searchString':searchString,



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
    showToastSuccess("Something went wrong, Check internet connection!");
    print("courseeeeeessssssssssss");

    print(response.body);
  }
  return convertDataToJson;
}
