import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:study_hub/domain/repository/local/cached_repo_impl.dart';
import 'package:study_hub/domain/repository/remote/test_deck_repository.dart';
import 'package:study_hub/domain/use_case/deck/get_for_you_use_case.dart';
import 'package:study_hub/model/models/folder.dart';
import 'package:study_hub/model/repository/cached_repository.dart';
import 'package:study_hub/model/repository/deck_repository.dart';

void main() {
  Get.put<DeckRepository>(TestDeckRepository());
  Get.put<CachedRepository>(CachedRepoImpl());

  group('Testing Use Cases', () {
    test('List of folders should be returned', () async {
      var folders = await GetForYouUseCase.invoke();
      for (var i = 0; i < 3; i++) {
        var folder = Folder(id: i + 1, name: "Folder ${i + 1}");
        expect(folders[i] == folder, true);
      }
    });
  });
}
