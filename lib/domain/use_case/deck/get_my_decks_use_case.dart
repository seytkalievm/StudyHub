import 'package:get/get.dart';
import 'package:study_hub/model/repository/cached_repository.dart';
import '../../../model/models/deck.dart';

class GetMyDecksUseCase {
  GetMyDecksUseCase._();

  static RxList<Deck> invoke() {
    CachedRepository cacheRepo = Get.find();

    if (cacheRepo.myDecks.isEmpty) {
      cacheRepo.updateMyDecks();
    }

    return cacheRepo.myDecks;
  }
}
