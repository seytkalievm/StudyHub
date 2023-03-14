import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_hub/model/models/create_card.dart';
import 'package:study_hub/model/models/create_deck.dart';
import 'package:study_hub/model/models/resource.dart';
import '../../../../domain/use_case/deck/create_deck_use_case.dart';
import '../../../util/color_codes.dart';

class AddCardsController extends GetxController {
  CreateDeck deck;

  AddCardsController(this.deck) {
    addCard();
  }

  List<CreateCard> cardModels = [];

  void addCard() {
    cardModels.add(CreateCard(this));
    update();
  }

  bool validateAll() {
    bool isValid = true;

    for (int i = 0; i < cardModels.length; i++) {
      if (!isFormValid(i)) {
        debugPrint("add_cards_controller Form is not valid");
        isValid = false;
        break;
      }
      update();
    }
    if (isValid) {
      deck.cards = cardModels;

      return true;
    }

    return false;
  }

  bool isFormValid(int i) {
    return cardModels[i].isValid();
  }

  void deleteCard(CreateCard card) {
    cardModels.remove(card);
    update();
  }

  void finish() async {
    if (!validateAll()) return;

    showLoadingIndicator();
    var result = await CreateDeckUseCase.invoke(deck);
    Navigator.of(Get.overlayContext!).pop();

    if (result is Success) {
      showSuccessIndicator();
    } else {
      showErrorIndicator(result.message ?? "Unknown Error");
    }
  }

  void showLoadingIndicator() {
    Get.dialog(
      AlertDialog(
        backgroundColor: mainAppColor,
        title: const Center(
          child: Text(
            "The deck is uploading...",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(color: selectedTabColor),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  void showSuccessIndicator() {
    Get.dialog(
      AlertDialog(
        backgroundColor: mainAppColor,
        title: const Text(
          "Success",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        content: const Text(
          "Deck uploaded successfully",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            child: const Text(
              "Ok",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: selectedTabColor,
              ),
            ),
            onPressed: () {
              Navigator.of(Get.overlayContext!).pop();
              Get.back();
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void showErrorIndicator(String error) {
    Get.dialog(
      AlertDialog(
        backgroundColor: mainAppColor,
        title: const Text(
          "Error",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        content: Text(
          error,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            child: const Text(
              "Try again",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: selectedTabColor,
              ),
            ),
            onPressed: () {
              Navigator.of(Get.overlayContext!).pop();
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
