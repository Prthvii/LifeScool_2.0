import 'package:http/http.dart' as http;
import 'package:lifescool/Helper/sharedPref.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';

Future genrateCertificate(cid, name) async {
  print(cid);
  print(name);
  var id = await getSharedPrefrence(ID);
  final response = await http.get(Uri.parse(
    "https://lifescool.app/lp/certls/tsa_center_lscool.php?student_id=" +
        id +
        "&course_id=" +
        cid +
        "&certName=" +
        name,
  ));
  var convertDataToJson;

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("responseee");
    print(response.body);
    convertDataToJson = response.body;
  } else {
    convertDataToJson = 0;
    print(response.body);
    showToastSuccess("Failed to apply scrach card.");
  }
  return convertDataToJson;
}
