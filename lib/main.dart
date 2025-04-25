import 'package:flutter/material.dart';
import 'package:flutter_application_demo/presentation/pages/currency_converter.dart';
import 'package:flutter_application_demo/utils/prefs.dart';
import 'package:get/get.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await SharedPref.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurrencyConverterScreen(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Get.isDarkMode? ThemeMode.dark:ThemeMode.light,
    );
  }
}
