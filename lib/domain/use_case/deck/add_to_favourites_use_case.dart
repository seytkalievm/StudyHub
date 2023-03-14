import 'package:get/get.dart';
import '../../../model/repository/deck_repository.dart';
import '../../../model/models/deck.dart';
import '../../../model/repository/cached_repository.dart';

class AddToFavouritesUseCase {
  const AddToFavouritesUseCase._();

  static void invoke(Deck deck) {
    DeckRepository remoteRepo = Get.find();
    CachedRepository cache = Get.find();

    remoteRepo.addToFavourites(deck);
    cache.addToFavourites(deck: deck);
  }
}
