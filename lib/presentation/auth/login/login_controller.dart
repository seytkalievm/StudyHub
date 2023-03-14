import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../model/models/resource.dart';
import '../../../domain/use_case/auth/login_wtih_iu_use_case.dart';
import '../../../model/repository/auth_repository.dart';
import '../../util/routes.dart';

class LoginController extends GetxController {
  AuthRepository authRepo = Get.find();

  LoginController() {
    emailController.addListener(() {
      _email = emailController.text.toString();
      emailError = null;
      update();
    });

    passwordController.addListener(() {
      _password = passwordController.text.toString();
      passwordError = null;
      update();
    });
  }

  var isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _email = "";
  String _password = "";

  String? emailError;
  String? passwordError;
  String? snackBarError;
  bool isLoading = false;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  Future<void> login() async {
    snackBarError = null;
    if (!isFormValid()) return;

    isLoading = true;
    update();
    var response = await authRepo.login(email: _email, password: _password);
    if (response is Success) {
      isLoading = false;
      update();
      Get.offNamed(AppRoutes.session);
    } else {
      snackBarError = response.message.toString();
      isLoading = false;
      update();
    }
  }

  bool isFormValid() {
    bool isValid = true;
    if (_email.isEmpty) {
      emailError = "Email cannot be empty";
      isValid = false;
    }
    if (_password.isEmpty) {
      passwordError = "Password cannot be empty";
      isValid = false;
    }
    update();

    return isValid;
  }

  void loginWithIU() async {
    isLoading = true;
    update();
    var response = await LoginWithIUUseCase.invoke();
    debugPrint(response.toString());
    if (response is Success) {
      isLoading = false;
      update();
      Get.offNamed(AppRoutes.session);
    } else {
      snackBarError = response.message.toString();
      isLoading = false;
      update();
    }
  }
}
