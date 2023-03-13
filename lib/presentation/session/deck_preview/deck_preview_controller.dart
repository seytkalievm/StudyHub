import 'package:get/get.dart';
import 'package:study_hub/model/models/resource.dart';
import 'package:study_hub/model/repository/deck_repository.dart';
import 'package:study_hub/model/models/deck.dart';

class DeckPreviewController extends GetxController {
  final DeckRepository deckRepo = Get.find();

  String result = "";

  Future<void> addDeckToFavourites(Deck deck) async {
    var response = await deckRepo.addToFavourites(deck);
    if (response is Success) {
      deck.isFavourite = true;
      result = "Successfully added deck to favourites";
      update();
    } else {
      result = "Couldn't add deck to favourites, try again later";
      update();
    }
  }

  Future<void> removeDeckFromFavourites(Deck deck) async {
    var response = await deckRepo.removeFromFavourites(deck);
    if (response is Success) {
      deck.isFavourite = false;
      result = "Successfully removed deck from favourites";
      update();
    } else {
      result = "Couldn't remove deck from favourites, try again later";
      update();
    }
  }
}
