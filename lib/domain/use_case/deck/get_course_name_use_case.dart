import 'package:get/get.dart';
import '../../../model/models/resource.dart';
import '../../../model/repository/cached_repository.dart';
import '../../../model/repository/deck_repository.dart';

class GetCourseNameUseCase {
  const GetCourseNameUseCase._();

  static Future<String> invoke(int id) async {
    final DeckRepository remote = Get.find();
    final CachedRepository cacheRepo = Get.find();

    if (cacheRepo.folderList.isNotEmpty) {
      for (var folder in cacheRepo.folderList) {
        if (folder.id == id) {
          return folder.name;
        }
      }
    }

    var response = await remote.getFolderList();
    if (response is Success) {
      for (var folder in response.data!) {
        if (folder.id == id) {
          return folder.name;
        }
      }
    }

    return "Course Name not specified";
  }
}
