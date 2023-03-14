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
    return Scaffold(
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
                margin: const EdgeInsets.only(top: 68.0, left: 20, right: 20),
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
}
