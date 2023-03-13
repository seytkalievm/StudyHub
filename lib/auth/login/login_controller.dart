import 'package:get/get.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }
}
