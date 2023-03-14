import 'package:get/get.dart';
import '../../../model/models/deck.dart';
import '../../../model/repository/cached_repository.dart';

class GetFavouritesUseCase {
  const GetFavouritesUseCase._();

  static Future<RxList<Deck>> invoke() async {
    CachedRepository cacheRepo = Get.find();

    if (cacheRepo.favouriteDecks.isEmpty) {
      await cacheRepo.updateFavourites();
    }

    return cacheRepo.favouriteDecks;
  }
}
