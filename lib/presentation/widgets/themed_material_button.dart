import 'package:flutter/material.dart';
import '../util/color_codes.dart';

class ThemedMaterialButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final MaterialColor color;

  const ThemedMaterialButton({
    super.key,
    required this.text,
    required this.callback,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      height: 44,
      child: MaterialButton(
        onPressed: callback,
        color: color,
        child: Text(
          text,
          style: const TextStyle(
            color: selectedMenuColor,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
