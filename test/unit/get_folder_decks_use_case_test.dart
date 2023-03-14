import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:study_hub/domain/repository/local/cached_repo_impl.dart';
import 'package:study_hub/domain/repository/remote/test_deck_repository.dart';
import 'package:study_hub/domain/use_case/deck/get_folder_decks_use_case.dart';
import 'package:study_hub/model/repository/cached_repository.dart';
import 'package:study_hub/model/repository/deck_repository.dart';

void main() {
  Get.put<DeckRepository>(TestDeckRepository());
  Get.put<CachedRepository>(CachedRepoImpl());

  group('Testing Use Cases', () {
    test('Decks with folder matching folder id should be returned', () async {
      var folderId = 1;
      var decks = await GetFolderDecksUseCase.invoke(folderId);
      for (var deck in decks) {
        expect(deck.folderId == folderId, true);
      }
    });
  });
}
