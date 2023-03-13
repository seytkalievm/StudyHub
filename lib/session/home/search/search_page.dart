import 'package:flutter/material.dart';
import '../../../util/color_codes.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'SearchPage content',
          style: TextStyle(color: unselectedTabColor),
        ),
      ),
    );
  }
}
