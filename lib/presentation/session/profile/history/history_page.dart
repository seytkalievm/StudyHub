import 'package:flutter/material.dart';
import '../../../util/color_codes.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'HistoryPage content',
          style: TextStyle(color: unselectedTabColor),
        ),
      ),
    );
  }
}
