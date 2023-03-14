import 'package:flutter/material.dart';
import '../../../widgets/folder_view.dart';
import '../../deck_preview/deck_preview.dart';
import 'search_controller.dart';
import 'package:get/get.dart';
import '../../../util/color_codes.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SearchController>(() => SearchController());

    return GetBuilder<SearchController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: selectedMenuColor,
                    ),
                  ),
                  _searchBar(controller),
                ],
              ),
              Expanded(
                child: controller.hasResults
                    ? ListView(
                        children: [
                          Obx(
                            () => ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.folders.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FolderView(
                                  folder: controller.folders[index],
                                );
                              },
                            ),
                          ),
                          Obx(
                            () => ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.decks.length,
                              itemBuilder: (BuildContext context, int index) {
                                return DeckPreview(
                                  deck: controller.decks[index],
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text(
                          "No results",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: selectedMenuColor,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _searchBar(SearchController controller) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 20, top: 6),
        height: 48,
        child: TextField(
          //controller: controller,
          decoration: const InputDecoration(
            filled: true,
            fillColor: mainAppColor,
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintStyle: TextStyle(fontSize: 16, color: unselectedTabColor),
            hintText: "Search for a deck or course",
            suffixIcon: Icon(Icons.filter_alt_outlined, color: greySecondary),
          ),
          style: const TextStyle(fontSize: 18, color: greySecondary),
          cursorColor: greySecondary,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            debugPrint(value);
            controller.search(value);
          },
        ),
      ),
    );
  }
}
