import 'package:get/get.dart';
import 'package:study_hub/model/models/deck.dart';
import '../../../model/models/resource.dart';
import '../../../model/repository/auth_repository.dart';
import '../../../model/repository/deck_repository.dart';

class FavouritesController extends GetxController {
  final DeckRepository decksRepo = Get.find();
  final AuthRepository authRepo = Get.find();

  List<Deck> decks = [];

  FavouritesController() {
    getDecks();
  }

  void getDecks() async {
    var accessToken = await authRepo.refresh();

    if (accessToken is Fail) return;

    var result = await decksRepo.getFavourites(accessToken.data!);

    if (result is Success) {
      decks = result.data!;
      for (var deck in decks) {
        deck.isFavourite = true;
      }
      update();
    }
  }
}
