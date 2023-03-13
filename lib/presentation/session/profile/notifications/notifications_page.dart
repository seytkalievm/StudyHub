import 'package:flutter/material.dart';
import '../../../util/color_codes.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'NotificationsPage content',
          style: TextStyle(color: unselectedTabColor),
        ),
      ),
    );
  }
}
