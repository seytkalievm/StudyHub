import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/themed_material_button.dart';
import '../../widgets/divider.dart';
import '../../widgets/outlined_text_field.dart';
import '../../util/color_codes.dart';
import 'create_deck_controller.dart';

class CreateDeckPage extends StatelessWidget {
  const CreateDeckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateDeckController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 22,
              ),
              OutlinedTextField(
                label: "Course name",
                assetName: "assets/icons/create_page/course_name.svg",
                textFieldController: controller.courseNameController,
                error: controller.courseNameError,
              ),
              OutlinedTextField(
                label: "Deck name",
                assetName: "assets/icons/create_page/deck_name.svg",
                textFieldController: controller.deckNameController,
                error: controller.deckNameError,
              ),
              OutlinedTextField(
                label: "Semester. ex: Sum21, F21, S21",
                assetName: "assets/icons/create_page/materials_year.svg",
                textFieldController: controller.materialSemesterNameController,
                error: controller.materialSemesterError,
              ),
              ThemedMaterialButton(
                text: "Create Cards",
                callback: () {
                  controller.createCards();
                },
                color: selectedTabColor,
              ),
              const ThemedDivider(),
              ThemedMaterialButton(
                text: "Upload from google sheet",
                callback: () {
                  //TODO
                },
                color: purpleAppColor,
              ),
            ],
          ),
        ),
      );
    });
  }
}
