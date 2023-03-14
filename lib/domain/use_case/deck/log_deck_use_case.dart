import 'package:get/get.dart';
import '../../../model/repository/cached_repository.dart';
import '../../../model/repository/deck_repository.dart';
import '../../../model/models/deck.dart';

class LogDeckUseCase {
  LogDeckUseCase._();

  static void invoke(Deck deck) {
    DeckRepository remoteRepo = Get.find();
    CachedRepository cacheRepo = Get.find();

    remoteRepo.logDeck(deck.id);
    cacheRepo.logDeck(deck: deck);
  }
}
