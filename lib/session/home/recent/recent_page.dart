import 'package:flutter/material.dart';
import '../../../util/color_codes.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'RecentPage content',
          style: TextStyle(color: unselectedTabColor),
        ),
      ),
    );
  }
}
