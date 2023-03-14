import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../presentation/util/color_codes.dart';
import 'fullscreen_image.dart';

Widget imagePreview(String url, double height) {
  return Container(
    margin: const EdgeInsets.all(10),
    constraints: BoxConstraints(
      maxHeight: height,
      maxWidth: 300,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: unselectedMenuColor),
    ),
    child: GestureDetector(
      onTap: () {
        Get.to(() => FullScreenImage(url: url));
      },
      child: Hero(
        tag: url,
        child: Image.network(
          url,
          fit: BoxFit.scaleDown,
          height: height,
        ),
      ),
    ),
  );
}
