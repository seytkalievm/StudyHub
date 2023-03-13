import 'package:flutter/material.dart';

import '../util/color_codes.dart';

class ContinueWithUIButton extends StatelessWidget {
  final VoidCallback callback;
  const ContinueWithUIButton({Key? key, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      height: 44,
      child: MaterialButton(
        onPressed: callback,
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
