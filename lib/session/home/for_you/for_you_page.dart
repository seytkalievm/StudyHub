import 'package:flutter/material.dart';
import '../../../util/color_codes.dart';

class ForYouPage extends StatelessWidget {
  const ForYouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'ForYouPage content',
          style: TextStyle(color: unselectedTabColor),
        ),
      ),
    );
  }
}
