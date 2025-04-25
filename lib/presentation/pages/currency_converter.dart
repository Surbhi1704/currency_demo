import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_demo/presentation/controller/currency_converter_controller.dart';
import 'package:flutter_application_demo/utils/prefs.dart';
import 'package:flutter_application_demo/widgets/common_dropdrown.dart';
import 'package:get/get.dart';

class CurrencyConverterScreen extends StatelessWidget {
  CurrencyConverterScreen({super.key});
  TextEditingController amountTextController = TextEditingController();
 List<dynamic> historyPrefList = [];
 @override
  Widget build(BuildContext context) {
    final controller = Get.put(CurrentConverterController());
    controller.checkDarkModeEnable();
    controller.getCode();

    if(controller.historyList.isEmpty){ 
      
  
     historyPrefList=jsonDecode(SharedPref.getHistoryList());

     if(historyPrefList.isNotEmpty) controller.historyList.value = historyPrefList;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Currency Converter',
        ),
        actions: [
          GestureDetector(
            onTap: () {
              controller.setTheme();
              controller.update();
            },
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  controller.isDark.value ? Icons.nightlight : Icons.sunny,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 10,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                maxLines: 1,
                maxLength: 8,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(8),
                ],
                decoration: InputDecoration(
                  hintText: 'Amount',
                ),
                controller: amountTextController,
              ),
              Obx(() => DropdownButton(
                  value: controller.baseValue.value,
                  items: controller.codeList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    controller.baseValue.value = value!;
                    controller.update();
                  })),
              GestureDetector(onTap: () {}, child: Icon(Icons.swap_vertical_circle)),
              Obx(() => DropdownButton(
                  value: controller.targetValue.value,
                  items: controller.codeList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    controller.targetValue.value = value!;
                    controller.update();
                  })),
              ElevatedButton(
                  onPressed: () {
                    if (amountTextController.text.isEmpty) {
                      Get.snackbar('Error', 'Please enter the amount');
                      return;
                    }
                    if (amountTextController.text.isNotEmpty && int.parse(amountTextController.text) == 0) {
                      Get.snackbar('Error', 'Please enter the value greater than zero');
                      return;
                    } else if (controller.baseValue.value == controller.targetValue.value) {
                      Get.snackbar('Error', 'Please choose correct currency code');
                      return;
                    }
                    controller.getConvert(controller.baseValue.value, controller.targetValue.value, amountTextController.text);
                  },
                  child: Text("Convert")),
              if (controller.result.value != null && controller.result.value != "")
                Obx(() => Text(
                      '${controller.baseValue} to ${controller.targetValue} => ${controller.result.value.toString()}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              SizedBox(
                height: 5,
              ),
              if (controller.historyList.isNotEmpty)
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "History:",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              Obx(
                () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.historyList.length > 5 ? 5 : controller.historyList.length,
                    itemBuilder: (context, index) {
                      var historyData = controller.historyList[index];
                      return Text(historyData);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
