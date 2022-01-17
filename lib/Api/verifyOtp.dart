import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lifescool/Const/network.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';

Future verifyOtpApi(num, otp) async {
  final json = {
    'request_header': verifyOtp,
    'secKey': secKey,
    'mobileNumber': num.toString(),
    'countryCode': countryCode,
    'otp': otp.toString(),
  };
  final response = await http.post(
    Uri.parse(
      baseUrl,
    ),
    body: json,
  );
  var convertDataToJson;

  if (response.statusCode == 200) {
    convertDataToJson = jsonDecode(response.body.toString());

    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    convertDataToJson = 0;
    showToastSuccess("Something went wrong, Check internet connection!");
  }
  return convertDataToJson;
}
