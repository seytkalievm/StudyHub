import 'package:get/get.dart';
import '../../../model/models/create_deck.dart';
import '../../../model/models/resource.dart';
import '../../../model/repository/deck_repository.dart';
import '../../../model/models/deck.dart';
import '../../../model/repository/cached_repository.dart';

class CreateDeckFromSheetUseCase {
  const CreateDeckFromSheetUseCase._();

  static Future<Resource<Deck>> invoke(CreateDeck deck, String link) async {
    DeckRepository remote = Get.find();
    CachedRepository cache = Get.find();

    var response = await remote.uploadDeckFromSheet(deck, link);

    if (response is Success) {
      cache.uploadDeck(deck: response.data!);
    }

    return response;
  }
}
