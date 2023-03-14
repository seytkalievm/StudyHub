import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:study_hub/domain/repository/local/cached_repo_impl.dart';
import 'package:study_hub/domain/repository/remote/test_deck_repository.dart';
import 'package:study_hub/domain/use_case/deck/log_deck_use_case.dart';
import 'package:study_hub/model/models/deck.dart';
import 'package:study_hub/model/repository/cached_repository.dart';
import 'package:study_hub/model/repository/deck_repository.dart';

final deck1 = Deck(
  id: 0,
  folderId: 1,
  authorId: 0,
  deckName: "Test Deck1",
  semester: "F00",
  cards: [],
  isFavourite: false,
);

final deck2 = Deck(
  id: 1,
  folderId: 2,
  authorId: 1,
  deckName: "Test Deck 2",
  semester: "F01",
  cards: [],
  isFavourite: false,
);

void main() {
  Get.put<DeckRepository>(TestDeckRepository());
  Get.put<CachedRepository>(CachedRepoImpl());

  group('Testing Use Cases', () {
    CachedRepository cache = Get.find();

    test('A new deck should be added to recents', () async {
      LogDeckUseCase.invoke(deck1);
      expect(cache.recentDecks[0] == deck1, true);

      LogDeckUseCase.invoke(deck2);
      expect(cache.recentDecks[0] == deck2, true);

      LogDeckUseCase.invoke(deck1);
      expect(cache.recentDecks[0] == deck1, true);
    });
  });
}
