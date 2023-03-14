import 'package:get/get.dart';
import '../../../model/models/folder.dart';
import '../../../model/models/resource.dart';
import '../../../model/repository/deck_repository.dart';

class GetForYouUseCase {
  const GetForYouUseCase._();

  static Future<List<Folder>> invoke() async {
    DeckRepository repo = Get.find();

    var result = await repo.getForYou();

    if (result is Success) {
      return result.data!;
    }

    return [];
  }
}
