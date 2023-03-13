import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:study_hub/model/models/resource.dart';
import 'package:study_hub/model/repository/auth_repository.dart';
import 'package:study_hub/model/models/deck.dart';
import 'package:study_hub/model/repository/deck_repository.dart';

class MyDecksController extends GetxController {
  final DeckRepository decksRepo = Get.find();
  final AuthRepository authRepo = Get.find();

  List<Deck>? decks;

  MyDecksController() {
    getDecks();
  }

  void getDecks() async {
    var accessToken = await authRepo.refresh();

    if (accessToken is Fail) return;

    var result = await decksRepo.getDecks(accessToken.data!);

    if (result is Success) {
      decks = result.data!;
      debugPrint(decks.toString());
      update();
    } else {
      debugPrint(result.message);
    }
  }
}
