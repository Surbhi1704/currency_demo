import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';



class SharedPref {
  static String historyData = "HISTORYDATA";

   static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static saveHistoryList(encodedData) async {
    if (_prefs == null) await init();
    await _prefs!.setString(historyData, jsonEncode(encodedData));
  }

 static  getHistoryList()  {
  
    return _prefs!.getString(historyData)??'[]';
  }
}
