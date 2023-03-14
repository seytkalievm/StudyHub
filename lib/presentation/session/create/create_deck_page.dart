import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/models/folder.dart';
import '../../widgets/themed_material_button.dart';
import '../../util/color_codes.dart';
import '../../widgets/divider.dart';
import '../../widgets/outlined_text_field.dart';
import 'create_deck_controller.dart';

class CreateDeckPage extends StatelessWidget {
  const CreateDeckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateDeckController>(builder: (controller) {
      void showSnackBar() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              controller.courseNameError.toString(),
            ),
          ),
        );
      }

      return kIsWeb
          ? Scaffold(
              // TODO This is Web. Нужно в отдельный метод запихнуть. Но не смог передать в параметры метода showSnackBar. Поэтому оставил так
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Center(
                  child: SizedBox(
                    width: 320,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 90,
                        ),
                        webCoursesDropdown(controller), //TODO Adjust it for web
                        /*OutlinedTextField(
                          label: "Course name",
                          assetName: "assets/icons/create_page/course_name.svg",
                          textFieldController: controller.courseNameController,
                          error: controller.courseNameError,
                        ),*/
                        OutlinedTextField(
                          label: "Deck name",
                          assetName: "assets/icons/create_page/deck_name.svg",
                          textFieldController: controller.deckNameController,
                          error: controller.deckNameError,
                        ),
                        OutlinedTextField(
                          label: "Semester. ex: Sum21, F21, S21",
                          assetName:
                              "assets/icons/create_page/materials_year.svg",
                          textFieldController:
                              controller.materialSemesterNameController,
                          error: controller.materialSemesterError,
                        ),
                        ThemedMaterialButton(
                          text: "Create Cards",
                          callback: () {
                            controller.createCards(false);
                            if (controller.courseNameError != null) {
                              showSnackBar();
                            }
                          },
                          color: selectedTabColor,
                        ),
                        const ThemedDivider(),
                        ThemedMaterialButton(
                          text: "Upload from google sheet",
                          callback: () {
                            controller.createCards(true);
                            if (controller.courseNameError != null) {
                              showSnackBar();
                            }
                          },
                          color: purpleAppColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Scaffold(
              //TODO This is mobile
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: ListView(
                  children: <Widget>[
                    const SizedBox(
                      height: 22,
                    ),
                    coursesDropdown(controller),
                    OutlinedTextField(
                      label: "Deck name",
                      assetName: "assets/icons/create_page/deck_name.svg",
                      textFieldController: controller.deckNameController,
                      error: controller.deckNameError,
                    ),
                    OutlinedTextField(
                      label: "Semester. ex: Sum21, F21, S21",
                      assetName: "assets/icons/create_page/materials_year.svg",
                      textFieldController:
                          controller.materialSemesterNameController,
                      error: controller.materialSemesterError,
                    ),
                    ThemedMaterialButton(
                      text: "Create Cards",
                      callback: () {
                        controller.createCards(false);
                        if (controller.courseNameError != null) {
                          showSnackBar();
                        }
                      },
                      color: selectedTabColor,
                    ),
                    const ThemedDivider(),
                    ThemedMaterialButton(
                      text: "Upload from google sheet",
                      callback: () {
                        controller.createCards(true);
                        if (controller.courseNameError != null) {
                          showSnackBar();
                        }
                      },
                      color: purpleAppColor,
                    ),
                  ],
                ),
              ),
            );
    });
  }

  Widget coursesDropdown(CreateDeckController controller) {
    return Container(
      alignment: Alignment.center,
      width: Get.width,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Obx(
        () => DropdownButton<Folder>(
          dropdownColor: backgroundDarkBlue,
          value: controller.folderList.isEmpty
              ? Folder(id: -1, name: "name")
              : controller.folderList.first,
          selectedItemBuilder: (BuildContext context) {
            return controller.folderList.map<Widget>((Folder item) {
              return Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(minWidth: Get.width - 80),
                child: Text(
                  controller.folder.name,
                  style: const TextStyle(
                    color: selectedMenuColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }).toList();
          },
          items: controller.folderList
              .map<DropdownMenuItem<Folder>>((Folder value) {
            return DropdownMenuItem<Folder>(
              value: value,
              child: Text(
                value.name,
                style: const TextStyle(
                  color: selectedMenuColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }).toList(),
          onChanged: (Folder? value) {
            controller.folder = value!;
            controller.courseNameError = null;
            debugPrint(controller.folder.name);
            controller.update();
          },
        ),
      ),
    );
  }

  Widget webCoursesDropdown(CreateDeckController controller) {
    return Container(
      alignment: Alignment.center,
      width: Get.width,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Obx(
        () => DropdownButton<Folder>(
          dropdownColor: backgroundDarkBlue,
          value: controller.folderList.isEmpty
              ? Folder(id: -1, name: "name")
              : controller.folderList.first,
          selectedItemBuilder: (BuildContext context) {
            return controller.folderList.map<Widget>((Folder item) {
              return Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(minWidth: 256),
                child: Text(
                  controller.folder.name,
                  style: const TextStyle(
                    color: selectedMenuColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }).toList();
          },
          items: controller.folderList
              .map<DropdownMenuItem<Folder>>((Folder value) {
            return DropdownMenuItem<Folder>(
              value: value,
              child: Text(
                value.name,
                style: const TextStyle(
                  color: selectedMenuColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }).toList(),
          onChanged: (Folder? value) {
            controller.folder = value!;
            controller.courseNameError = null;
            debugPrint(controller.folder.name);
            controller.update();
          },
        ),
      ),
    );
  }
}
