import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/continue_with_ui_button.dart';
import '../../widgets/divider.dart';
import '../../widgets/outlined_text_field.dart';
import '../../widgets/themed_material_button.dart';
import 'login_controller.dart';
import '../../util/color_codes.dart';
import '../../util/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      void showSnackBar() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              controller.snackBarError.toString(),
            ),
          ),
        );
      }

      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login_page.png"),
                alignment: Alignment.centerLeft,
              ),
            ),
            child: ListView(
              children: <Widget>[
                _heading(),
                OutlinedTextField(
                  label: "Email",
                  prefixIconData: Icons.email_outlined,
                  textFieldController: controller.emailController,
                  inputType: TextInputType.emailAddress,
                  error: controller.emailError,
                ),
                _passwordFormField(controller: controller),
                _forgotPasswordButton(),
                _loginButton(controller, showSnackBar),
                _registerButton(),
                const ThemedDivider(),
                ContinueWithUIButton(callback: () async {
                  debugPrint("Hello");
                  controller.loginWithIU();
                }),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _heading() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.only(top: 50, right: 20, bottom: 65),
        child: const Text(
          "Welcome Back!",
          style: TextStyle(
            color: selectedMenuColor,
            fontSize: 28,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _passwordFormField({required LoginController controller}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: TextFormField(
        style: const TextStyle(color: selectedMenuColor),
        cursorColor: unselectedMenuColor,
        maxLines: 1,
        controller: controller.passwordController,
        obscureText: !controller.isPasswordVisible,
        decoration: InputDecoration(
          focusColor: selectedMenuColor,
          filled: true,
          fillColor: backgroundDarkBlue,
          errorText: controller.passwordError,
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: greySecondary,
          ),
          labelText: "Password",
          suffixIcon: IconButton(
            onPressed: () {
              controller.changePasswordVisibility();
            },
            icon: Icon(
              !controller.isPasswordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: greySecondary,
            ),
          ),
          labelStyle: const TextStyle(
            color: unselectedMenuColor,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: unselectedMenuColor),
          ),
        ),
      ),
    );
  }

  Widget _forgotPasswordButton() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(right: 34),
      child: TextButton(
        onPressed: () {
          //TODO
        },
        child: const Text(
          "Forgot password?",
          style: TextStyle(
            color: unselectedMenuColor,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _loginButton(LoginController controller, VoidCallback showSnackBar) {
    if (controller.isLoading) {
      return Container(
        margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        height: 44,
        child: MaterialButton(
          onPressed: () {
            //TODO
          },
          child: const CircularProgressIndicator(),
        ),
      );
    }

    return ThemedMaterialButton(
      text: "Login",
      color: selectedTabColor,
      callback: () async {
        await controller.login();
        FocusManager.instance.primaryFocus?.unfocus();
        if (controller.snackBarError != null) {
          showSnackBar();
        }
      },
    );
  }

  Widget _registerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(
            color: selectedMenuColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(AppRoutes.register);
          },
          child: const Text(
            "Register",
            style: TextStyle(
              color: selectedTabColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
