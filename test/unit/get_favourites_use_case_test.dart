import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:study_hub/domain/repository/local/cached_repo_impl.dart';
import 'package:study_hub/domain/repository/remote/test_deck_repository.dart';
import 'package:study_hub/domain/use_case/deck/get_favourites_use_case.dart';
import 'package:study_hub/model/repository/cached_repository.dart';
import 'package:study_hub/model/repository/deck_repository.dart';

void main() {
  Get.put<DeckRepository>(TestDeckRepository());
  Get.put<CachedRepository>(CachedRepoImpl());

  group('Testing Use Cases', () {
    test('Favourite decks should be returned', () async {
      var favourites = await GetFavouritesUseCase.invoke();
      for (var deck in favourites) {
        expect(deck.isFavourite, true);
      }
    });
  });
}
