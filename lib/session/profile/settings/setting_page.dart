import 'package:flutter/material.dart';
import '/util/color_codes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'SettingsPage content',
          style: TextStyle(color: unselectedTabColor),
        ),
      ),
    );
  }
}
