import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/color_codes.dart';
import '../../../widgets/loading_indicator.dart';
import '../../deck_preview/deck_preview.dart';
import 'recent_controller.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<RecentController>(() => RecentController());

    var screenSize = MediaQuery.of(context).size;

    return GetBuilder<RecentController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: controller.isLoading
              ? const LoadingIndicator()
              : Obx(
                  () => controller.decks.isEmpty
                      ? const Center(
                          child: Text(
                            "You have no recent decks",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: selectedMenuColor,
                            ),
                          ),
                        )
                      : kIsWeb
                          ? _webRecentPage(controller, screenSize)
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

  _webRecentPage(RecentController controller, Size screenSize) {
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
