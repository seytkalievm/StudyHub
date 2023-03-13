import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:study_hub/model/models/create_deck.dart';
import 'package:study_hub/presentation/session/create/create_card/add_cards_controller.dart';
import 'create_card/add_cards.dart';

class CreateDeckController extends GetxController {
  CreateDeckController() {
    courseNameController.addListener(() {
      _courseName = courseNameController.text.toString();
      courseNameError = null;
      update();
    });

    deckNameController.addListener(() {
      _deckName = deckNameController.text.toString();
      deckNameError = null;
      update();
    });

    materialSemesterNameController.addListener(() {
      _materialSemester = materialSemesterNameController.text.toString();
      materialSemesterError = null;
      update();
    });
  }

  String _courseName = "";
  String? courseNameError;

  String _deckName = "";
  String? deckNameError;

  String _materialSemester = "";
  String? materialSemesterError;

  bool canProceed = true;

  TextEditingController courseNameController = TextEditingController();
  TextEditingController deckNameController = TextEditingController();
  TextEditingController materialSemesterNameController =
      TextEditingController();

  void _validateCourseName() {
    if (_courseName.isEmpty) {
      courseNameError = "Field cannot be empty";
      canProceed = false;
    }
  }

  void _validateDeckName() {
    if (_deckName.isEmpty) {
      deckNameError = "Field cannot be empty";
      canProceed = false;
    }
  }

  void _validateMaterialSemester() {
    if (_materialSemester.isEmpty) {
      materialSemesterError = "Field cannot be empty";
      canProceed = false;
    } else {
      var fallOrSpringSem = r"^[S|F][\d][\d]";
      var summerSem = r"^[S][u][m][\d][\d]";
      if (RegExp(fallOrSpringSem).hasMatch(_materialSemester) ||
          RegExp(summerSem).hasMatch(_materialSemester)) {
        return;
      } else {
        materialSemesterError = "Invalid format";
        debugPrint(
          "CreateController, validateMaterial: $materialSemesterError",
        );
        canProceed = false;
      }
    }
  }

  void createCards() {
    debugPrint("CreateController, createCards: entered createCards");
    canProceed = true;
    _validateCourseName();
    _validateDeckName();
    _validateMaterialSemester();
    if (!canProceed) {
      update();

      return;
    }
    var deck = CreateDeck(
      folderId: 2,
      deckName: _deckName,
      semester: _materialSemester,
    );
    Get.lazyPut<AddCardsController>(() => AddCardsController(deck));
    Get.to(() => const AddCardsPage());
    update();
  }
}
