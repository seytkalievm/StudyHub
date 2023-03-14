import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:study_hub/common/constants.dart';
import '../../../domain/use_case/auth/login_wtih_iu_use_case.dart';
import '../../../model/models/resource.dart';
import '../../../model/repository/auth_repository.dart';
import '../../util/routes.dart';

class RegisterController extends GetxController {
  AuthRepository authRepo = Get.find();

  RegisterController() {
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

    fullNameController.addListener(() {
      _fullName = fullNameController.text.toString();
      fullNameError = null;
      update();
    });
  }

  var isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _email = "";
  String _password = "";
  String _fullName = "";

  String? emailError;
  String? passwordError;
  String? fullNameError;
  String? snackBarError;
  bool isLoading = false;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  Future<void> register() async {
    snackBarError = null;

    bool isFormValid = validateForm();
    if (!isFormValid) return;

    isLoading = true;
    update();
    var response = await authRepo.register(
      email: _email,
      password: _password,
      fullName: _fullName,
    );

    if (response is Success) {
      //Get.back();
      isLoading = false;
      update();
      Get.offAllNamed(AppRoutes.session);
    }
    if (response is Fail) {
      if (response.errorCode == registerCredentialsAlreadyExistCode) {
        emailError = response.message;
        isLoading = false;
        update();
      } else {
        snackBarError = response.message.toString();
        isLoading = false;
        update();
      }
    }
  }

  bool validateForm() {
    validateEmail();
    validatePassword();
    validateFullName();
    update();

    return emailError == null && passwordError == null && fullNameError == null;
  }

  validateEmail() {
    var emailPattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    if (_email.isEmpty) {
      emailError = "Email cannot be empty";
    } else if (!RegExp(emailPattern).hasMatch(_email)) {
      emailError = "Invalid email";
    } else {
      emailError = null;
    }
  }

  validatePassword() {
    passwordError = _password.length < 8
        ? "Password must be at least 8 characters long"
        : null;
  }

  validateFullName() {
    fullNameError = _fullName.isEmpty ? "Full Name cannot be empty" : null;
  }

  void loginWithIU() async {
    isLoading = true;
    var response = await LoginWithIUUseCase.invoke();
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
