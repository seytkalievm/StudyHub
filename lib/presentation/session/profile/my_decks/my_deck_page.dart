import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_hub/presentation/session/deck_preview/deck_preview.dart';
import 'my_decks_controller.dart';

class MyDecksPage extends StatelessWidget {
  const MyDecksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDecksController>(builder: (controller) {
      return Scaffold(
        body: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.decks.length,
            itemBuilder: (context, index) {
              return DeckPreview(deck: controller.decks[index]);
            },
          ),
        ),
      );
    });
  }
}
