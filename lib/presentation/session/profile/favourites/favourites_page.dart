import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/color_codes.dart';
import '../../../widgets/loading_indicator.dart';
import '../../deck_preview/deck_preview.dart';
import 'favourites_controller.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return GetBuilder<FavouritesController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: controller.isLoading
              ? const LoadingIndicator()
              : Obx(
                  () => controller.decks.isEmpty
                      ? const Center(
                          child: Text(
                            "You have no favourite decks",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: selectedMenuColor,
                            ),
                          ),
                        )
                      : kIsWeb
                          ? _webFavouritesPage(controller, screenSize)
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

  _webFavouritesPage(FavouritesController controller, Size screenSize) {
    return Column(
      children: [
        _webSearchBar(),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(108, 20, 102, 5),
            child: DynamicHeightGridView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
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
        ),
      ],
    );
  }

  Widget _webSearchBar() {
    // TODO search bar
    return Container(
      margin: const EdgeInsets.only(
        right: 400,
        top: 20,
        left: 128,
      ),
      height: 48,
      child: TextField(
        onChanged: (value) => {},
        decoration: const InputDecoration(
          filled: true,
          fillColor: mainAppColor,
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintStyle: TextStyle(fontSize: 16, color: unselectedTabColor),
          hintText: "Search for a deck or course",
          prefixIcon: Icon(Icons.search, color: greySecondary),
          suffixIcon: Icon(Icons.filter_alt_outlined, color: greySecondary),
        ),
        style: const TextStyle(fontSize: 18, color: greySecondary),
        cursorColor: greySecondary,
      ),
    );
  }
}
