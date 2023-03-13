import 'package:get/get.dart';

class RegisterController extends GetxController {
  var isPasswordVisible = false;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }
}
