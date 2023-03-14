import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:study_hub/domain/repository/local/cached_repo_impl.dart';
import 'package:study_hub/domain/repository/remote/test_deck_repository.dart';
import 'package:study_hub/domain/use_case/deck/create_deck_use_case.dart';
import 'package:study_hub/model/models/create_deck.dart';
import 'package:study_hub/model/models/deck.dart';
import 'package:study_hub/model/repository/cached_repository.dart';
import 'package:study_hub/model/repository/deck_repository.dart';

final createDeck = CreateDeck(
  folderId: 0,
  deckName: "Test Deck",
  semester: "F00",
);

final createdDeck = Deck(
  id: 0,
  folderId: 0,
  authorId: 0,
  deckName: "Test Deck",
  semester: "F00",
  cards: [],
  isFavourite: false,
);

void main() {
  Get.put<DeckRepository>(TestDeckRepository());
  Get.put<CachedRepository>(CachedRepoImpl());

  group('Testing Use Cases', () {
    CachedRepository cache = Get.find();

    test('A new deck should be added', () async {
      await CreateDeckUseCase.invoke(createDeck);
      expect(cache.myDecks.contains(createdDeck), true);
    });
  });
}
