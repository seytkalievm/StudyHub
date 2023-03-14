import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_hub/presentation/util/do_nothing_callback.dart';
import '../../../presentation/widgets/themed_material_button.dart';
import '../../util/color_codes.dart';
import '../../widgets/continue_with_ui_button.dart';
import '../../widgets/divider.dart';
import '../../widgets/outlined_text_field.dart';
import 'register_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      void showSnackBar() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              controller.snackBarError.toString(),
            ),
          ),
        );
      }

      return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: kIsWeb
                ? SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 601,
                          width: 333,
                          margin:
                              const EdgeInsets.only(top: 102.0, bottom: 103.0),
                          child: Column(
                            children: <Widget>[
                              _webHeading(),
                              const SizedBox(
                                height: 87,
                              ),
                              OutlinedTextField(
                                label: "Email",
                                prefixIconData: Icons.email_outlined,
                                textFieldController: controller.emailController,
                                inputType: TextInputType.emailAddress,
                                error: controller.emailError,
                              ),
                              OutlinedTextField(
                                label: "Full name",
                                assetName:
                                    "assets/icons/bottom_bar/profile_bottom_bar_ic_no_notification.svg",
                                textFieldController:
                                    controller.fullNameController,
                                error: controller.fullNameError,
                              ),
                              _passwordFormField(controller: controller),
                              const SizedBox(
                                height: 10,
                              ),
                              _registerButton(controller, showSnackBar),
                              _loginButton(),
                              const SizedBox(
                                height: 18,
                              ),
                              const ThemedDivider(),
                              ContinueWithUIButton(callback: () {
                                controller.loginWithIU();
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 114,
                        ),
                        _webImageBackground(),
                      ],
                    ),
                  )
                : Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/register_page.png"),
                        alignment: Alignment.centerRight,
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
                        OutlinedTextField(
                          label: "Full name",
                          assetName:
                              "assets/icons/bottom_bar/profile_bottom_bar_ic_no_notification.svg",
                          textFieldController: controller.fullNameController,
                          error: controller.fullNameError,
                        ),
                        _passwordFormField(controller: controller),
                        _registerButton(controller, showSnackBar),
                        _loginButton(),
                        const ThemedDivider(),
                        ContinueWithUIButton(callback: () {
                          controller.loginWithIU();
                        }),
                      ],
                    ),
                  ),
          ),
        ),
      );
    });
  }

  Widget _heading() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 50, left: 20, bottom: 65),
        child: const Text(
          "Create Account",
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

  Widget _webImageBackground() {
    return Container(
      height: 601,
      width: 290,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/register_page.png"),
          alignment: Alignment.centerRight,
        ),
      ),
    );
  }

  Widget _webHeading() {
    return const Align(
      alignment: Alignment.topLeft,
      child: Text(
        "Create Account",
        style: TextStyle(
          color: selectedMenuColor,
          fontSize: 48,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _passwordFormField({required RegisterController controller}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: TextFormField(
        controller: controller.passwordController,
        style: const TextStyle(color: selectedMenuColor),
        cursorColor: unselectedMenuColor,
        maxLines: 1,
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

  Widget _registerButton(
    RegisterController controller,
    VoidCallback showSnackBar,
  ) {
    if (controller.isLoading) {
      return Container(
        margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        height: 44,
        child: MaterialButton(
          onPressed: () {
            doNothing();
          },
          child: const CircularProgressIndicator(),
        ),
      );
    }

    return ThemedMaterialButton(
      text: "Register",
      color: selectedTabColor,
      callback: () async {
        await controller.register();
        FocusManager.instance.primaryFocus?.unfocus();
        if (controller.snackBarError != null) {
          showSnackBar();
        }
      },
    );
  }

  Widget _loginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(
            color: selectedMenuColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            "Login",
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
