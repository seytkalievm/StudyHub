import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:study_hub/util/app_pages.dart';
import 'package:study_hub/util/color_codes.dart';
import 'package:study_hub/util/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: mainAppColor,
        scaffoldBackgroundColor: const Color.fromARGB(255, 14, 22, 33),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.session,
      getPages: AppPages.list,
    );
  }
}
