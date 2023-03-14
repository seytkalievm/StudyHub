import 'package:get/get.dart';
import '../../../domain/use_case/deck/get_folder_decks_use_case.dart';
import '../../../model/models/deck.dart';

class FolderDecksController extends GetxController {
  List<Deck> decks = [];
  bool isEmpty = true;
  bool isLoading = true;

  FolderDecksController(int folderId) {
    getDecks(folderId);
  }

  void getDecks(int folderId) async {
    decks = await GetFolderDecksUseCase.invoke(folderId);
    isEmpty = decks.isEmpty;
    isLoading = false;
    update();
  }
}
