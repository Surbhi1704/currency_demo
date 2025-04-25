import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_demo/models/get_codes.dart';
import 'package:flutter_application_demo/network/api_repo.dart';
import 'package:flutter_application_demo/utils/prefs.dart';
import 'package:get/get.dart';

class CurrentConverterController extends GetxController {
  Rx<String> baseValue = 'USD'.obs;
  Rx<String> targetValue = 'INR'.obs;
  Rx<int> amount = 1.obs;
  Rx<double> result = 0.0.obs;
  RxList<dynamic> tempList = [].obs;
  RxList<dynamic> historyList = [].obs;
  RxList codes = [].obs;
  RxList<String> codeList = <String>[].obs;
  RxBool isDark = false.obs;

  checkDarkModeEnable() {
    isDark.value = Get.isDarkMode;
    update();
  }

  getCode() async {
    var response = await ApiRepo.getSupportedCode();
    var responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      codes.clear();
      codeList.clear();

      codes.add(GetCodes.fromJson(responseData));

      for (var code in codes[0].supportedCodes) {
        codeList.add(code.countryCode);
      }
    } else if (responseData['error-type'] != null) {
      Get.snackbar('Error', responseData['error-type']);
    } else {
      Get.snackbar('Error', 'Unknow Server Error');
    }
  }

  getConvert(base, target, amount) async {
    var response = await ApiRepo.getRates(base, target);
    var responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      result.value = (int.parse(amount) * responseData['conversion_rate']).toDouble();

      tempList.add('$amount $base => ${result.value.toString()} $target');

      
      if (tempList.length > 5) {
        tempList.removeAt(0); 
      }

      historyList.clear();
      historyList.addAll(tempList.reversed);

      SharedPref.saveHistoryList(historyList.toList());

      update();
    } else if (responseData['error-type'] != null) {
      Get.snackbar('Error', responseData['error-type']);
    } else {
      Get.snackbar('Error', 'Unknow Server Error');
    }
  }

  setTheme() {
    Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
    checkDarkModeEnable();
  }
}
