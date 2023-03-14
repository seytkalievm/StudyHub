import 'package:get/get.dart';
import '../../../../domain/use_case/deck/get_recent_decks_use_case.dart';
import '../../../../model/models/deck.dart';

class RecentController extends GetxController {
  RxList<Deck> decks = RxList();
  bool isLoading = true;

  RecentController() {
    getDecks();
  }

  void getDecks() async {
    decks = await GetRecentDecksUseCase.invoke();
    isLoading = false;
    update();
  }
}
