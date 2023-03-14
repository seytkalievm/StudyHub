import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../session/deck_preview/deck_preview.dart';
import '../../../util/color_codes.dart';
import '../../../widgets/loading_indicator.dart';
import 'my_decks_controller.dart';

class MyDecksPage extends StatelessWidget {
  const MyDecksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return GetBuilder<MyDecksController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: controller.isLoading
              ? const LoadingIndicator()
              : Obx(
                  () => controller.decks.isEmpty
                      ? const Center(
                          child: Text(
                            "You have no decks.\nPerfect time to create one",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: selectedMenuColor,
                            ),
                          ),
                        )
                      : kIsWeb
                          ? _web(controller, screenSize)
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.decks.length,
                              itemBuilder: (context, index) {
                                return DeckPreview(
                                  deck: controller.decks[index],
                                );
                              },
                            ),
                ),
        ),
      );
    });
  }

  _web(MyDecksController controller, Size screenSize) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(108, 20, 102, 5),
        child: DynamicHeightGridView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          /*gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio:
                  screenSize.width / screenSize.height * 1.4,
                ),*/
          crossAxisCount: screenSize.width > 1500
              ? 4
              : screenSize.width > 1300
                  ? 3
                  : screenSize.width > 1000
                      ? 2
                      : 1,
          itemCount: controller.decks.length,
          builder: (context, index) {
            return DeckPreview(deck: controller.decks[index]);
          },
        ),
      ),
    );
  }
}
