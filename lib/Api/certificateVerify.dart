import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lifescool/Const/network.dart';
import 'package:lifescool/Helper/sharedPref.dart';

Future certificateVerify(courseUid, passcode) async {
  var id = await getSharedPrefrence(ID);
  var token = await getSharedPrefrence(TOKEN);
  print("cid");

  print(courseUid);
  print(id);
  print(token);
  final json = {
    'request_header': certificateValidate,
    'secKey': secKey,
    'studentId': id.toString(),
    'apiToken': token.toString(),
    'courseUid': courseUid.toString(),
    'passcode': passcode.toString(),
  };
  final response = await http.post(
    Uri.parse(
      baseUrl,
    ),
    body: json,
  );
  var convertDataToJson;

  if (response.statusCode == 200) {
    //  convertDataToJson = jsonDecode(response.body.toString());

    // If the server did return a 200 OK response,
    // then parse the JSON.

    print(response.body.toString());

    var snd = jsonDecode(response.body.toString());
    print(snd['attributes']['status']);
    if (snd['attributes']['status'].toString() == "200") {
      convertDataToJson = jsonDecode(response.body.toString());
    } else {
      convertDataToJson = 0;
    }
  } else {
    convertDataToJson = 0;
  }
  return convertDataToJson;
}
