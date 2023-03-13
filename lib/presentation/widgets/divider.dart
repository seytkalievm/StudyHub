import 'package:flutter/material.dart';

import '../util/color_codes.dart';

class ThemedDivider extends StatelessWidget {
  const ThemedDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
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
}
