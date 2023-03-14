import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../presentation/main_controller.dart';
import 'presentation/main_binding.dart';
import 'presentation/util/app_pages.dart';
import 'presentation/util/color_codes.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());

    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: GetMaterialApp(
        theme: ThemeData(
          primarySwatch: mainAppColor,
          scaffoldBackgroundColor: const Color.fromARGB(255, 14, 22, 33),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: controller.initialRoute,
        initialBinding: MainBinding(),
        getPages: AppPages.list,
      ),
    );
  }
}
