import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lifescool/Const/network.dart';
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';

Future myCourseApi() async {


  var id = await getSharedPrefrence(ID);
  var token = await getSharedPrefrence(TOKEN);

  final json = {
    'request_header':myLearningsDiscussions,
    'secKey':secKey,
    'studentId':id.toString(),
    'apiToken':token.toString(),



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
    print("courseeeeee");
    var msg = jsonDecode(response.body.toString());
    print(response.body);
    showToastSuccess(msg['attributes']['response'].toString());
  }
  return convertDataToJson;
}
