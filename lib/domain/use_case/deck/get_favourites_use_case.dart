import 'package:get/get.dart';
import '../../../model/models/deck.dart';
import '../../../model/repository/cached_repository.dart';

class GetFavouritesUseCase {
  const GetFavouritesUseCase._();

  static RxList<Deck> invoke() {
    CachedRepository cacheRepo = Get.find();

    if (cacheRepo.favouriteDecks.isEmpty) {
      cacheRepo.updateFavourites();
    }

    return cacheRepo.favouriteDecks;
  }
}
