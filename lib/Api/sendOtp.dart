import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lifescool/Const/network.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';

Future sendOtpApi(num,code) async {


final json = {
  'request_header':sendOtp,
  'secKey':secKey,
  'mobileNumber':num.toString(),
  'countryCode':code,


};

  final response = await http.post(Uri.parse(baseUrl,),

      body: json);
  var convertDataToJson;

  if (response.statusCode == 200) {
    print("response.body");


    convertDataToJson = jsonDecode(response.body.toString());
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(convertDataToJson);

  } else {
    convertDataToJson = 0;
    showToastSuccess("Something went wrong, Check internet connection!");
  }
  return convertDataToJson;
}
