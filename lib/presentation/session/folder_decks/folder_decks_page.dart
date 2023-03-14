import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

import '../../../model/models/folder.dart';
import '../../util/color_codes.dart';
import '../deck_preview/deck_preview.dart';
import 'folder_decks_controller.dart';

class FolderDecksPage extends StatelessWidget {
  final Folder folder;

  const FolderDecksPage({
    required this.folder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<FolderDecksController>(() => FolderDecksController(folder.id));

    var screenSize = MediaQuery.of(context).size;

    return GetBuilder<FolderDecksController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(title: Text(folder.name)),
        body: SafeArea(
          child: controller.isEmpty
              ? Center(
                  child: controller.isLoading
                      ? AlertDialog(
                          backgroundColor: mainAppColor,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(
                                color: selectedTabColor,
                              ),
                            ],
                          ),
                        )
                      : const Text(
                          "No decks available.",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: greySecondary,
                          ),
                        ),
                )
              : kIsWeb
                  ? _webFolderDecksPage(controller, screenSize)
                  : ListView.builder(
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
      );
    });
  }

  _webFolderDecksPage(FolderDecksController controller, Size screenSize) {
    return Column(
      children: [
        _webSearchBar(),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(108, 40, 102, 5),
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
              builder: (BuildContext context, int index) {
                return DeckPreview(
                  deck: controller.decks[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _webSearchBar() {
    //TODO search bar
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
