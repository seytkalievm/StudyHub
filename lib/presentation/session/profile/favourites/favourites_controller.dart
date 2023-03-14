import 'package:get/get.dart';
import '../../../../model/models/deck.dart';
import '../../../../domain/use_case/deck/get_favourites_use_case.dart';

class FavouritesController extends GetxController {
  RxList<Deck> decks = RxList();
  bool isLoading = true;

  FavouritesController() {
    getDecks();
  }

  void getDecks() async {
    decks = await GetFavouritesUseCase.invoke();
    isLoading = false;
    update();
  }
}
