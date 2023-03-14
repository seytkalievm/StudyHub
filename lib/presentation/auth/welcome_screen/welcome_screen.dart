import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/use_case/auth/login_wtih_iu_use_case.dart';
import '../../../model/models/resource.dart';
import '../../util/color_codes.dart';
import '../../util/routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? _web()
        : Scaffold(
            body: ListView(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 21.0),
                    child: const Text(
                      "StudyHub",
                      style: TextStyle(
                        color: selectedMenuColor,
                        fontSize: 40,
                        fontFamily: "ArchitectsDaughter",
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 21.0),
                    child: const Text(
                      "prepare to exams together",
                      style: TextStyle(
                        color: selectedMenuColor,
                        fontSize: 24,
                        fontFamily: "ArchitectsDaughter",
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(top: 21.0),
                    child: Image.asset("assets/images/wel.png"),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      margin:
                          const EdgeInsets.only(top: 68.0, left: 20, right: 20),
                      height: 44,
                      child: MaterialButton(
                        onPressed: () async {
                          var response = await LoginWithIUUseCase.invoke();
                          debugPrint(response.toString());
                          if (response is Success) {
                            Get.offNamed(AppRoutes.session);
                          }
                        },
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
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      height: 44,
                      child: MaterialButton(
                        onPressed: () {
                          Get.offNamed(AppRoutes.login);
                        },
                        color: selectedTabColor,
                        child: const Text(
                          "Continue with email",
                          style: TextStyle(
                            color: selectedMenuColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  _web() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _webTextAndButtons(),
              const SizedBox(width: 23),
              _webWelcomeImage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _webTextAndButtons() {
    return Container(
      width: 510,
      margin: const EdgeInsets.only(top: 150.0, bottom: 150.0, left: 194.0),
      child: Column(
        children: <Widget>[
          _webTextTitleAndSubtitle(),
          const SizedBox(
            height: 197,
          ),
          _webEmailButtons(),
        ],
      ),
    );
  }

  Widget _webWelcomeImage() {
    return Container(
      margin: const EdgeInsets.only(top: 150.0, bottom: 150.0, right: 54.0),
      height: 450,
      width: 659,
      child: Image.asset("assets/images/wel.png"),
    );
  }

  Widget _webTextTitleAndSubtitle() {
    return Column(
      children: const <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "StudyHub",
            style: TextStyle(
              color: selectedMenuColor,
              fontSize: 64,
              fontFamily: "ArchitectsDaughter",
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "prepare to exams together",
            style: TextStyle(
              color: selectedMenuColor,
              fontSize: 36,
              fontFamily: "ArchitectsDaughter",
            ),
          ),
        ),
      ],
    );
  }

  Widget _webEmailButtons() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _webInnopolisAccountContainer(),
          const SizedBox(
            height: 15,
          ),
          _webMailAccountContainer(),
        ],
      ),
    );
  }

  Widget _webInnopolisAccountContainer() {
    return SizedBox(
      height: 44,
      width: 320,
      child: MaterialButton(
        onPressed: () {
          //TODO
        },
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

  Widget _webMailAccountContainer() {
    return SizedBox(
      height: 44,
      width: 320,
      child: MaterialButton(
        onPressed: () {
          Get.offNamed(AppRoutes.login);
        },
        color: selectedTabColor,
        child: const Text(
          "Continue with email",
          style: TextStyle(
            color: selectedMenuColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
