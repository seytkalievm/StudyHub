import 'package:get/get.dart';
import '../../../model/repository/cached_repository.dart';
import '../../../model/models/deck.dart';

class GetRecentDecksUseCase {
  GetRecentDecksUseCase._();

  static Future<RxList<Deck>> invoke() async {
    CachedRepository cacheRepo = Get.find();

    if (cacheRepo.myDecks.isEmpty) {
      await cacheRepo.updateRecent();
    }

    return cacheRepo.recentDecks;
  }
}
