import 'package:flutter/material.dart';
import '../../../util/color_codes.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'GroupsPage content',
          style: TextStyle(color: unselectedTabColor),
        ),
      ),
    );
  }
}
