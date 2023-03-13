import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_hub/presentation/session/deck_preview/deck_preview.dart';
import 'my_decks_controller.dart';

class MyDecksPage extends StatelessWidget {
  const MyDecksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<MyDecksController>(() => MyDecksController());

    return GetBuilder<MyDecksController>(builder: (controller) {
      return Scaffold(
        body: Center(
          child: controller.decks == null
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.decks!.length,
                  itemBuilder: (context, index) {
                    debugPrint(
                        "index: $index, card: ${controller.decks![index]}");

                    return DeckPreview(deck: controller.decks![index]);
                  },
                ),
        ),
      );
    });
  }
}
