import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_hub/model/models/resource.dart';
import 'package:study_hub/model/models/search_query.dart';
import '../../../../model/models/deck.dart';
import '../../../../model/models/folder.dart';
import '../../../../model/repository/deck_repository.dart';
import '../../../util/color_codes.dart';

class SearchController extends GetxController {
  DeckRepository deckRepo = Get.find<DeckRepository>();

  RxList<Deck> decks = RxList();
  RxList<Folder> folders = RxList();

  bool hasResults = true;

  void search(String query) async {
    showLoadingIndicator();
    var response = await deckRepo.search(SearchQuery(query: query));
    Navigator.of(Get.overlayContext!).pop();

    if (response is Success) {
      decks.value = response.data!.decks;
      folders.value = response.data!.folders;
      hasResults = (decks.isNotEmpty || folders.isNotEmpty);
      update();
    }
  }

  void showLoadingIndicator() {
    Get.dialog(
      const AlertDialog(
        backgroundColor: mainAppColor,
        content: SizedBox(
          height: 50,
          child: Center(
            child: CircularProgressIndicator(color: selectedTabColor),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
