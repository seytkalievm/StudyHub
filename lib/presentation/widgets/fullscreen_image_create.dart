import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../model/models/create_card.dart';

class FullscreenImageCreate extends StatelessWidget {
  const FullscreenImageCreate({
    Key? key,
    required this.card,
    required this.isQuestion,
    required this.index,
    required this.update,
    required this.heroTag,
  }) : super(key: key);
  final String heroTag;
  final VoidCallback update;
  final CreateCard card;
  final bool isQuestion;
  final int index;

  @override
  Widget build(BuildContext context) {
    String imagePath =
        isQuestion ? card.questionImage! : card.answerImages![index];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/create_cards/delete_card.svg",
              width: 20,
              height: 20,
            ),
            onPressed: () {
              if (isQuestion) {
                card.questionImage = null;
              } else {
                card.answerImages!.removeAt(index);
              }
              update();
              Get.back();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Hero(
            tag: heroTag,
            child: Image(
              image: FileImage(File(imagePath)),
            ),
          ),
        ),
      ),
    );
  }
}
