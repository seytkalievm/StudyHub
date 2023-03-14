import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../model/models/create_deck.dart';
import 'upload_from_sheet/upload_from_sheet_page.dart';
import 'create_card/add_cards_controller.dart';
import 'upload_from_sheet/upload_from_sheet_controller.dart';
import '../../../domain/use_case/deck/get_folder_list_use_case.dart';
import '../../../model/models/folder.dart';
import 'create_card/add_cards.dart';

class CreateDeckController extends GetxController {
  RxList<Folder> folderList = RxList([Folder(id: 1, name: "math")]);

  CreateDeckController() {
    folderList = GetFolderListUseCase.invoke();

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

  String? courseNameError;
  Folder folder = Folder(id: -1, name: "Course name");

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
    if (folder.id == -1) {
      courseNameError = "Please choose course";
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

  void createCards(bool toSheet) {
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
      folderId: folder.id,
      deckName: _deckName,
      semester: _materialSemester,
    );
    if (toSheet) {
      Get.lazyPut<UploadFromSheetController>(
        () => UploadFromSheetController(deck),
      );
      Get.to(() => const UploadFromSheetPage());
    } else {
      Get.lazyPut<AddCardsController>(() => AddCardsController(deck));
      Get.to(() => const AddCardsPage());
    }

    update();
  }
}
