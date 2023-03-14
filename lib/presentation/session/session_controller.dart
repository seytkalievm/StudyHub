import 'package:get/get.dart';

class SessionController extends GetxController {
  var tabIndex = 0;

  var pages = ["Home", "Create", "Profile"];

  var tabTitle = "Home";

  void changePage(int index) {
    tabTitle = pages[index];
    tabIndex = index;
    update();
  }
}
