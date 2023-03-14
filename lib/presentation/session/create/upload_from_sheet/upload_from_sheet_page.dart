import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:study_hub/presentation/util/color_codes.dart';
import 'package:study_hub/presentation/widgets/outlined_text_field.dart';
import 'package:study_hub/presentation/widgets/themed_material_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'upload_from_sheet_controller.dart';

class UploadFromSheetPage extends StatelessWidget {
  const UploadFromSheetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UploadFromSheetController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Create"),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(45, 30, 45, 20),
                  child: const Text(
                    "In order to upload the deck correctly follow the style of the google sheet",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: selectedMenuColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              _condition("The first row is the header"),
              _condition("Column A - Question"),
              _condition("Column B - Question Image"),
              _condition("Column C - Answer"),
              _condition("Columns D:J - Answer Images"),
              Container(
                margin: const EdgeInsets.all(20),
                child: const Text(
                  "To insert the image, choose the cell, go to: Insert -> Image -> Insert image in the cell",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: selectedMenuColor,
                  ),
                ),
              ),
              _link(controller),
              ThemedMaterialButton(
                text: "Upload",
                callback: () {
                  controller.upload();
                },
                color: selectedTabColor,
              ),
              ThemedMaterialButton(
                text: "See Example Sheet",
                callback: () async {
                  Uri url = Uri.parse(
                    "https://docs.google.com/spreadsheets/d/1BVIUaZ2Yach5lDKDN5W9_D7WVNkQzPZs1l3JTQ0R3q0/edit#gid=0",
                  );
                  if (!await launchUrl(url)) {
                    debugPrint("Can't open sheet");
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

  Widget _condition(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 8),
      child: Row(
        children: [
          SvgPicture.asset("assets/icons/create_cards/condition_tick.svg"),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: selectedMenuColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _link(UploadFromSheetController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 30),
          child: const Text(
            "Anyone with the link must be at least Viewer",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: greySecondary,
            ),
          ),
        ),
        OutlinedTextField(
          assetName: "assets/icons/create_cards/link.svg",
          label: "Link",
          error: controller.linkError,
          textFieldController: controller.linkController,
        ),
      ],
    );
  }
}
