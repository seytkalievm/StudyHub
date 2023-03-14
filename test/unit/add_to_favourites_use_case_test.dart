import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:study_hub/domain/repository/local/cached_repo_impl.dart';
import 'package:study_hub/domain/repository/remote/test_deck_repository.dart';
import 'package:study_hub/domain/use_case/deck/add_to_favourites_use_case.dart';
import 'package:study_hub/model/models/deck.dart';
import 'package:study_hub/model/repository/cached_repository.dart';
import 'package:study_hub/model/repository/deck_repository.dart';

final deck = Deck(
  id: 0,
  folderId: 0,
  authorId: 0,
  deckName: "Test Deck",
  semester: "F00",
  cards: [],
  isFavourite: true,
);

void main() {
  Get.put<DeckRepository>(TestDeckRepository());
  Get.put<CachedRepository>(CachedRepoImpl());

  group('Testing Use Cases', () {
    CachedRepository cache = Get.find();

    test('A new deck should be added', () {
      AddToFavouritesUseCase.invoke(deck);
      expect(cache.favouriteDecks.contains(deck), true);
    });
  });
}
