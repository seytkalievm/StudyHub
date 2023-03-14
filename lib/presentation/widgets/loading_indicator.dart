import 'package:flutter/material.dart';
import '../util/color_codes.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: mainAppColor,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            color: selectedTabColor,
          ),
        ],
      ),
    );
  }
}
