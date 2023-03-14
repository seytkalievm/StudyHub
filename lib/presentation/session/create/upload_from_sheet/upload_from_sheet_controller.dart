import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../domain/use_case/deck/create_deck_from_sheet_use_case.dart';
import '../../../../model/models/create_deck.dart';
import '../../../../model/models/resource.dart';
import '../../../util/color_codes.dart';

class UploadFromSheetController extends GetxController {
  CreateDeck deck;
  var _link = "";
  String? linkError;
  TextEditingController linkController = TextEditingController();

  UploadFromSheetController(this.deck) {
    linkController.addListener(() {
      _link = linkController.text.toString();
      linkError = null;
      update();
    });
  }

  void upload() async {
    if (_link.isEmpty) {
      linkError = "Link to the sheet cannot be empty";

      return;
    } else {
      showLoadingIndicator();
      var result = await CreateDeckFromSheetUseCase.invoke(deck, _link);
      Navigator.of(Get.overlayContext!).pop();

      if (result is Success) {
        showSuccessIndicator();
      } else {
        showErrorIndicator(result.message ?? "Unknown Error");
      }
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
