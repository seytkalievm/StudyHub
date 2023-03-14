import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:study_hub/domain/repository/local/cached_repo_impl.dart';
import 'package:study_hub/domain/repository/remote/test_deck_repository.dart';
import 'package:study_hub/domain/use_case/deck/get_course_name_use_case.dart';
import 'package:study_hub/model/repository/cached_repository.dart';
import 'package:study_hub/model/repository/deck_repository.dart';

void main() {
  Get.put<DeckRepository>(TestDeckRepository());
  Get.put<CachedRepository>(CachedRepoImpl());

  group('Testing Use Cases', () {
    test('Course name should be returned', () async {
      var name = await GetCourseNameUseCase.invoke(1);
      expect(name == "Folder 1", true);
    });

    test('Course name should be returned', () async {
      var name = await GetCourseNameUseCase.invoke(2);
      expect(name == "Folder 2", true);
    });

    test('Course name should be returned', () async {
      var name = await GetCourseNameUseCase.invoke(3);
      expect(name == "Folder 3", true);
    });
  });
}
