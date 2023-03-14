import 'package:get/get.dart';
import '../../../../model/models/deck.dart';
import '../../../../domain/use_case/deck/get_my_decks_use_case.dart';

class MyDecksController extends GetxController {
  RxList<Deck> decks = RxList();
  bool isLoading = true;

  MyDecksController() {
    getDecks();
  }

  void getDecks() async {
    decks = await GetMyDecksUseCase.invoke();
    isLoading = false;
    update();
  }
}
