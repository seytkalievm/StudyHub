import 'package:get/get.dart';
import '../../../model/models/resource.dart';
import '../../../model/repository/deck_repository.dart';
import '../../../model/models/deck.dart';

class GetFolderDecksUseCase {
  GetFolderDecksUseCase._();

  static Future<List<Deck>> invoke(int folderId) async {
    DeckRepository repo = Get.find();

    var result = await repo.getDecksFromFolder(folderId);
    if (result is Success) {
      return result.data!;
    }

    return [];
  }
}
