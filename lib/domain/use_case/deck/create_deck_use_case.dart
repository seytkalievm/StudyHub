import 'package:get/get.dart';
import 'package:study_hub/model/models/create_deck.dart';
import 'package:study_hub/model/models/resource.dart';
import 'package:study_hub/model/repository/deck_repository.dart';
import '../../../model/models/deck.dart';
import '../../../model/repository/cached_repository.dart';

class CreateDeckUseCase {
  const CreateDeckUseCase._();

  static Future<Resource<Deck>> invoke(CreateDeck deck) async {
    DeckRepository remote = Get.find();
    CachedRepository cache = Get.find();

    var response = await remote.uploadDeck(deck);

    if (response is Success) {
      cache.uploadDeck(deck: response.data!);
    }

    return response;
  }
}
