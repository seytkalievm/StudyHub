import 'package:get/get.dart';
import 'package:study_hub/model/repository/auth_repository.dart';
import 'package:study_hub/model/models/deck.dart';
import 'package:study_hub/model/repository/deck_repository.dart';
import '../../../../domain/use_case/deck/get_my_decks_use_case.dart';

class MyDecksController extends GetxController {
  final DeckRepository decksRepo = Get.find();
  final AuthRepository authRepo = Get.find();

  RxList<Deck> decks = RxList();

  MyDecksController() {
    getDecks();
  }

  void getDecks() {
    decks = GetMyDecksUseCase.invoke();
  }
}
