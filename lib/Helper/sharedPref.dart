import 'package:shared_preferences/shared_preferences.dart';

///sahrepref const
final ID = "LS-ID";
final TOKEN = "LS-TOKEN";

final NUM = "LS-NUM";
final MAIL = "LS-MAIL";
final NAME = "LS-NAME";
final REELS = "LS-CHACHEREELS";
final LASTADEED = "LS-LASTADDEDREELPG";
final TOTALREELS = "LS-TOTALREELS";

Future setSharedPrefrence(key, data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, data);
}

Future getSharedPrefrence(key) async {
  var prefs = await SharedPreferences.getInstance();
  var value = prefs.getString(key);

  return value;
}


Future clearSharedPrefrence() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(TOKEN);
  prefs.remove(ID);

}