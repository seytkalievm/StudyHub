import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../util/color_codes.dart';
import '../util/do_nothing_callback.dart';

class OutlinedTextField extends StatelessWidget {
  final String label;
  final TextEditingController? textFieldController;
  final IconData? prefixIconData;
  final String? assetName;
  final TextInputType? inputType;
  final String? error;

  const OutlinedTextField({
    super.key,
    required this.label,
    this.prefixIconData,
    this.assetName,
    this.textFieldController,
    this.inputType,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    IconButton? prefixIcon;

    if (assetName != null) {
      IconButton kek = IconButton(
        icon: SvgPicture.asset(
          assetName!,
          color: greySecondary,
          fit: BoxFit.scaleDown,
        ),
        onPressed: () {
          doNothing();
        },
      );
      prefixIcon = kek;
    } else {
      prefixIcon = prefixIconData == null
          ? null
          : IconButton(
              icon: Icon(prefixIconData),
              color: greySecondary,
              onPressed: () {
                doNothing();
              },
            );
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: TextFormField(
        controller: textFieldController,
        style: const TextStyle(color: selectedMenuColor),
        cursorColor: unselectedMenuColor,
        maxLines: 1,
        keyboardType: inputType,
        decoration: InputDecoration(
          filled: true,
          errorText: error,
          fillColor: backgroundDarkBlue,
          prefixIcon: prefixIcon,
          labelText: label,
          labelStyle: const TextStyle(
            color: unselectedMenuColor,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: unselectedMenuColor),
          ),
        ),
      ),
    );
  }
}
