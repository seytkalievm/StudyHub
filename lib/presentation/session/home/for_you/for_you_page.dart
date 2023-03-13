import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../deck_preview/deck_preview.dart';
import 'for_you_controller.dart';

class ForYouPage extends StatelessWidget {
  const ForYouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ForYouController>(() => ForYouController());

    return GetBuilder<ForYouController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              const SizedBox(
                height: 17.5,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.decks.length,
                itemBuilder: (context, index) {
                  return DeckPreview(deck: controller.decks[index]);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
