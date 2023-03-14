import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../deck_preview/deck_preview.dart';
import 'favourites_controller.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouritesController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: Obx(
            () => ListView.builder(
              shrinkWrap: true,
              itemCount: controller.decks.length,
              itemBuilder: (context, index) {
                return DeckPreview(deck: controller.decks[index]);
              },
            ),
          ),
        ),
      );
    });
  }
}
