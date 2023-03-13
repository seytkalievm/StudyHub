import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:study_hub/auth/register/register_controller.dart';

import '../../util/color_codes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/register_page.png"),
                alignment: Alignment.centerRight,
              ),
            ),
            child: ListView(
              children: <Widget>[
                _heading(),
                _emailFormField(),
                _nameFormField(),
                _passwordFormField(controller: controller),
                _registerButton(),
                _loginButton(),
                _divider(),
                _continueWithUIAccount(),
              ],
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
        margin: const EdgeInsets.only(top: 50, left: 20),
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

  Widget _emailFormField() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 70, 20, 0),
      child: TextFormField(
        style: const TextStyle(color: selectedMenuColor),
        cursorColor: unselectedMenuColor,
        maxLines: 1,
        decoration: const InputDecoration(
          filled: true,
          fillColor: backgroundDarkBlue,
          prefixIcon: Icon(
            Icons.email_outlined,
            color: greySecondary,
          ),
          labelText: "Email",
          labelStyle: TextStyle(
            color: unselectedMenuColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: unselectedMenuColor),
          ),
        ),
      ),
    );
  }

  Widget _nameFormField() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: TextFormField(
        style: const TextStyle(color: selectedMenuColor),
        cursorColor: unselectedMenuColor,
        maxLines: 1,
        decoration: InputDecoration(
          filled: true,
          fillColor: backgroundDarkBlue,
          prefixIcon: SvgPicture.asset(
            "assets/icons/bottom_bar/profile_bottom_bar_ic_no_notification.svg",
            color: greySecondary,
            fit: BoxFit.scaleDown,
          ),
          labelText: "Full Name",
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

  Widget _passwordFormField({required RegisterController controller}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: TextFormField(
        style: const TextStyle(color: selectedMenuColor),
        cursorColor: unselectedMenuColor,
        maxLines: 1,
        obscureText: !controller.isPasswordVisible,
        decoration: InputDecoration(
          focusColor: selectedMenuColor,
          filled: true,
          fillColor: backgroundDarkBlue,
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

  Widget _registerButton() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      height: 44,
      child: MaterialButton(
        onPressed: () {},
        color: selectedTabColor,
        child: const Text(
          "Register",
          style: TextStyle(
            color: selectedMenuColor,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.only(top: 25, bottom: 40),
      child: Row(
        children: const [
          Expanded(
            child: Divider(
              thickness: 1,
              indent: 20,
              endIndent: 10,
              color: unselectedMenuColor,
            ),
          ),
          Text(
            "or",
            style: TextStyle(
              color: unselectedMenuColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 1,
              indent: 10,
              endIndent: 20,
              color: unselectedTabColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _continueWithUIAccount() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 44,
      child: MaterialButton(
        onPressed: () {},
        color: selectedMenuColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Image.asset(
                "assets/images/innopolis_logo.png",
                height: 24,
                width: 24,
              ),
            ),
            const Text(
              "Continue with IU account",
              style: TextStyle(
                color: selectedTabColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
