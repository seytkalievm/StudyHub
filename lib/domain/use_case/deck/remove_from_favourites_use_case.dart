import 'package:get/get.dart';
import '../../../model/models/deck.dart';
import '../../../model/repository/cached_repository.dart';
import '../../../model/repository/deck_repository.dart';

class RemoveFromFavouritesUseCase {
  const RemoveFromFavouritesUseCase._();

  static void invoke(Deck deck) {
    DeckRepository remoteRepo = Get.find();
    CachedRepository cache = Get.find();

    remoteRepo.removeFromFavourites(deck);
    cache.deleteFromFavourites(deck: deck);
  }
}
