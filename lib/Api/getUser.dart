import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lifescool/Const/network.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';

Future getUserApi() async {


  var id = await getSharedPrefrence(ID);
   print(id);
  final json = {
    'request_header':getUser,
    'secKey':secKey,
    'studentId':id.toString(),



  };
  final response = await http.post(Uri.parse(baseUrl,),

      body: json

  );
  var convertDataToJson;

  if (response.statusCode == 200) {
    convertDataToJson = jsonDecode(response.body.toString());
    print("Profileeeeeeeeeeeeeeee");

    print(response.body);
    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    convertDataToJson = 0;
    showToastSuccess("Something went wrong, Check internet connection!");
  }
  return convertDataToJson;
}
